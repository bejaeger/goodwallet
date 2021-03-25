# Good Wallet Services


## UserDataService
Interacting with Cloud Firestore API to handle user data. Out of many other things it does:
- Initialize and expose current User to `BaseModel`
- Expose a stream of wallet listened to in `BaseModel`
  - This allows to access the wallet balances in any model with `model.userWallet`
  - Balances are called: `currentBalance`, `donations`, `transferredToPeers`

## GlobalGivingAPIService
Interacts with the global giving api

## Todo
Clean-up `FirestorePaymentDataService` and `StripePaymentService`. These will be used to handle the payment procedure.
Additionally a `DummyPaymentService` will be added for testing.

