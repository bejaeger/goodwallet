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

/* This needs to be changed to onUpdate after the entire stripe transaction has been dealt with! */
exports.processMoneyTransfer = functions.firestore
  .document('payments/{transferId}')
  .onCreate(async (snap, context) => {
    try {
      // Add payment_method here and so to transaction model!
      const { transferDetails, type } = snap.data();

      if (type === "Peer2Peer") { // peer 2 peer transfer
        const recipientId = transferDetails["recipientId"];
        const senderId = transferDetails["recipientId"];
        const amount = transferDetails["amount"];

        const increment = admin.firestore.FieldValue.increment(amount);
        const docRefRecipient = getUserSummaryStatisticsDocument(recipientId);
        await docRefRecipient.update({
          currentBalance: increment,
          "moneyTransferStatistics.totalRaised": increment
        });
        const docRefSender = getUserSummaryStatisticsDocument(senderId);
        await docRefSender.update({
          "moneyTransferStatistics.totalSentToPeers": increment
        });
      }

      if (type === "Donation") { // Donation

        // TODO: Update causes balance
        const senderId = transferDetails["senderId"];
        const amount = transferDetails["amount"];

        const deduct = admin.firestore.FieldValue.increment(-amount);
        const add = admin.firestore.FieldValue.increment(amount);
        const docRef = getUserSummaryStatisticsDocument(senderId);
        await docRef.update({
          currentBalance: deduct,
          "donationStatistics.totalDonations": add
        });
      }

      if (type === "MoneyPoolContribution") { // Donation

        // TODO: Update causes balance
        const senderId = transferDetails["senderId"];
        const amount = transferDetails["amount"];
        const { moneyPoolInfo } = snap.data();
        const moneyPoolId = moneyPoolInfo["moneyPoolId"];

        // update contributingUsers array
        let snapshot = await db.collection("moneypools").doc(moneyPoolId).get();
        if (snapshot.exists) {
          let userList = snapshot.data()['contributingUsers'];
          let newContributingUsers = userList.map(element => {
            if (element["uid"] === senderId) element["contribution"] = element["contribution"] + amount;
            return element;
          });
          const increment = admin.firestore.FieldValue.increment(amount);
          await db.collection("moneypools").doc(moneyPoolId).update(
            {
              total: increment,
              contributingUsers: newContributingUsers,
            }
          );
        }

      }
      return;
    } catch (error) {
      await snap.ref.set({ error: userFacingMessage(error) }, { merge: true });
      reportError(error.message, { transferId: context.params.transferId });
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
          "moneyTransferStatistics.totalRaised": increment
        });
      });

      if (deleteMoneyPool === false) {
        const deduct = admin.firestore.FieldValue.increment(-totalAmount);
        const moneyPoolRef = db.collection('moneypools').doc(moneyPool['moneyPoolId']);
        batch.update(moneyPoolRef, {
          total: deduct,
        });
      }

      await batch.commit();

      // Save money pool payout document in firestore payments collection?
      //db.collection("payments").add();

      return;
    } catch (error) {
      await snap.ref.set({ error: userFacingMessage(error) }, { merge: true });
      reportError(error.message, { payoutId: context.params.payoutId });
    }

  }
  );


/* ------------------ Helpers ------------------ */


/*
 * To keep on top of errors, we should raise a verbose error report with Stackdriver rather
 * than simply relying on console.error. This will calculate users affected + send you email
 * alerts, if you've opted into receiving them.
 * @see https://firebase.google.com/docs/functions/writing-and-viewing-logs
 */

// [START reporterror]

function reportError(err, context = {}) {
  /* Have simple error logging for now!*/
  // @see https://firebase.google.com/docs/functions/writing-and-viewing-logs
  const errorObj = {
    err: err,
    context: context,
  }
  functions.logger.error("Unkown Error:", errorObj);

  /* THE FOLLOWING IS NOT YET WORKING! 
  /* From here:
  https://firebase.google.com/docs/functions/reporting-errors
  */
  /* Look out for tutorials and decide on whether we want this more advanced error logging!
 
  // This is the name of the StackDriver log stream that will receive the log
  // entry. This name can be any valid log stream name, but must contain "err"
  // in order for the error to be picked up by StackDriver Error Reporting.
  const logName = 'errors';
  const log = logging.log(logName);
 
  // https://cloud.google.com/logging/docs/api/ref_v2beta1/rest/v2beta1/MonitoredResource
  const metadata = {
    resource: {
      type: 'cloud_function',
      labels: { function_name: process.env.FUNCTION_NAME },
    },
  };
 
  // https://cloud.google.com/error-reporting/reference/rest/v1beta1/ErrorEvent
  const errorEvent = {
    message: err.stack,
    serviceContext: {
      service: process.env.FUNCTION_NAME,
      resourceType: 'cloud_function',
    },
    context: context,
  };
 
  // Write the error log entry
  return new Promise((resolve, reject) => {
    log.write(log.entry(metadata, errorEvent), (error) => {
      if (error) {
        return reject(error);
      }
      return resolve();
    });
  }); 
  */

}

// // [END reporterror]

/**
 * Sanitize the error message for the user.
 */
function userFacingMessage(error) {
  return error.type
    ? error.message
    : 'An error occurred, developers have been alerted';
}