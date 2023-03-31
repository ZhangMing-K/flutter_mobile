const String portfolioSummaryGql = '''
portfolios{
  portfolioKey
  portfolioName
  brokerName
  portfolioVisibilitySetting
  accountId
  connectionStatus
  temporarySnapshotHistoricalPoints {
                    dayPercent
                    weekPercent
                    monthPercent
                    threeMonthPercent
                    yearPercent
                    allPercent
  }
  user{
    userKey
    profilePictureUrl
    firstName
    lastName
    verifiedAt
    badgeType
  }
  snapshot(input: {mostRecent: true}){
    dayPercent
    weekPercent
    threeMonthPercent
    yearPercent
    allPercent
    lastUpdatedAt
  }
  followStats{
    numberOfFollowers
  }
  authUserFollowInfo{
    followStatus
    until
  }
  authUserRelation {
    hideAt
    mutedAt
    savedAt
    notificationAmount
  }
  orders(input: {limit: 1}) {
    symbol
    asset{
      assetKey
      symbol
      name
      pictureUrl
      currentPrice
    }
    portfolio{
      brokerName
    }
    averagePrice
    positionType
    optionType
    orderSide
    strikePrice
    expirationDate
    averageBuyPrice
    averageSellPrice
    orderGroupUUID
    optionLegGroupId
    profitLoss
    profitLossPercent
    positionEffect
    orderStrategy
    strategyType
    closedAt
    openedAt
    placedAt
    fullfilledAt
  }
  tradeAnalysis(input: {
    unit: TOTAL_GAIN
    positionStatus: ALL_GAINS
    groupBy: PORTFOLIO_TRANSACTION
    between: {start: "2021-01-01"}
    limit: 1
  }) {
    asset{
      assetKey
      symbol
      name
      pictureUrl
      currentPrice
    }
    orderGroupUUIDS
    symbol
    positionTypes
    profitLossTotal
    profitLossPercentTotal
  }
  openPositions(input: {
    orderBy: TOTAL_AMOUNT
    limit: 1
  }) {
    asset{
      assetKey
      symbol
      name
      pictureUrl
      currentPrice
    }
    orderGroupUUIDS
    symbol
    profitLossTotal
    totalCost
    totalAmountOpen
    averageBuyPrice
    profitLossPercentTotal
    expirationDates
  }
}
''';
