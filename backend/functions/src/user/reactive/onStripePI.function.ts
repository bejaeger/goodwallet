import * as functions from 'firebase-functions';
const stripe = require('stripe')(functions.config().stripe.secret); 

exports.onStripePI = functions.https.onRequest(async (req: any, res) => {
    const stripeVendorAccount = 'ca_JjcDM5TObnmfICam16ax82ZAYc9S5vaH'; 

    const fee = (req.query.amount/100) | 0;

    const clonedPaymentMethod =  stripe.paymentMethods.create(
        {
          payment_method: req.query.paym,
        }, {
          stripeAccount: stripeVendorAccount
        }); 
        if (clonedPaymentMethod != null){
           
              console.log('clonedPaymentMethod: ', clonedPaymentMethod);
  
              //Strep 4: create a PI on the cloned payment method 
              const paymentIntent =  stripe.paymentIntents.create(
                  {
                    amount: req.query.amount,
                    currency: req.query.currency,
                    payment_method: clonedPaymentMethod.id,
                    confirmation_method: 'automatic',
                    confirm: true,
                    application_fee_amount: fee,
                    description: req.query.description,
                  }, {
                    stripeAccount: stripeVendorAccount
                  },
          );
                
        if  (paymentIntent!= null) {
            // asynchronously called
           // const paymentIntentReference = paymentIntent;
            //Step 5: return to the client error or the PI 
 
              console.log('Created  PI', paymentIntent); 
              res.json({
                  paymentIntent: paymentIntent, 
                  stripeAccount: stripeVendorAccount
              }); 
              return paymentIntent; 
            }
          }

});