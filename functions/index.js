const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();

/* -------------- Stripe Payment ------------------ */

const { Stripe } = require('stripe');
const stripe = new Stripe(functions.config().stripe.secret, {
  apiVersion: '2020-08-27',
});

/**
 * When a user is created, create a Stripe customer object for them.
 *
 * @see https://stripe.com/docs/payments/save-and-reuse#web-create-customer
 */
exports.createStripeCustomer = functions.auth.user().onCreate(async (user) => {
  const customer = await stripe.customers.create({ email: user.email });
  
  const intent = await stripe.setupIntents.create({
    customer: customer.id,
  });
  await db.collection('users').doc(user.uid).update({
    stripe_customer_id: customer.id,
    stripe_setup_secret: intent.client_secret,
  });
  return;
});

/**
 * When a payment document is written on the client,
 * this function is triggered to create a checkout session in Stripe.
 *
 * @see https://stripe.com/docs/payments/accept-a-payment?integration=checkout
 */

// [START create checkout session]

exports.createStripeCheckoutSession = functions.https.onCall(async (data, context) => {
  try {
    const session = await stripe.checkout.sessions.create({
      // todo: add proper payment model
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: data.currency,
            product_data: {
              name: 'Payment to Good Wallet of '.concat(data.recipientName),
            },
            unit_amount: data.amount,
          },
          quantity: 1,
        },
      ],
      mode: 'payment',
      success_url: data.domain.concat('payment-success-view'),
      cancel_url: data.domain.concat('payment-cancel-view'),
    });
    return { sessionId: session.id };
  } catch (error) {
    // We want to capture errors and render them in a user-friendly way, while
    // still logging an exception with StackDriver
    reportError(error, { uid: context.auth.uid, name: context.auth.token.name });
    return { "sessionId": "invalid" };
  }
});

// [END create checkout session]



/* ----------------- Firestore collection getters -----------*/

function getUserSummaryStatisticsDocument(uid) {
  return db.collection("users").doc(uid).collection("statistics").doc("summaryStats");
}


/* -------------- Money Transfers ------------------ */

exports.processMoneyTransfer = functions.https.onCall(async (data, context) => {
  try {

    // Add payment_method here and so to transaction model!
    const { transferDetails, type } = data;

    let doc = await db.collection("transfers").doc();
    data.createdAt = admin.firestore.FieldValue.serverTimestamp();
    data.transferId = doc.id;
    await doc.set(data);

    if (type === "User2User") { // peer 2 peer transfer
      const recipientId = transferDetails["recipientId"];
      const senderId = transferDetails["senderId"];
      const amount = transferDetails["amount"];

      const increment = admin.firestore.FieldValue.increment(amount);
      const docRefRecipient = getUserSummaryStatisticsDocument(recipientId);
      const docRefSender = getUserSummaryStatisticsDocument(senderId);

      const batch = db.batch();
      batch.update(docRefRecipient, {
        currentBalance: increment,
        "moneyTransferStatistics.totalRaised": increment,
        "moneyTransferStatistics.totalRaisedViaPeer2Peer": increment
      });
      batch.update(docRefSender, {
        "moneyTransferStatistics.totalSentToPeers": increment
      });
      await batch.commit();

    }

    if (type === "User2Project") { // Donation

      // TODO: Update causes balance
      const senderId = transferDetails["senderId"];
      const amount = transferDetails["amount"];
      const sourceType = transferDetails["sourceType"];
      const { projectInfo } = data;

      let valueToDeduct;
      if (sourceType === "Bank") valueToDeduct = 0;
      if (sourceType === "GoodWallet") valueToDeduct = -amount;

      updateDonationStatistics(senderId, amount, valueToDeduct, projectInfo);

    }

    if (type === "User2MoneyPool") { // Donation

      // TODO: Update causes balance
      const senderId = transferDetails["senderId"];
      const amount = transferDetails["amount"];
      const { moneyPoolInfo } = data;
      const moneyPoolId = moneyPoolInfo["moneyPoolId"];

      // update contributingUsers array
      let snapshot = await db.collection("moneyPools").doc(moneyPoolId).get();
      if (snapshot.exists) {
        let userList = snapshot.data()['contributingUsers'];
        let newContributingUsers = userList.map(element => {
          if (element["uid"] === senderId) element["contribution"] = element["contribution"] + amount;
          return element;
        });
        const increment = admin.firestore.FieldValue.increment(amount);
        await db.collection("moneyPools").doc(moneyPoolId).update(
          {
            total: increment,
            contributingUsers: newContributingUsers,
          }
        );
      }
    }

    return returnData({ transferId: doc.id });
  } catch (error) {
    reportError(error.message, { transferId: data.transferId });
    return returnError("Something went wrong, error: ".concat(error.message));
  }
}
);

/* -------------- Money Pool Payout ------------------ */

