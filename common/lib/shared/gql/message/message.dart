class MessageGql {
  static const recentMessages = '''
nextCursor
newCursor
messages{
  textKey
  createdAt
  orderedCreatedAt
  value
  userKey
  isEncrypted
  sharedText{
    textKey
    value
    user{
      userKey
      firstName
      badgeType
    }
    article{
      articleKey
    }
    order{
      orderKey
      symbol
    }
  }
  user{
    userKey
    firstName
    profilePictureUrl
    badgeType
    avatar {
      avatarKey
      code
      avatarName
    }
    lastOnlineAt
  }
  authUserSeenAt
  collection{
    collectionKey
    collectionType
    numberOfCurrentUsers
    collectionGuardedInfo {
      encryptionCode
    }
    name
    pictureUrl
    description
    authUserRelation{
      seenAt
      relationLocation
      notificationAmount
    }
    currentUsers(input:{limit: 2, excludeAuthUser: true}){
      userKey
      firstName
      lastName
      verifiedAt
      badgeType
      firstOrderAt
      profilePictureUrl
      lastOnlineAt
      authUserRelation{
        seenAt
      }
    }
  }
}
  ''';
}
