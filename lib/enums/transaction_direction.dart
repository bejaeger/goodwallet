enum TransactionDirection {
  InOrOut, // covers both of the above
  TransferredToPeers, // send money to friends wallets
  Donation, // outgoing of good wallet = donations
  Incoming, // incoming to good wallet = raised money
  InOrTransferred, // incoming to good wallet or transferred to peers ^= everything in firestore payment collection. potentially not needed
  Invalid,
  MoneyPoolPayout,
}
