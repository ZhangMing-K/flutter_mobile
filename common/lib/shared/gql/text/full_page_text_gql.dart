import 'text_without_stories.dart';

String fullsPageTextGql = '''
textKey
value
parentKey
createdAt
orderedCreatedAt
featuredAt
textType
authUserRelation {
  hideAt
  mutedAt
  savedAt
}
taggedGiffs{
  giffKey
  remoteId
  url
}
taggedFiles {
  fileKey
  url
  fileType
}
taggedAssets {
  assetKey
  symbol
  pictureUrl
}
article{
  headline
  summary
  url
  postedAt
  imageUrl
  thumbnailImageUrl
  largeImageUrl
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
reactions(input: {limit:3}){
  user{
    userKey
    firstName
    lastName
    profilePictureUrl
    badgeType
  }
}
authUserReaction{
  user{
    userKey
    firstName
    lastName
    badgeType
  }
}
numberOfReactions
numberOfComments
numberOfViews
authUserInteractedAt
user{
  userKey
  firstName
  lastName
  profilePictureUrl
  verifiedAt
  verifiedText
  firstOrderAt
  authUserFollowInfo {
    followStatus
  }
  badgeType
  storiesConnection(input: {limit: 1}){
    storiesPagination{
      stories{
        $textGqlWithoutStories
      }
      nextCursor
      previousCursor
    }
    metaData{
      nbrStories
      currentIndex
      areStories
      areUnseenStories
    }
  }
}
order{
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
''';
