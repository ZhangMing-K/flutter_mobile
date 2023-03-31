class NotificationGql {
  static const followingRequestedFields = '''
followRequestKey
approvedAt
requestedAt
deniedAt
status
followerUser{
  userKey
  firstName
  lastName
  verifiedAt
  badgeType
  firstOrderAt
  authUserFollowInfo {
    followStatus
  }
  profilePictureUrl
}
portfolio{
  portfolioKey
  portfolioName
}
  ''';

  static const requestedFields = '''
notificationKey
lastActionAt
eventHappenedAt
portfolio{
  brokerName
}
hideActionsAt
message
displayMessage
user {
  userKey
  firstName
  lastName
}
actionUser {
  userKey
  firstName
  lastName
  profilePictureUrl
  badgeType
  firstOrderAt
  authUserFollowInfo{
    followStatus
  }
}
user {
  userKey
  firstName
  lastName
  profilePictureUrl
  verifiedAt
  badgeType
  firstOrderAt
  authUserFollowInfo{
    followStatus
  }
}
action{
  actionName
}
text {
  textKey
  textType
  parentKey
}
commentText {
  textKey
  user {
    userKey
    firstName
    lastName
    badgeType
    profilePictureUrl
    authUserFollowInfo{
      followStatus
    }
  }
}
reaction{
  user{
    userKey
    firstName
    lastName
    badgeType
    profilePictureUrl
    authUserFollowInfo{
      followStatus
    }
  }
}
followRequest {
  followRequestKey
  requestedAt
  approvedAt
  deniedAt
  status
  portfolio{
    portfolioKey
    portfolioName
    authUserFollowInfo{
      followStatus
    }
  }
}
portfolio {
  portfolioKey
  portfolioName
  nickname
}
assets{
  assetKey
  symbol
  pictureUrl
}
orders{
  orderKey
  text{
    textKey
  }
}
''';
}
