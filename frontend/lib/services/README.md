# Good Wallet Services


## UserDataService
Interacts with Cloud Firestore to handle user data. Out of many other things it does:
- Initialize and expose `currentUser` to `BaseModel`
- Exposes a stream of the wallet class (a `WalletBalancesModel`) listened to in `BaseModel`
  - This allows to access the users' balances everywhere throughout the app with `model.userWallet`
  - Balances are called: `currentBalance`, `donations`, `transferredToPeers`

## GlobalGivingAPIService
Interacts with the global giving api


