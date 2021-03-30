enum TransactionType {
  Outgoing, // outgoing of good wallet = donations
  Incoming, // incoming to good wallet = raised money
  InOrOut, // covers both of the above
  TransferredToPeers, // send money to friends wallets
  InOrTransferred // incoming to good wallet or transferred to peers ^= everything in firestore payment collection
}
