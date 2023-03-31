import 'order.dart';

class TextGql {
  static const comments = '''
   comments(input: \$textCommentInput){
              textKey
              value
              textType
              parentKey
              orderedCreatedAt
              numberOfReactions
              authUserReaction{
                user{
                  userKey
                  firstName
                  lastName
                  username
                }
              }
              reactions(input: {limit:3}){
                user{
                  userKey
                  firstName
                  lastName
                  username
                  profilePictureUrl
                }
              }
              taggedFiles {
                fileKey
                fileType
                url
              }
              taggedGiffs {
                giffKey
                remoteId
                url
                giffSource
              }
              user{
                userKey
                firstName
                lastName
                profilePictureUrl
                username
                verifiedAt
                verifiedText
                avatar {
                  avatarKey
                  avatarName
                  code
                  url
                }
              }
            }
''';

  static const historicalFrag = '''
    span
    returnAmount
    returnPercentage
    openAmount
    closeAmount
    historicalType
    points{
      beginsAt
      openAmount
      closeAmount
      spanReturnAmount
      spanReturnPercentage
      volume
    }
''';

  static const userPercentile = '''
      tradePerformanceConnections(input: {segmentTypes: [
        ALL_POSITION_TYPES
      ]
      })
      {
        segmentType
        percentileConnection{
          percentile
        }
      }
''';

  static const feed = '''
textKey
value
parentKey
createdAt
orderedCreatedAt
featuredAt
textType
numberOfReactions
numberOfComments
portfolioKey
authUserInteractedAt
reactions(input: {limit:1}){
  user{
    userKey
    firstName
    lastName
    profilePictureUrl
    verifiedAt
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
authUserRelation {
  hideAt
  userKey
  entityKey
  watchedAt
  savedAt
  mutedAt
  blockedAt
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
user{
  userKey
  firstName
  lastName
  username
  profilePictureUrl
  authUserFollowInfo {
    followStatus
  }
  verifiedAt
  badgeType
  firstOrderAt
  authUserRelation {
    hideAt
    mutedAt
    savedAt
  }
}
order {
  ${OrderGql.order}
}
''';

  static const focusedFeed = '''
textKey
value
parentKey
createdAt
orderedCreatedAt
featuredAt
textType
numberOfReactions
numberOfComments
portfolioKey
authUserInteractedAt
reactions(input: {limit:1}){
  user{
    userKey
    firstName
    lastName
    profilePictureUrl
    verifiedAt
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
authUserRelation {
  hideAt
  userKey
  entityKey
  watchedAt
  savedAt
  mutedAt
  blockedAt
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
user{
  userKey
  firstName
  lastName
  username
  profilePictureUrl
  authUserFollowInfo {
    followStatus
  }
  verifiedAt
  badgeType
  firstOrderAt
  authUserRelation {
    hideAt
    mutedAt
    savedAt
  }
}
order {
  ${OrderGql.order}
}
''';

  static const fullTextWithOutStories = '''
textKey
value
parentKey
createdAt
orderedCreatedAt
featuredAt
textType
numberOfReactions
numberOfComments
numberOfViews
portfolioKey
authUserInteractedAt
reactions(input: {limit:1}){
  user{
    userKey
    firstName
    lastName
    profilePictureUrl
    verifiedAt
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
authUserRelation {
  hideAt
  userKey
  entityKey
  watchedAt
  savedAt
  mutedAt
  blockedAt
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
user{
  userKey
  firstName
  lastName
  username
  profilePictureUrl
  authUserFollowInfo {
    followStatus
  }
  verifiedAt
  badgeType
  firstOrderAt
  authUserRelation {
    hideAt
    mutedAt
    savedAt
  }
}
order {
  ${OrderGql.order}
}
''';
}
