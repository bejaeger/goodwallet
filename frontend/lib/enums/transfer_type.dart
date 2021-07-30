enum TransferType {
  User2User, // peer 2 peer transfer
  User2UserSent, // (shortcut) for outgoing peer 2 peer from current user
  User2UserReceived, // (shortcut) for incoming peer 2 peer to current user
  User2OwnPrepaidFund, // top-up
  User2OwnGoodWallet, // commitment

  User2Project, // donation
  User2ProjectSent, // (shortcut) outgoing donations from current User

  User2MoneyPool, // transfers the logged in user made to money pools
  MoneyPool2User, // transfers user received from money pools

  MoneyPool2Project, // donation from money pool

  AllInvolvingUser, // incoming or outgoing transfers for current user
  Invalid,
}
