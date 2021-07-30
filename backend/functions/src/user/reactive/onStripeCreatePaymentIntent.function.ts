import * as functions from 'firebase-functions';
const admin = require('firebase-admin');
const db = admin.firestore();
const stripe = require('stripe')(functions.config().stripe.secret); 

//Create User Payment Intent
exports.onStripeCreatePaymentIntent = functions.https.onCall(async (data, context) => {
  console.log("creating Payment Intent");
  const paymentIntent = stripe.paymentIntents.create({
    cu: data.amount,
    currency: data.currency,
    payment_method_types: ["card"]
  });
  await db.collection('payments').doc().set({
    paymentIntent: paymentIntent
  });

});