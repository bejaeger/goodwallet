import * as functions from 'firebase-functions';
const admin = require("firebase-admin");
//admin.initializeApp();
const db = admin.firestore();

//import stripe from 'stripe';
const stripe = require('stripe')(functions.config().stripe.testkey); 

exports.onStripeUserCreated = functions.auth.user().onCreate(async (user) => {
  const customer = await stripe.customers.create({
    email: user.email,
    description: "My Stripe Email is " + user.email,
  });
  console.log(customer.id);

  const intent = await stripe.setupIntents.create({
    customer: customer.id,
  });
  await db.collection('users').doc(user.uid).update({
    customerId: customer.id,
    stripeSecret: intent.client_secret,
  });
  return;
});