// takes money pool payout data and updates user good wallets.
exports.processMoneyPoolPayout = functions.firestore
  .document('moneyPoolPayouts/{payoutId}')
  .onCreate(async (snap, context) => {
    try {

      // update balances for each user
      const { transfersDetails, moneyPool, deleteMoneyPool } = snap.data();

      // Get a new write batch
      const batch = db.batch();

      let totalAmount = 0;
      transfersDetails.forEach(details => {
        totalAmount = totalAmount + details.amount;
        const increment = admin.firestore.FieldValue.increment(details.amount);
        const docRef = getUserSummaryStatisticsDocument(details.recipientId);
        // update users good wallets
        batch.update(docRef, {
          currentBalance: increment,
          "moneyTransferStatistics.totalRaised": increment,
          "moneyTransferStatistics.totalRaisedViaMoneyPool": increment
        });
      });

      if (deleteMoneyPool === false) {
        const deduct = admin.firestore.FieldValue.increment(-totalAmount);
        const moneyPoolRef = db.collection('moneyPools').doc(moneyPool['moneyPoolId']);
        batch.update(moneyPoolRef, {
          total: deduct,
        });
      }

      await batch.commit();

      // Save money pool payout document in firestore payments collection?
      //db.collection("transfers").add();

      return;
    } catch (error) {
      await snap.ref.set({ error: userFacingMessage(error) }, { merge: true });
      reportError(error.message, { payoutId: context.params.payoutId });
    }

  }
  );


/* ------------------ Update Statistics -------------*/

// update summary statistics in model DonationStatistics
async function updateDonationStatistics(uid, amountToAdd, amountToDeduct, projectInfo) {

  var docRef = getUserSummaryStatisticsDocument(uid);
  var doc = await docRef.get();
  var docData = doc.data();

  console.log('Fetched user statistics document: ', docData);

  // update monthly donations
  monthlyDonations = updateMonthlyDonations(docData["donationStatistics"]["monthlyDonations"], amountToAdd);
  // update supported Projects
  supportedProjects = updateSupportedProjects(docData["donationStatistics"]["supportedProjects"], amountToAdd, projectInfo);

  // update doc Data
  docData["donationStatistics"]["monthlyDonations"] = monthlyDonations;
  docData["donationStatistics"]["supportedProjects"] = supportedProjects;

  docData["currentBalance"] = docData["currentBalance"] + amountToDeduct;
  docData["donationStatistics"]["totalDonations"] = docData["donationStatistics"]["totalDonations"] + amountToAdd;

  console.log('Update user statistics document to: ', docData);
  docRef.update(docData);
}

// update monthly donations array
// Add monthly donation if in same month, otherwise add new element 
// to array
function updateMonthlyDonations(monthlyDonations, donation) {
  var foundMonth = false;
  var d = new Date();
  monthlyDonations.forEach(function (item) {
    var firestoreDate = new Date(parseInt(item.month));
    if (firestoreDate.getFullYear() === d.getFullYear() && firestoreDate.getMonth() === d.getMonth()) {
      console.log("Adding donation to month: ", d.getMonth());
      foundMonth = true;
      item["totalDonations"] = item["totalDonations"] + donation;
    } else {
      console.log("Add new entry to monty donations for monty: ", d.getMonth());
    }
  })
  if (!foundMonth) {
    monthlyDonations.push(
      {
        month: Date.now(), // (parsing the number of seconds that have elapsed since midnight on January 1, 1970, UTC)
        totalDonations: donation
      }
    )
  }
  return monthlyDonations;
}

// update supported projects array
// Add to total donation of supported proejct if project found 
// (has already been donated to), otherwise add new element 
// to array with donation information
function updateSupportedProjects(supportedProjects, donation, projectInfo) {
  foundProject = false;
  supportedProjects.forEach(function (item) {
    if (item["projectInfo"]["id"] === projectInfo["id"]) {
      console.log("Adding donation to this project");
      foundProject = true;
      item["totalDonations"] = item["totalDonations"] + donation;
    } else {
      console.log("Add new entry to supported projects for project: ");
    }
  })
  if (!foundProject) {
    supportedProjects.push(
      {
        projectInfo: projectInfo,
        totalDonations: donation
      }
    );
  }
  return supportedProjects;
}

/* ------------------ Helpers ------------------ */

// Return objects
function returnError(errorMessage) {
  return {
    data: null,
    error: {
      message: errorMessage
    }
  };
}

function returnData(data) {
  return {
    data: data,
    error: null
  };
}

function returnSuccess() {
  return {
    data: null,
    error: null,
  };
}


function reportError(err, context = {}) {
  /* Have simple error logging for now!*/
  // @see https://firebase.google.com/docs/functions/writing-and-viewing-logs
  const errorObj = {
    err: err,
    context: context,
  }
  functions.logger.error("Unkown Error:", errorObj);
}

/**
 * Sanitize the error message for the user.
 */
function userFacingMessage(error) {
  return error.type
    ? error.message
    : 'An error occurred, developers have been alerted';
}