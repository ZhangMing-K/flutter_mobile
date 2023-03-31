const String collectionMessageCollection = '''
textKey
userKey
numberOfReactions
authUserReaction{
    user{
      userKey
      firstName
      lastName
    }
    reactionKey
    userKey
    textKey
    reactionKind
}
createdAt
orderedCreatedAt
value
isEncrypted
taggedFiles {
  fileKey
  url
  fileType
}
taggedGiffs {
  giffKey
  remoteId
  url
}
user {
  userKey
  firstName
  lastName
  profilePictureUrl
  avatar {
    avatarKey
    code
    avatarName
  }
  badgeType
  verifiedAt
  lastOnlineAt
  verifiedText
  firstOrderAt
  suspendedAt
}
sharedText {
  value
  orderedCreatedAt
  textKey
  numberOfReactions
  numberOfComments
  textType
  article{
    headline
    summary
    url
    postedAt
    imageUrl
    body
    author
    source
    asset{
      assetKey
      symbol
      pictureUrl
      quote{
        changePercent
        realtimePrice
      }
    }
  }
  order {
    symbol
    asset{
      assetKey
      symbol
      name
      currentPrice
      pictureUrl
    }
    orderKey
    averagePrice
    orderKey
    averageBuyPrice
    averageSellPrice
    positionType
    optionType
    orderSide
    strikePrice
    expirationDate
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
    portfolio {
      brokerName
      authUserRelation {
        mutedAt
        hideAt
        watchedAt
      }
    }
  }
  user {
    userKey
    firstName
    lastName
    profilePictureUrl
    avatar {
      avatarKey
      code
      avatarName
    }
    badgeType
    verifiedAt
    lastOnlineAt
    verifiedText
    firstOrderAt
    suspendedAt
  }
  taggedFiles {
    fileKey
    url
    fileType
  }
  taggedGiffs {
    giffKey
    remoteId
    url
  }
  taggedAssets {
    assetKey
    symbol
    pictureUrl
  }
}
''';
