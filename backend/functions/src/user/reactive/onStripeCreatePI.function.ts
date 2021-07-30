import * as functions from 'firebase-functions';
const stripe = require('stripe')(functions.config().stripe.secret); 

exports.onStripeCreatePI = functions.https.onRequest(async(req, resp)=>{
    const paymentIntent = await stripe.paymentIntents.create(
        {          
            amount: 1999, 
            currency: 'usd'
            //amount: req.query.amount, 
        } 
    );
    if (paymentIntent != null){
        resp.json(
            {
                "paymentIntent": paymentIntent.client_secret
            }
        )
    }
    else {
        console.log('error'); 
    }
})
