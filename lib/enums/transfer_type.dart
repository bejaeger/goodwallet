enum TransferType {
  Peer2Peer,
  Peer2PeerSent,
  Peer2PeerReceived,
  Donation,
  MoneyPoolPayoutTransfer, // transfers user received from money pools
  MoneyPoolPayout, // captures multiple MoneyPoolPayoutTransfers
  // TODO: Rename to MoneyPoolContributionSent
  MoneyPoolContribution, // transfers the logged in user made to money pools
  MoneyPoolContributionReceived, // transfers the to a specific money pool from all users
  PrepaidFund,
  Commitment,
  All,
  Invalid,
}
