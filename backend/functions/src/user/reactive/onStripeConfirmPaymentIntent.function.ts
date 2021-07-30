import * as functions from 'firebase-functions';
//import admin = require('firebase-admin');

//admin.initializeApp();

const stripe = require('stripe')(functions.config().stripe.testkey); 
// const stripe = require("stripe")(
//    //Add your account test key
// );
//Confirm Payment Intent
exports.onStripeConfirmPaymentIntent = functions.https.onCall((data, context) => {
  console.log("confirm payment intent");
  var intentId = data.paymentIntentId;
  return stripe.paymentIntents.confirm(
    intentId,
    { payment_method: 'pm_card_visa' }
  );
});