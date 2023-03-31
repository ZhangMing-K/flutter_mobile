import '../../../shared/types/index.dart';
import '../story/story_gql.dart';

String profileSummaryGql({String storyCursor = ''}) {
  return '''
      userKey
      ${storyGql(cursor: storyCursor)}
      firstName
      lastName
      profilePictureUrl
      userPrivacyType
      tradePerformance {
        tradeAccuracy
      }
      mutualFollowedBy(input: {limit: 4}) {
	      total
	      users {
	        firstName
	        lastName
          profilePictureUrl
	      }
	    }
      
      temporarySnapshotHistoricalPoints {
              dayPercent
              weekPercent
              monthPercent
              threeMonthPercent
              yearPercent
              allPercent
      }
      badgeType
      nbrPosts
      nbrOrders
      description
      email
      createdAt
      username
      verifiedAt
      verifiedText
      firstOrderAt
      suspendedAt
      authUserRelation {
        hideAt
        userKey
        entityKey
        watchedAt
        mutedAt
        blockedAt
      }
      integrations(input: {sources: ${getSocialsInput()}}) {
        integrationKey
        source
        username
        token
      }
      authUserFollowInfo {
        followStatus
        until
      }
      followStats{
        numberOfFollowers
        numberFollowing
        numberOfPortfoliosFollowing
        entityType
        lookupKey
      }
    ''';
}
