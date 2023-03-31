import 'package:iris_common/data/models/output/avatar.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/follow_request.dart';
import 'package:iris_common/data/models/output/follow_requests_connection.dart';
import 'package:iris_common/data/models/output/auth_user_follow_info.dart';
import 'package:iris_common/data/models/output/user_relation.dart';
import 'package:iris_common/data/models/output/follow_stats.dart';
import 'package:iris_common/data/models/output/user_stats.dart';
import 'package:iris_common/data/models/output/notification_model.dart';
import 'package:iris_common/data/models/output/user_notification_connection.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:iris_common/data/models/output/stories_connection.dart';
import 'package:iris_common/data/models/enums/user_access_type.dart';
import 'package:iris_common/data/models/output/flag.dart';
import 'package:iris_common/data/models/output/user_settings.dart';
import 'package:iris_common/data/models/output/integration.dart';
import 'package:iris_common/data/models/output/share.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:iris_common/data/models/output/workspace.dart';
import 'package:iris_common/data/models/output/due_diligence.dart';
import 'package:iris_common/data/models/output/user_contact.dart';
import 'package:iris_common/data/models/output/trade_statistics.dart';
import 'package:iris_common/data/models/enums/broker_name.dart';
import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:iris_common/data/models/output/purchase_item.dart';
import 'package:iris_common/data/models/enums/user_privacy_type.dart';
import 'package:iris_common/data/models/output/users_similarity.dart';
import 'package:iris_common/data/models/output/gold_connection.dart';
import 'package:iris_common/data/models/output/iris_pro_connection.dart';
import 'package:iris_common/data/models/output/payment_method.dart';
import 'package:iris_common/data/models/output/mutual_followed_by.dart';
import 'package:iris_common/data/models/output/trade_performance.dart';
import 'package:iris_common/data/models/output/trade_performance_connection.dart';
import 'package:iris_common/data/models/output/percentile_connection.dart';
import 'package:iris_common/data/models/enums/trade_stat_visibility.dart';
import 'package:iris_common/data/models/enums/badge_type.dart';
import 'package:iris_common/data/models/enums/experience_level.dart';
import 'package:iris_common/data/models/enums/user_feature_access.dart';
import 'package:iris_common/data/models/output/user_user.dart';
import 'package:iris_common/data/models/output/auto_pilot_onboarding_connection.dart';
import 'package:iris_common/data/models/output/get_performance_response.dart';
import 'package:iris_common/data/models/output/temporary_snapshot_historical_points.dart';
import 'package:iris_common/data/models/output/positions_get_response.dart';
import 'package:iris_common/data/models/output/positions_summary_get_response.dart';
import 'package:iris_common/data/models/output/waitlist.dart';
import 'package:collection/collection.dart';

class User {
  final int? userKey;
  final User? invitedByUser;
  final String? description;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? subtitle;
  final String? profilePictureUrl;
  final Avatar? avatar;
  final String? email;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? verifiedAt;
  final String? verifiedText;
  final DateTime? suspendedAt;
  final DateTime? deletedAt;
  final List<Portfolio>? portfoliosFollowing;
  final List<Portfolio>? portfolios;
  final List<User>? accountFollowers;
  final List<User>? accountsFollowing;
  final List<User>? advancedAccountsFollowing;
  final List<User>? advancedUsersFollowing;
  final List<FollowRequest>? followRequestsPending;
  final List<FollowRequest>? followRequests;
  final FollowRequestsConnection? followRequestsConnection;
  final AuthUserFollowInfo? authUserFollowInfo;
  final UserRelation? authUserRelation;
  final AuthUserFollowInfo? userFollowingAuthUserInfo;
  final FollowStats? followStats;
  final UserStats? userStats;
  final List<NotificationModel>? notifications;
  final UserNotificationConnection? notificationsConnection;
  final String? inviteLink;
  final List<User>? invitedUsers;
  final List<Asset>? assetsWatching;
  final List<Asset>? watchlist;
  final int? invitedUsersTotalNumber;
  final List<TextModel>? texts;
  final StoriesConnection? storiesConnection;
  final USER_ACCESS_TYPE? userAccessType;
  final List<Flag>? flagsReported;
  final List<Flag>? flagsReportedAgainst;
  final User? suspendedByUser;
  final UserSettings? userSettings;
  final User? deletedByUser;
  final List<Integration>? integrations;
  final List<Share>? shares;
  final List<Order>? orders;
  final DateTime? firstOrderAt;
  final List<Workspace>? workspaces;
  final List<TextModel>? savedTexts;
  final List<DueDiligence>? dueDiligences;
  final List<Workspace>? childWorkspaces;
  final List<UserContact>? userContactsToInvite;
  final List<User>? usersFromContacts;
  final int? nbrUsersFromContacts;
  final int? nbrUserContactsToInvite;
  final TradeStatistics? userTradeStatistics;
  final List<BROKER_NAME>? connectedBrokerNames;
  final int? nbrOrders;
  final int? nbrPosts;
  final int? nbrPortfoliosNotificationsOn;
  final int? nbrUsersTradeNotificationsOn;
  final DateTime? accessAnalyticsAt;
  final DateTime? accessFullFeedAt;
  final DateTime? accessMessagingAt;
  final List<AutoPilotSettings>? autoPilotSettings;
  final List<PurchaseItem>? activeSubscriptions;
  final USER_PRIVACY_TYPE? userPrivacyType;
  final UsersSimilarity? authUserSimilarity;
  final DateTime? lastOnlineAt;
  final bool? tradeNotificationsSnoozed;
  final bool? allNotificationsSnoozed;
  final GoldConnection? goldConnection;
  final bool? isGoldMember;
  final IrisProConnection? irisProConnection;
  final bool? hasInstitutionConnected;
  final int? defaultPaymentMethodKey;
  final PaymentMethod? defaultPaymentMethod;
  final MutualFollowedBy? mutualFollowedBy;
  final int? nbrUnreadMessages;
  final int? nbrUnseenNotifications;
  final TradePerformance? tradePerformance;
  final List<TradePerformance>? tradePerformances;
  final List<TradePerformanceConnection>? tradePerformanceConnections;
  final String? customerRemoteId;
  final String? sellerRemoteId;
  final List<PercentileConnection>? percentileConnection;
  final TRADE_STAT_VISIBILITY? tradeStatVisibility;
  final BADGE_TYPE? badgeType;
  final EXPERIENCE_LEVEL? experienceLevel;
  final List<USER_FEATURE_ACCESS>? featureAccess;
  final List<Asset>? topInterestedAssets;
  final UserUser? authUserUser;
  final double? dailyPercentGain;
  final String? dailySnapshotJson;
  final AutoPilotOnboardingConnection? autoPilotOnboardingConnection;
  final GetPerformanceResponse? performance;
  final TemporarySnapshotHistoricalPoints? temporarySnapshotHistoricalPoints;
  final PositionsGetResponse? irisPositionsConnection;
  final PositionsSummaryGetResponse? positionsSummaryConnection;
  final List<Waitlist>? waitlists;
  final bool? autoPilotOnboardingCompleted;
  final bool? hasActiveAutoPilotSubscription;
  const User(
      {this.userKey,
      this.invitedByUser,
      this.description,
      this.firstName,
      this.lastName,
      this.username,
      this.subtitle,
      this.profilePictureUrl,
      this.avatar,
      this.email,
      this.phoneNumber,
      this.createdAt,
      this.verifiedAt,
      this.verifiedText,
      this.suspendedAt,
      this.deletedAt,
      this.portfoliosFollowing,
      this.portfolios,
      this.accountFollowers,
      this.accountsFollowing,
      this.advancedAccountsFollowing,
      this.advancedUsersFollowing,
      this.followRequestsPending,
      this.followRequests,
      this.followRequestsConnection,
      this.authUserFollowInfo,
      this.authUserRelation,
      this.userFollowingAuthUserInfo,
      this.followStats,
      this.userStats,
      this.notifications,
      this.notificationsConnection,
      this.inviteLink,
      this.invitedUsers,
      this.assetsWatching,
      this.watchlist,
      this.invitedUsersTotalNumber,
      this.texts,
      this.storiesConnection,
      this.userAccessType,
      this.flagsReported,
      this.flagsReportedAgainst,
      this.suspendedByUser,
      this.userSettings,
      this.deletedByUser,
      this.integrations,
      this.shares,
      this.orders,
      this.firstOrderAt,
      this.workspaces,
      this.savedTexts,
      this.dueDiligences,
      this.childWorkspaces,
      this.userContactsToInvite,
      this.usersFromContacts,
      this.nbrUsersFromContacts,
      this.nbrUserContactsToInvite,
      this.userTradeStatistics,
      this.connectedBrokerNames,
      this.nbrOrders,
      this.nbrPosts,
      this.nbrPortfoliosNotificationsOn,
      this.nbrUsersTradeNotificationsOn,
      this.accessAnalyticsAt,
      this.accessFullFeedAt,
      this.accessMessagingAt,
      this.autoPilotSettings,
      this.activeSubscriptions,
      this.userPrivacyType,
      this.authUserSimilarity,
      this.lastOnlineAt,
      this.tradeNotificationsSnoozed,
      this.allNotificationsSnoozed,
      this.goldConnection,
      this.isGoldMember,
      this.irisProConnection,
      this.hasInstitutionConnected,
      this.defaultPaymentMethodKey,
      this.defaultPaymentMethod,
      this.mutualFollowedBy,
      this.nbrUnreadMessages,
      this.nbrUnseenNotifications,
      this.tradePerformance,
      this.tradePerformances,
      this.tradePerformanceConnections,
      this.customerRemoteId,
      this.sellerRemoteId,
      this.percentileConnection,
      this.tradeStatVisibility,
      this.badgeType,
      this.experienceLevel,
      this.featureAccess,
      this.topInterestedAssets,
      this.authUserUser,
      this.dailyPercentGain,
      this.dailySnapshotJson,
      this.autoPilotOnboardingConnection,
      this.performance,
      this.temporarySnapshotHistoricalPoints,
      this.irisPositionsConnection,
      this.positionsSummaryConnection,
      this.waitlists,
      this.autoPilotOnboardingCompleted,
      this.hasActiveAutoPilotSubscription});
  User copyWith(
      {int? userKey,
      User? invitedByUser,
      String? description,
      String? firstName,
      String? lastName,
      String? username,
      String? subtitle,
      String? profilePictureUrl,
      Avatar? avatar,
      String? email,
      String? phoneNumber,
      DateTime? createdAt,
      DateTime? verifiedAt,
      String? verifiedText,
      DateTime? suspendedAt,
      DateTime? deletedAt,
      List<Portfolio>? portfoliosFollowing,
      List<Portfolio>? portfolios,
      List<User>? accountFollowers,
      List<User>? accountsFollowing,
      List<User>? advancedAccountsFollowing,
      List<User>? advancedUsersFollowing,
      List<FollowRequest>? followRequestsPending,
      List<FollowRequest>? followRequests,
      FollowRequestsConnection? followRequestsConnection,
      AuthUserFollowInfo? authUserFollowInfo,
      UserRelation? authUserRelation,
      AuthUserFollowInfo? userFollowingAuthUserInfo,
      FollowStats? followStats,
      UserStats? userStats,
      List<NotificationModel>? notifications,
      UserNotificationConnection? notificationsConnection,
      String? inviteLink,
      List<User>? invitedUsers,
      List<Asset>? assetsWatching,
      List<Asset>? watchlist,
      int? invitedUsersTotalNumber,
      List<TextModel>? texts,
      StoriesConnection? storiesConnection,
      USER_ACCESS_TYPE? userAccessType,
      List<Flag>? flagsReported,
      List<Flag>? flagsReportedAgainst,
      User? suspendedByUser,
      UserSettings? userSettings,
      User? deletedByUser,
      List<Integration>? integrations,
      List<Share>? shares,
      List<Order>? orders,
      DateTime? firstOrderAt,
      List<Workspace>? workspaces,
      List<TextModel>? savedTexts,
      List<DueDiligence>? dueDiligences,
      List<Workspace>? childWorkspaces,
      List<UserContact>? userContactsToInvite,
      List<User>? usersFromContacts,
      int? nbrUsersFromContacts,
      int? nbrUserContactsToInvite,
      TradeStatistics? userTradeStatistics,
      List<BROKER_NAME>? connectedBrokerNames,
      int? nbrOrders,
      int? nbrPosts,
      int? nbrPortfoliosNotificationsOn,
      int? nbrUsersTradeNotificationsOn,
      DateTime? accessAnalyticsAt,
      DateTime? accessFullFeedAt,
      DateTime? accessMessagingAt,
      List<AutoPilotSettings>? autoPilotSettings,
      List<PurchaseItem>? activeSubscriptions,
      USER_PRIVACY_TYPE? userPrivacyType,
      UsersSimilarity? authUserSimilarity,
      DateTime? lastOnlineAt,
      bool? tradeNotificationsSnoozed,
      bool? allNotificationsSnoozed,
      GoldConnection? goldConnection,
      bool? isGoldMember,
      IrisProConnection? irisProConnection,
      bool? hasInstitutionConnected,
      int? defaultPaymentMethodKey,
      PaymentMethod? defaultPaymentMethod,
      MutualFollowedBy? mutualFollowedBy,
      int? nbrUnreadMessages,
      int? nbrUnseenNotifications,
      TradePerformance? tradePerformance,
      List<TradePerformance>? tradePerformances,
      List<TradePerformanceConnection>? tradePerformanceConnections,
      String? customerRemoteId,
      String? sellerRemoteId,
      List<PercentileConnection>? percentileConnection,
      TRADE_STAT_VISIBILITY? tradeStatVisibility,
      BADGE_TYPE? badgeType,
      EXPERIENCE_LEVEL? experienceLevel,
      List<USER_FEATURE_ACCESS>? featureAccess,
      List<Asset>? topInterestedAssets,
      UserUser? authUserUser,
      double? dailyPercentGain,
      String? dailySnapshotJson,
      AutoPilotOnboardingConnection? autoPilotOnboardingConnection,
      GetPerformanceResponse? performance,
      TemporarySnapshotHistoricalPoints? temporarySnapshotHistoricalPoints,
      PositionsGetResponse? irisPositionsConnection,
      PositionsSummaryGetResponse? positionsSummaryConnection,
      List<Waitlist>? waitlists,
      bool? autoPilotOnboardingCompleted,
      bool? hasActiveAutoPilotSubscription}) {
    return User(
      userKey: userKey ?? this.userKey,
      invitedByUser: invitedByUser ?? this.invitedByUser,
      description: description ?? this.description,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      subtitle: subtitle ?? this.subtitle,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      verifiedText: verifiedText ?? this.verifiedText,
      suspendedAt: suspendedAt ?? this.suspendedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      portfoliosFollowing: portfoliosFollowing ?? this.portfoliosFollowing,
      portfolios: portfolios ?? this.portfolios,
      accountFollowers: accountFollowers ?? this.accountFollowers,
      accountsFollowing: accountsFollowing ?? this.accountsFollowing,
      advancedAccountsFollowing:
          advancedAccountsFollowing ?? this.advancedAccountsFollowing,
      advancedUsersFollowing:
          advancedUsersFollowing ?? this.advancedUsersFollowing,
      followRequestsPending:
          followRequestsPending ?? this.followRequestsPending,
      followRequests: followRequests ?? this.followRequests,
      followRequestsConnection:
          followRequestsConnection ?? this.followRequestsConnection,
      authUserFollowInfo: authUserFollowInfo ?? this.authUserFollowInfo,
      authUserRelation: authUserRelation ?? this.authUserRelation,
      userFollowingAuthUserInfo:
          userFollowingAuthUserInfo ?? this.userFollowingAuthUserInfo,
      followStats: followStats ?? this.followStats,
      userStats: userStats ?? this.userStats,
      notifications: notifications ?? this.notifications,
      notificationsConnection:
          notificationsConnection ?? this.notificationsConnection,
      inviteLink: inviteLink ?? this.inviteLink,
      invitedUsers: invitedUsers ?? this.invitedUsers,
      assetsWatching: assetsWatching ?? this.assetsWatching,
      watchlist: watchlist ?? this.watchlist,
      invitedUsersTotalNumber:
          invitedUsersTotalNumber ?? this.invitedUsersTotalNumber,
      texts: texts ?? this.texts,
      storiesConnection: storiesConnection ?? this.storiesConnection,
      userAccessType: userAccessType ?? this.userAccessType,
      flagsReported: flagsReported ?? this.flagsReported,
      flagsReportedAgainst: flagsReportedAgainst ?? this.flagsReportedAgainst,
      suspendedByUser: suspendedByUser ?? this.suspendedByUser,
      userSettings: userSettings ?? this.userSettings,
      deletedByUser: deletedByUser ?? this.deletedByUser,
      integrations: integrations ?? this.integrations,
      shares: shares ?? this.shares,
      orders: orders ?? this.orders,
      firstOrderAt: firstOrderAt ?? this.firstOrderAt,
      workspaces: workspaces ?? this.workspaces,
      savedTexts: savedTexts ?? this.savedTexts,
      dueDiligences: dueDiligences ?? this.dueDiligences,
      childWorkspaces: childWorkspaces ?? this.childWorkspaces,
      userContactsToInvite: userContactsToInvite ?? this.userContactsToInvite,
      usersFromContacts: usersFromContacts ?? this.usersFromContacts,
      nbrUsersFromContacts: nbrUsersFromContacts ?? this.nbrUsersFromContacts,
      nbrUserContactsToInvite:
          nbrUserContactsToInvite ?? this.nbrUserContactsToInvite,
      userTradeStatistics: userTradeStatistics ?? this.userTradeStatistics,
      connectedBrokerNames: connectedBrokerNames ?? this.connectedBrokerNames,
      nbrOrders: nbrOrders ?? this.nbrOrders,
      nbrPosts: nbrPosts ?? this.nbrPosts,
      nbrPortfoliosNotificationsOn:
          nbrPortfoliosNotificationsOn ?? this.nbrPortfoliosNotificationsOn,
      nbrUsersTradeNotificationsOn:
          nbrUsersTradeNotificationsOn ?? this.nbrUsersTradeNotificationsOn,
      accessAnalyticsAt: accessAnalyticsAt ?? this.accessAnalyticsAt,
      accessFullFeedAt: accessFullFeedAt ?? this.accessFullFeedAt,
      accessMessagingAt: accessMessagingAt ?? this.accessMessagingAt,
      autoPilotSettings: autoPilotSettings ?? this.autoPilotSettings,
      activeSubscriptions: activeSubscriptions ?? this.activeSubscriptions,
      userPrivacyType: userPrivacyType ?? this.userPrivacyType,
      authUserSimilarity: authUserSimilarity ?? this.authUserSimilarity,
      lastOnlineAt: lastOnlineAt ?? this.lastOnlineAt,
      tradeNotificationsSnoozed:
          tradeNotificationsSnoozed ?? this.tradeNotificationsSnoozed,
      allNotificationsSnoozed:
          allNotificationsSnoozed ?? this.allNotificationsSnoozed,
      goldConnection: goldConnection ?? this.goldConnection,
      isGoldMember: isGoldMember ?? this.isGoldMember,
      irisProConnection: irisProConnection ?? this.irisProConnection,
      hasInstitutionConnected:
          hasInstitutionConnected ?? this.hasInstitutionConnected,
      defaultPaymentMethodKey:
          defaultPaymentMethodKey ?? this.defaultPaymentMethodKey,
      defaultPaymentMethod: defaultPaymentMethod ?? this.defaultPaymentMethod,
      mutualFollowedBy: mutualFollowedBy ?? this.mutualFollowedBy,
      nbrUnreadMessages: nbrUnreadMessages ?? this.nbrUnreadMessages,
      nbrUnseenNotifications:
          nbrUnseenNotifications ?? this.nbrUnseenNotifications,
      tradePerformance: tradePerformance ?? this.tradePerformance,
      tradePerformances: tradePerformances ?? this.tradePerformances,
      tradePerformanceConnections:
          tradePerformanceConnections ?? this.tradePerformanceConnections,
      customerRemoteId: customerRemoteId ?? this.customerRemoteId,
      sellerRemoteId: sellerRemoteId ?? this.sellerRemoteId,
      percentileConnection: percentileConnection ?? this.percentileConnection,
      tradeStatVisibility: tradeStatVisibility ?? this.tradeStatVisibility,
      badgeType: badgeType ?? this.badgeType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      featureAccess: featureAccess ?? this.featureAccess,
      topInterestedAssets: topInterestedAssets ?? this.topInterestedAssets,
      authUserUser: authUserUser ?? this.authUserUser,
      dailyPercentGain: dailyPercentGain ?? this.dailyPercentGain,
      dailySnapshotJson: dailySnapshotJson ?? this.dailySnapshotJson,
      autoPilotOnboardingConnection:
          autoPilotOnboardingConnection ?? this.autoPilotOnboardingConnection,
      performance: performance ?? this.performance,
      temporarySnapshotHistoricalPoints: temporarySnapshotHistoricalPoints ??
          this.temporarySnapshotHistoricalPoints,
      irisPositionsConnection:
          irisPositionsConnection ?? this.irisPositionsConnection,
      positionsSummaryConnection:
          positionsSummaryConnection ?? this.positionsSummaryConnection,
      waitlists: waitlists ?? this.waitlists,
      autoPilotOnboardingCompleted:
          autoPilotOnboardingCompleted ?? this.autoPilotOnboardingCompleted,
      hasActiveAutoPilotSubscription:
          hasActiveAutoPilotSubscription ?? this.hasActiveAutoPilotSubscription,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userKey: json['userKey'],
      invitedByUser: json['invitedByUser'] != null
          ? User.fromJson(json['invitedByUser'])
          : null,
      description: json['description'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      subtitle: json['subtitle'],
      profilePictureUrl: json['profilePictureUrl'],
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'])
          : null,
      verifiedText: json['verifiedText'],
      suspendedAt: json['suspendedAt'] != null
          ? DateTime.parse(json['suspendedAt'])
          : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      portfoliosFollowing: json['portfoliosFollowing']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
      portfolios: json['portfolios']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
      accountFollowers:
          json['accountFollowers']?.map<User>((o) => User.fromJson(o)).toList(),
      accountsFollowing: json['accountsFollowing']
          ?.map<User>((o) => User.fromJson(o))
          .toList(),
      advancedAccountsFollowing: json['advancedAccountsFollowing']
          ?.map<User>((o) => User.fromJson(o))
          .toList(),
      advancedUsersFollowing: json['advancedUsersFollowing']
          ?.map<User>((o) => User.fromJson(o))
          .toList(),
      followRequestsPending: json['followRequestsPending']
          ?.map<FollowRequest>((o) => FollowRequest.fromJson(o))
          .toList(),
      followRequests: json['followRequests']
          ?.map<FollowRequest>((o) => FollowRequest.fromJson(o))
          .toList(),
      followRequestsConnection: json['followRequestsConnection'] != null
          ? FollowRequestsConnection.fromJson(json['followRequestsConnection'])
          : null,
      authUserFollowInfo: json['authUserFollowInfo'] != null
          ? AuthUserFollowInfo.fromJson(json['authUserFollowInfo'])
          : null,
      authUserRelation: json['authUserRelation'] != null
          ? UserRelation.fromJson(json['authUserRelation'])
          : null,
      userFollowingAuthUserInfo: json['userFollowingAuthUserInfo'] != null
          ? AuthUserFollowInfo.fromJson(json['userFollowingAuthUserInfo'])
          : null,
      followStats: json['followStats'] != null
          ? FollowStats.fromJson(json['followStats'])
          : null,
      userStats: json['userStats'] != null
          ? UserStats.fromJson(json['userStats'])
          : null,
      notifications: json['notifications']
          ?.map<NotificationModel>((o) => NotificationModel.fromJson(o))
          .toList(),
      notificationsConnection: json['notificationsConnection'] != null
          ? UserNotificationConnection.fromJson(json['notificationsConnection'])
          : null,
      inviteLink: json['inviteLink'],
      invitedUsers:
          json['invitedUsers']?.map<User>((o) => User.fromJson(o)).toList(),
      assetsWatching:
          json['assetsWatching']?.map<Asset>((o) => Asset.fromJson(o)).toList(),
      watchlist:
          json['watchlist']?.map<Asset>((o) => Asset.fromJson(o)).toList(),
      invitedUsersTotalNumber: json['invitedUsersTotalNumber'],
      texts:
          json['texts']?.map<TextModel>((o) => TextModel.fromJson(o)).toList(),
      storiesConnection: json['storiesConnection'] != null
          ? StoriesConnection.fromJson(json['storiesConnection'])
          : null,
      userAccessType: json['userAccessType'] != null
          ? USER_ACCESS_TYPE.values.byName(json['userAccessType'])
          : null,
      flagsReported:
          json['flagsReported']?.map<Flag>((o) => Flag.fromJson(o)).toList(),
      flagsReportedAgainst: json['flagsReportedAgainst']
          ?.map<Flag>((o) => Flag.fromJson(o))
          .toList(),
      suspendedByUser: json['suspendedByUser'] != null
          ? User.fromJson(json['suspendedByUser'])
          : null,
      userSettings: json['userSettings'] != null
          ? UserSettings.fromJson(json['userSettings'])
          : null,
      deletedByUser: json['deletedByUser'] != null
          ? User.fromJson(json['deletedByUser'])
          : null,
      integrations: json['integrations']
          ?.map<Integration>((o) => Integration.fromJson(o))
          .toList(),
      shares: json['shares']?.map<Share>((o) => Share.fromJson(o)).toList(),
      orders: json['orders']?.map<Order>((o) => Order.fromJson(o)).toList(),
      firstOrderAt: json['firstOrderAt'] != null
          ? DateTime.parse(json['firstOrderAt'])
          : null,
      workspaces: json['workspaces']
          ?.map<Workspace>((o) => Workspace.fromJson(o))
          .toList(),
      savedTexts: json['savedTexts']
          ?.map<TextModel>((o) => TextModel.fromJson(o))
          .toList(),
      dueDiligences: json['dueDiligences']
          ?.map<DueDiligence>((o) => DueDiligence.fromJson(o))
          .toList(),
      childWorkspaces: json['childWorkspaces']
          ?.map<Workspace>((o) => Workspace.fromJson(o))
          .toList(),
      userContactsToInvite: json['userContactsToInvite']
          ?.map<UserContact>((o) => UserContact.fromJson(o))
          .toList(),
      usersFromContacts: json['usersFromContacts']
          ?.map<User>((o) => User.fromJson(o))
          .toList(),
      nbrUsersFromContacts: json['nbrUsersFromContacts'],
      nbrUserContactsToInvite: json['nbrUserContactsToInvite'],
      userTradeStatistics: json['userTradeStatistics'] != null
          ? TradeStatistics.fromJson(json['userTradeStatistics'])
          : null,
      connectedBrokerNames: json['connectedBrokerNames']
          ?.map<BROKER_NAME>((o) => BROKER_NAME.values.byName(o))
          .toList(),
      nbrOrders: json['nbrOrders'],
      nbrPosts: json['nbrPosts'],
      nbrPortfoliosNotificationsOn: json['nbrPortfoliosNotificationsOn'],
      nbrUsersTradeNotificationsOn: json['nbrUsersTradeNotificationsOn'],
      accessAnalyticsAt: json['accessAnalyticsAt'] != null
          ? DateTime.parse(json['accessAnalyticsAt'])
          : null,
      accessFullFeedAt: json['accessFullFeedAt'] != null
          ? DateTime.parse(json['accessFullFeedAt'])
          : null,
      accessMessagingAt: json['accessMessagingAt'] != null
          ? DateTime.parse(json['accessMessagingAt'])
          : null,
      autoPilotSettings: json['autoPilotSettings']
          ?.map<AutoPilotSettings>((o) => AutoPilotSettings.fromJson(o))
          .toList(),
      activeSubscriptions: json['activeSubscriptions']
          ?.map<PurchaseItem>((o) => PurchaseItem.fromJson(o))
          .toList(),
      userPrivacyType: json['userPrivacyType'] != null
          ? USER_PRIVACY_TYPE.values.byName(json['userPrivacyType'])
          : null,
      authUserSimilarity: json['authUserSimilarity'] != null
          ? UsersSimilarity.fromJson(json['authUserSimilarity'])
          : null,
      lastOnlineAt: json['lastOnlineAt'] != null
          ? DateTime.parse(json['lastOnlineAt'])
          : null,
      tradeNotificationsSnoozed: json['tradeNotificationsSnoozed'],
      allNotificationsSnoozed: json['allNotificationsSnoozed'],
      goldConnection: json['goldConnection'] != null
          ? GoldConnection.fromJson(json['goldConnection'])
          : null,
      isGoldMember: json['isGoldMember'],
      irisProConnection: json['irisProConnection'] != null
          ? IrisProConnection.fromJson(json['irisProConnection'])
          : null,
      hasInstitutionConnected: json['hasInstitutionConnected'],
      defaultPaymentMethodKey: json['defaultPaymentMethodKey'],
      defaultPaymentMethod: json['defaultPaymentMethod'] != null
          ? PaymentMethod.fromJson(json['defaultPaymentMethod'])
          : null,
      mutualFollowedBy: json['mutualFollowedBy'] != null
          ? MutualFollowedBy.fromJson(json['mutualFollowedBy'])
          : null,
      nbrUnreadMessages: json['nbrUnreadMessages'],
      nbrUnseenNotifications: json['nbrUnseenNotifications'],
      tradePerformance: json['tradePerformance'] != null
          ? TradePerformance.fromJson(json['tradePerformance'])
          : null,
      tradePerformances: json['tradePerformances']
          ?.map<TradePerformance>((o) => TradePerformance.fromJson(o))
          .toList(),
      tradePerformanceConnections: json['tradePerformanceConnections']
          ?.map<TradePerformanceConnection>(
              (o) => TradePerformanceConnection.fromJson(o))
          .toList(),
      customerRemoteId: json['customerRemoteId'],
      sellerRemoteId: json['sellerRemoteId'],
      percentileConnection: json['percentileConnection']
          ?.map<PercentileConnection>((o) => PercentileConnection.fromJson(o))
          .toList(),
      tradeStatVisibility: json['tradeStatVisibility'] != null
          ? TRADE_STAT_VISIBILITY.values.byName(json['tradeStatVisibility'])
          : null,
      badgeType: json['badgeType'] != null
          ? BADGE_TYPE.values.byName(json['badgeType'])
          : null,
      experienceLevel: json['experienceLevel'] != null
          ? EXPERIENCE_LEVEL.values.byName(json['experienceLevel'])
          : null,
      featureAccess: json['featureAccess']
          ?.map<USER_FEATURE_ACCESS>(
              (o) => USER_FEATURE_ACCESS.values.byName(o))
          .toList(),
      topInterestedAssets: json['topInterestedAssets']
          ?.map<Asset>((o) => Asset.fromJson(o))
          .toList(),
      authUserUser: json['authUserUser'] != null
          ? UserUser.fromJson(json['authUserUser'])
          : null,
      dailyPercentGain: json['dailyPercentGain']?.toDouble(),
      dailySnapshotJson: json['dailySnapshotJson'],
      autoPilotOnboardingConnection:
          json['autoPilotOnboardingConnection'] != null
              ? AutoPilotOnboardingConnection.fromJson(
                  json['autoPilotOnboardingConnection'])
              : null,
      performance: json['performance'] != null
          ? GetPerformanceResponse.fromJson(json['performance'])
          : null,
      temporarySnapshotHistoricalPoints:
          json['temporarySnapshotHistoricalPoints'] != null
              ? TemporarySnapshotHistoricalPoints.fromJson(
                  json['temporarySnapshotHistoricalPoints'])
              : null,
      irisPositionsConnection: json['irisPositionsConnection'] != null
          ? PositionsGetResponse.fromJson(json['irisPositionsConnection'])
          : null,
      positionsSummaryConnection: json['positionsSummaryConnection'] != null
          ? PositionsSummaryGetResponse.fromJson(
              json['positionsSummaryConnection'])
          : null,
      waitlists: json['waitlists']
          ?.map<Waitlist>((o) => Waitlist.fromJson(o))
          .toList(),
      autoPilotOnboardingCompleted: json['autoPilotOnboardingCompleted'],
      hasActiveAutoPilotSubscription: json['hasActiveAutoPilotSubscription'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['invitedByUser'] = invitedByUser?.toJson();
    data['description'] = description;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;
    data['subtitle'] = subtitle;
    data['profilePictureUrl'] = profilePictureUrl;
    data['avatar'] = avatar?.toJson();
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['createdAt'] = createdAt?.toString();
    data['verifiedAt'] = verifiedAt?.toString();
    data['verifiedText'] = verifiedText;
    data['suspendedAt'] = suspendedAt?.toString();
    data['deletedAt'] = deletedAt?.toString();
    data['portfoliosFollowing'] =
        portfoliosFollowing?.map((item) => item.toJson()).toList();
    data['portfolios'] = portfolios?.map((item) => item.toJson()).toList();
    data['accountFollowers'] =
        accountFollowers?.map((item) => item.toJson()).toList();
    data['accountsFollowing'] =
        accountsFollowing?.map((item) => item.toJson()).toList();
    data['advancedAccountsFollowing'] =
        advancedAccountsFollowing?.map((item) => item.toJson()).toList();
    data['advancedUsersFollowing'] =
        advancedUsersFollowing?.map((item) => item.toJson()).toList();
    data['followRequestsPending'] =
        followRequestsPending?.map((item) => item.toJson()).toList();
    data['followRequests'] =
        followRequests?.map((item) => item.toJson()).toList();
    data['followRequestsConnection'] = followRequestsConnection?.toJson();
    data['authUserFollowInfo'] = authUserFollowInfo?.toJson();
    data['authUserRelation'] = authUserRelation?.toJson();
    data['userFollowingAuthUserInfo'] = userFollowingAuthUserInfo?.toJson();
    data['followStats'] = followStats?.toJson();
    data['userStats'] = userStats?.toJson();
    data['notifications'] =
        notifications?.map((item) => item.toJson()).toList();
    data['notificationsConnection'] = notificationsConnection?.toJson();
    data['inviteLink'] = inviteLink;
    data['invitedUsers'] = invitedUsers?.map((item) => item.toJson()).toList();
    data['assetsWatching'] =
        assetsWatching?.map((item) => item.toJson()).toList();
    data['watchlist'] = watchlist?.map((item) => item.toJson()).toList();
    data['invitedUsersTotalNumber'] = invitedUsersTotalNumber;
    data['texts'] = texts?.map((item) => item.toJson()).toList();
    data['storiesConnection'] = storiesConnection?.toJson();
    data['userAccessType'] = userAccessType?.name;
    data['flagsReported'] =
        flagsReported?.map((item) => item.toJson()).toList();
    data['flagsReportedAgainst'] =
        flagsReportedAgainst?.map((item) => item.toJson()).toList();
    data['suspendedByUser'] = suspendedByUser?.toJson();
    data['userSettings'] = userSettings?.toJson();
    data['deletedByUser'] = deletedByUser?.toJson();
    data['integrations'] = integrations?.map((item) => item.toJson()).toList();
    data['shares'] = shares?.map((item) => item.toJson()).toList();
    data['orders'] = orders?.map((item) => item.toJson()).toList();
    data['firstOrderAt'] = firstOrderAt?.toString();
    data['workspaces'] = workspaces?.map((item) => item.toJson()).toList();
    data['savedTexts'] = savedTexts?.map((item) => item.toJson()).toList();
    data['dueDiligences'] =
        dueDiligences?.map((item) => item.toJson()).toList();
    data['childWorkspaces'] =
        childWorkspaces?.map((item) => item.toJson()).toList();
    data['userContactsToInvite'] =
        userContactsToInvite?.map((item) => item.toJson()).toList();
    data['usersFromContacts'] =
        usersFromContacts?.map((item) => item.toJson()).toList();
    data['nbrUsersFromContacts'] = nbrUsersFromContacts;
    data['nbrUserContactsToInvite'] = nbrUserContactsToInvite;
    data['userTradeStatistics'] = userTradeStatistics?.toJson();
    data['connectedBrokerNames'] =
        connectedBrokerNames?.map((item) => item.name).toList();
    data['nbrOrders'] = nbrOrders;
    data['nbrPosts'] = nbrPosts;
    data['nbrPortfoliosNotificationsOn'] = nbrPortfoliosNotificationsOn;
    data['nbrUsersTradeNotificationsOn'] = nbrUsersTradeNotificationsOn;
    data['accessAnalyticsAt'] = accessAnalyticsAt?.toString();
    data['accessFullFeedAt'] = accessFullFeedAt?.toString();
    data['accessMessagingAt'] = accessMessagingAt?.toString();
    data['autoPilotSettings'] =
        autoPilotSettings?.map((item) => item.toJson()).toList();
    data['activeSubscriptions'] =
        activeSubscriptions?.map((item) => item.toJson()).toList();
    data['userPrivacyType'] = userPrivacyType?.name;
    data['authUserSimilarity'] = authUserSimilarity?.toJson();
    data['lastOnlineAt'] = lastOnlineAt?.toString();
    data['tradeNotificationsSnoozed'] = tradeNotificationsSnoozed;
    data['allNotificationsSnoozed'] = allNotificationsSnoozed;
    data['goldConnection'] = goldConnection?.toJson();
    data['isGoldMember'] = isGoldMember;
    data['irisProConnection'] = irisProConnection?.toJson();
    data['hasInstitutionConnected'] = hasInstitutionConnected;
    data['defaultPaymentMethodKey'] = defaultPaymentMethodKey;
    data['defaultPaymentMethod'] = defaultPaymentMethod?.toJson();
    data['mutualFollowedBy'] = mutualFollowedBy?.toJson();
    data['nbrUnreadMessages'] = nbrUnreadMessages;
    data['nbrUnseenNotifications'] = nbrUnseenNotifications;
    data['tradePerformance'] = tradePerformance?.toJson();
    data['tradePerformances'] =
        tradePerformances?.map((item) => item.toJson()).toList();
    data['tradePerformanceConnections'] =
        tradePerformanceConnections?.map((item) => item.toJson()).toList();
    data['customerRemoteId'] = customerRemoteId;
    data['sellerRemoteId'] = sellerRemoteId;
    data['percentileConnection'] =
        percentileConnection?.map((item) => item.toJson()).toList();
    data['tradeStatVisibility'] = tradeStatVisibility?.name;
    data['badgeType'] = badgeType?.name;
    data['experienceLevel'] = experienceLevel?.name;
    data['featureAccess'] = featureAccess?.map((item) => item.name).toList();
    data['topInterestedAssets'] =
        topInterestedAssets?.map((item) => item.toJson()).toList();
    data['authUserUser'] = authUserUser?.toJson();
    data['dailyPercentGain'] = dailyPercentGain;
    data['dailySnapshotJson'] = dailySnapshotJson;
    data['autoPilotOnboardingConnection'] =
        autoPilotOnboardingConnection?.toJson();
    data['performance'] = performance?.toJson();
    data['temporarySnapshotHistoricalPoints'] =
        temporarySnapshotHistoricalPoints?.toJson();
    data['irisPositionsConnection'] = irisPositionsConnection?.toJson();
    data['positionsSummaryConnection'] = positionsSummaryConnection?.toJson();
    data['waitlists'] = waitlists?.map((item) => item.toJson()).toList();
    data['autoPilotOnboardingCompleted'] = autoPilotOnboardingCompleted;
    data['hasActiveAutoPilotSubscription'] = hasActiveAutoPilotSubscription;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is User &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.invitedByUser, invitedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.invitedByUser, invitedByUser)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.subtitle, subtitle) ||
                const DeepCollectionEquality()
                    .equals(other.subtitle, subtitle)) &&
            (identical(other.profilePictureUrl, profilePictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.profilePictureUrl, profilePictureUrl)) &&
            (identical(other.avatar, avatar) ||
                const DeepCollectionEquality().equals(other.avatar, avatar)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.verifiedAt, verifiedAt) ||
                const DeepCollectionEquality()
                    .equals(other.verifiedAt, verifiedAt)) &&
            (identical(other.verifiedText, verifiedText) ||
                const DeepCollectionEquality()
                    .equals(other.verifiedText, verifiedText)) &&
            (identical(other.suspendedAt, suspendedAt) ||
                const DeepCollectionEquality()
                    .equals(other.suspendedAt, suspendedAt)) &&
            (identical(other.deletedAt, deletedAt) ||
                const DeepCollectionEquality()
                    .equals(other.deletedAt, deletedAt)) &&
            (identical(other.portfoliosFollowing, portfoliosFollowing) ||
                const DeepCollectionEquality()
                    .equals(other.portfoliosFollowing, portfoliosFollowing)) &&
            (identical(other.portfolios, portfolios) ||
                const DeepCollectionEquality()
                    .equals(other.portfolios, portfolios)) &&
            (identical(other.accountFollowers, accountFollowers) ||
                const DeepCollectionEquality()
                    .equals(other.accountFollowers, accountFollowers)) &&
            (identical(other.accountsFollowing, accountsFollowing) ||
                const DeepCollectionEquality()
                    .equals(other.accountsFollowing, accountsFollowing)) &&
            (identical(other.advancedAccountsFollowing, advancedAccountsFollowing) ||
                const DeepCollectionEquality().equals(
                    other.advancedAccountsFollowing,
                    advancedAccountsFollowing)) &&
            (identical(other.advancedUsersFollowing, advancedUsersFollowing) ||
                const DeepCollectionEquality()
                    .equals(other.advancedUsersFollowing, advancedUsersFollowing)) &&
            (identical(other.followRequestsPending, followRequestsPending) || const DeepCollectionEquality().equals(other.followRequestsPending, followRequestsPending)) &&
            (identical(other.followRequests, followRequests) || const DeepCollectionEquality().equals(other.followRequests, followRequests)) &&
            (identical(other.followRequestsConnection, followRequestsConnection) || const DeepCollectionEquality().equals(other.followRequestsConnection, followRequestsConnection)) &&
            (identical(other.authUserFollowInfo, authUserFollowInfo) || const DeepCollectionEquality().equals(other.authUserFollowInfo, authUserFollowInfo)) &&
            (identical(other.authUserRelation, authUserRelation) || const DeepCollectionEquality().equals(other.authUserRelation, authUserRelation)) &&
            (identical(other.userFollowingAuthUserInfo, userFollowingAuthUserInfo) || const DeepCollectionEquality().equals(other.userFollowingAuthUserInfo, userFollowingAuthUserInfo)) &&
            (identical(other.followStats, followStats) || const DeepCollectionEquality().equals(other.followStats, followStats)) &&
            (identical(other.userStats, userStats) || const DeepCollectionEquality().equals(other.userStats, userStats)) &&
            (identical(other.notifications, notifications) || const DeepCollectionEquality().equals(other.notifications, notifications)) &&
            (identical(other.notificationsConnection, notificationsConnection) || const DeepCollectionEquality().equals(other.notificationsConnection, notificationsConnection)) &&
            (identical(other.inviteLink, inviteLink) || const DeepCollectionEquality().equals(other.inviteLink, inviteLink)) &&
            (identical(other.invitedUsers, invitedUsers) || const DeepCollectionEquality().equals(other.invitedUsers, invitedUsers)) &&
            (identical(other.assetsWatching, assetsWatching) || const DeepCollectionEquality().equals(other.assetsWatching, assetsWatching)) &&
            (identical(other.watchlist, watchlist) || const DeepCollectionEquality().equals(other.watchlist, watchlist)) &&
            (identical(other.invitedUsersTotalNumber, invitedUsersTotalNumber) || const DeepCollectionEquality().equals(other.invitedUsersTotalNumber, invitedUsersTotalNumber)) &&
            (identical(other.texts, texts) || const DeepCollectionEquality().equals(other.texts, texts)) &&
            (identical(other.storiesConnection, storiesConnection) || const DeepCollectionEquality().equals(other.storiesConnection, storiesConnection)) &&
            (identical(other.userAccessType, userAccessType) || const DeepCollectionEquality().equals(other.userAccessType, userAccessType)) &&
            (identical(other.flagsReported, flagsReported) || const DeepCollectionEquality().equals(other.flagsReported, flagsReported)) &&
            (identical(other.flagsReportedAgainst, flagsReportedAgainst) || const DeepCollectionEquality().equals(other.flagsReportedAgainst, flagsReportedAgainst)) &&
            (identical(other.suspendedByUser, suspendedByUser) || const DeepCollectionEquality().equals(other.suspendedByUser, suspendedByUser)) &&
            (identical(other.userSettings, userSettings) || const DeepCollectionEquality().equals(other.userSettings, userSettings)) &&
            (identical(other.deletedByUser, deletedByUser) || const DeepCollectionEquality().equals(other.deletedByUser, deletedByUser)) &&
            (identical(other.integrations, integrations) || const DeepCollectionEquality().equals(other.integrations, integrations)) &&
            (identical(other.shares, shares) || const DeepCollectionEquality().equals(other.shares, shares)) &&
            (identical(other.orders, orders) || const DeepCollectionEquality().equals(other.orders, orders)) &&
            (identical(other.firstOrderAt, firstOrderAt) || const DeepCollectionEquality().equals(other.firstOrderAt, firstOrderAt)) &&
            (identical(other.workspaces, workspaces) || const DeepCollectionEquality().equals(other.workspaces, workspaces)) &&
            (identical(other.savedTexts, savedTexts) || const DeepCollectionEquality().equals(other.savedTexts, savedTexts)) &&
            (identical(other.dueDiligences, dueDiligences) || const DeepCollectionEquality().equals(other.dueDiligences, dueDiligences)) &&
            (identical(other.childWorkspaces, childWorkspaces) || const DeepCollectionEquality().equals(other.childWorkspaces, childWorkspaces)) &&
            (identical(other.userContactsToInvite, userContactsToInvite) || const DeepCollectionEquality().equals(other.userContactsToInvite, userContactsToInvite)) &&
            (identical(other.usersFromContacts, usersFromContacts) || const DeepCollectionEquality().equals(other.usersFromContacts, usersFromContacts)) &&
            (identical(other.nbrUsersFromContacts, nbrUsersFromContacts) || const DeepCollectionEquality().equals(other.nbrUsersFromContacts, nbrUsersFromContacts)) &&
            (identical(other.nbrUserContactsToInvite, nbrUserContactsToInvite) || const DeepCollectionEquality().equals(other.nbrUserContactsToInvite, nbrUserContactsToInvite)) &&
            (identical(other.userTradeStatistics, userTradeStatistics) || const DeepCollectionEquality().equals(other.userTradeStatistics, userTradeStatistics)) &&
            (identical(other.connectedBrokerNames, connectedBrokerNames) || const DeepCollectionEquality().equals(other.connectedBrokerNames, connectedBrokerNames)) &&
            (identical(other.nbrOrders, nbrOrders) || const DeepCollectionEquality().equals(other.nbrOrders, nbrOrders)) &&
            (identical(other.nbrPosts, nbrPosts) || const DeepCollectionEquality().equals(other.nbrPosts, nbrPosts)) &&
            (identical(other.nbrPortfoliosNotificationsOn, nbrPortfoliosNotificationsOn) || const DeepCollectionEquality().equals(other.nbrPortfoliosNotificationsOn, nbrPortfoliosNotificationsOn)) &&
            (identical(other.nbrUsersTradeNotificationsOn, nbrUsersTradeNotificationsOn) || const DeepCollectionEquality().equals(other.nbrUsersTradeNotificationsOn, nbrUsersTradeNotificationsOn)) &&
            (identical(other.accessAnalyticsAt, accessAnalyticsAt) || const DeepCollectionEquality().equals(other.accessAnalyticsAt, accessAnalyticsAt)) &&
            (identical(other.accessFullFeedAt, accessFullFeedAt) || const DeepCollectionEquality().equals(other.accessFullFeedAt, accessFullFeedAt)) &&
            (identical(other.accessMessagingAt, accessMessagingAt) || const DeepCollectionEquality().equals(other.accessMessagingAt, accessMessagingAt)) &&
            (identical(other.autoPilotSettings, autoPilotSettings) || const DeepCollectionEquality().equals(other.autoPilotSettings, autoPilotSettings)) &&
            (identical(other.activeSubscriptions, activeSubscriptions) || const DeepCollectionEquality().equals(other.activeSubscriptions, activeSubscriptions)) &&
            (identical(other.userPrivacyType, userPrivacyType) || const DeepCollectionEquality().equals(other.userPrivacyType, userPrivacyType)) &&
            (identical(other.authUserSimilarity, authUserSimilarity) || const DeepCollectionEquality().equals(other.authUserSimilarity, authUserSimilarity)) &&
            (identical(other.lastOnlineAt, lastOnlineAt) || const DeepCollectionEquality().equals(other.lastOnlineAt, lastOnlineAt)) &&
            (identical(other.tradeNotificationsSnoozed, tradeNotificationsSnoozed) || const DeepCollectionEquality().equals(other.tradeNotificationsSnoozed, tradeNotificationsSnoozed)) &&
            (identical(other.allNotificationsSnoozed, allNotificationsSnoozed) || const DeepCollectionEquality().equals(other.allNotificationsSnoozed, allNotificationsSnoozed)) &&
            (identical(other.goldConnection, goldConnection) || const DeepCollectionEquality().equals(other.goldConnection, goldConnection)) &&
            (identical(other.isGoldMember, isGoldMember) || const DeepCollectionEquality().equals(other.isGoldMember, isGoldMember)) &&
            (identical(other.irisProConnection, irisProConnection) || const DeepCollectionEquality().equals(other.irisProConnection, irisProConnection)) &&
            (identical(other.hasInstitutionConnected, hasInstitutionConnected) || const DeepCollectionEquality().equals(other.hasInstitutionConnected, hasInstitutionConnected)) &&
            (identical(other.defaultPaymentMethodKey, defaultPaymentMethodKey) || const DeepCollectionEquality().equals(other.defaultPaymentMethodKey, defaultPaymentMethodKey)) &&
            (identical(other.defaultPaymentMethod, defaultPaymentMethod) || const DeepCollectionEquality().equals(other.defaultPaymentMethod, defaultPaymentMethod)) &&
            (identical(other.mutualFollowedBy, mutualFollowedBy) || const DeepCollectionEquality().equals(other.mutualFollowedBy, mutualFollowedBy)) &&
            (identical(other.nbrUnreadMessages, nbrUnreadMessages) || const DeepCollectionEquality().equals(other.nbrUnreadMessages, nbrUnreadMessages)) &&
            (identical(other.nbrUnseenNotifications, nbrUnseenNotifications) || const DeepCollectionEquality().equals(other.nbrUnseenNotifications, nbrUnseenNotifications)) &&
            (identical(other.tradePerformance, tradePerformance) || const DeepCollectionEquality().equals(other.tradePerformance, tradePerformance)) &&
            (identical(other.tradePerformances, tradePerformances) || const DeepCollectionEquality().equals(other.tradePerformances, tradePerformances)) &&
            (identical(other.tradePerformanceConnections, tradePerformanceConnections) || const DeepCollectionEquality().equals(other.tradePerformanceConnections, tradePerformanceConnections)) &&
            (identical(other.customerRemoteId, customerRemoteId) || const DeepCollectionEquality().equals(other.customerRemoteId, customerRemoteId)) &&
            (identical(other.sellerRemoteId, sellerRemoteId) || const DeepCollectionEquality().equals(other.sellerRemoteId, sellerRemoteId)) &&
            (identical(other.percentileConnection, percentileConnection) || const DeepCollectionEquality().equals(other.percentileConnection, percentileConnection)) &&
            (identical(other.tradeStatVisibility, tradeStatVisibility) || const DeepCollectionEquality().equals(other.tradeStatVisibility, tradeStatVisibility)) &&
            (identical(other.badgeType, badgeType) || const DeepCollectionEquality().equals(other.badgeType, badgeType)) &&
            (identical(other.experienceLevel, experienceLevel) || const DeepCollectionEquality().equals(other.experienceLevel, experienceLevel)) &&
            (identical(other.featureAccess, featureAccess) || const DeepCollectionEquality().equals(other.featureAccess, featureAccess)) &&
            (identical(other.topInterestedAssets, topInterestedAssets) || const DeepCollectionEquality().equals(other.topInterestedAssets, topInterestedAssets)) &&
            (identical(other.authUserUser, authUserUser) || const DeepCollectionEquality().equals(other.authUserUser, authUserUser)) &&
            (identical(other.dailyPercentGain, dailyPercentGain) || const DeepCollectionEquality().equals(other.dailyPercentGain, dailyPercentGain)) &&
            (identical(other.dailySnapshotJson, dailySnapshotJson) || const DeepCollectionEquality().equals(other.dailySnapshotJson, dailySnapshotJson)) &&
            (identical(other.autoPilotOnboardingConnection, autoPilotOnboardingConnection) || const DeepCollectionEquality().equals(other.autoPilotOnboardingConnection, autoPilotOnboardingConnection)) &&
            (identical(other.performance, performance) || const DeepCollectionEquality().equals(other.performance, performance)) &&
            (identical(other.temporarySnapshotHistoricalPoints, temporarySnapshotHistoricalPoints) || const DeepCollectionEquality().equals(other.temporarySnapshotHistoricalPoints, temporarySnapshotHistoricalPoints)) &&
            (identical(other.irisPositionsConnection, irisPositionsConnection) || const DeepCollectionEquality().equals(other.irisPositionsConnection, irisPositionsConnection)) &&
            (identical(other.positionsSummaryConnection, positionsSummaryConnection) || const DeepCollectionEquality().equals(other.positionsSummaryConnection, positionsSummaryConnection)) &&
            (identical(other.waitlists, waitlists) || const DeepCollectionEquality().equals(other.waitlists, waitlists)) &&
            (identical(other.autoPilotOnboardingCompleted, autoPilotOnboardingCompleted) || const DeepCollectionEquality().equals(other.autoPilotOnboardingCompleted, autoPilotOnboardingCompleted)) &&
            (identical(other.hasActiveAutoPilotSubscription, hasActiveAutoPilotSubscription) || const DeepCollectionEquality().equals(other.hasActiveAutoPilotSubscription, hasActiveAutoPilotSubscription)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(invitedByUser) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(firstName) ^
        const DeepCollectionEquality().hash(lastName) ^
        const DeepCollectionEquality().hash(username) ^
        const DeepCollectionEquality().hash(subtitle) ^
        const DeepCollectionEquality().hash(profilePictureUrl) ^
        const DeepCollectionEquality().hash(avatar) ^
        const DeepCollectionEquality().hash(email) ^
        const DeepCollectionEquality().hash(phoneNumber) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(verifiedAt) ^
        const DeepCollectionEquality().hash(verifiedText) ^
        const DeepCollectionEquality().hash(suspendedAt) ^
        const DeepCollectionEquality().hash(deletedAt) ^
        const DeepCollectionEquality().hash(portfoliosFollowing) ^
        const DeepCollectionEquality().hash(portfolios) ^
        const DeepCollectionEquality().hash(accountFollowers) ^
        const DeepCollectionEquality().hash(accountsFollowing) ^
        const DeepCollectionEquality().hash(advancedAccountsFollowing) ^
        const DeepCollectionEquality().hash(advancedUsersFollowing) ^
        const DeepCollectionEquality().hash(followRequestsPending) ^
        const DeepCollectionEquality().hash(followRequests) ^
        const DeepCollectionEquality().hash(followRequestsConnection) ^
        const DeepCollectionEquality().hash(authUserFollowInfo) ^
        const DeepCollectionEquality().hash(authUserRelation) ^
        const DeepCollectionEquality().hash(userFollowingAuthUserInfo) ^
        const DeepCollectionEquality().hash(followStats) ^
        const DeepCollectionEquality().hash(userStats) ^
        const DeepCollectionEquality().hash(notifications) ^
        const DeepCollectionEquality().hash(notificationsConnection) ^
        const DeepCollectionEquality().hash(inviteLink) ^
        const DeepCollectionEquality().hash(invitedUsers) ^
        const DeepCollectionEquality().hash(assetsWatching) ^
        const DeepCollectionEquality().hash(watchlist) ^
        const DeepCollectionEquality().hash(invitedUsersTotalNumber) ^
        const DeepCollectionEquality().hash(texts) ^
        const DeepCollectionEquality().hash(storiesConnection) ^
        const DeepCollectionEquality().hash(userAccessType) ^
        const DeepCollectionEquality().hash(flagsReported) ^
        const DeepCollectionEquality().hash(flagsReportedAgainst) ^
        const DeepCollectionEquality().hash(suspendedByUser) ^
        const DeepCollectionEquality().hash(userSettings) ^
        const DeepCollectionEquality().hash(deletedByUser) ^
        const DeepCollectionEquality().hash(integrations) ^
        const DeepCollectionEquality().hash(shares) ^
        const DeepCollectionEquality().hash(orders) ^
        const DeepCollectionEquality().hash(firstOrderAt) ^
        const DeepCollectionEquality().hash(workspaces) ^
        const DeepCollectionEquality().hash(savedTexts) ^
        const DeepCollectionEquality().hash(dueDiligences) ^
        const DeepCollectionEquality().hash(childWorkspaces) ^
        const DeepCollectionEquality().hash(userContactsToInvite) ^
        const DeepCollectionEquality().hash(usersFromContacts) ^
        const DeepCollectionEquality().hash(nbrUsersFromContacts) ^
        const DeepCollectionEquality().hash(nbrUserContactsToInvite) ^
        const DeepCollectionEquality().hash(userTradeStatistics) ^
        const DeepCollectionEquality().hash(connectedBrokerNames) ^
        const DeepCollectionEquality().hash(nbrOrders) ^
        const DeepCollectionEquality().hash(nbrPosts) ^
        const DeepCollectionEquality().hash(nbrPortfoliosNotificationsOn) ^
        const DeepCollectionEquality().hash(nbrUsersTradeNotificationsOn) ^
        const DeepCollectionEquality().hash(accessAnalyticsAt) ^
        const DeepCollectionEquality().hash(accessFullFeedAt) ^
        const DeepCollectionEquality().hash(accessMessagingAt) ^
        const DeepCollectionEquality().hash(autoPilotSettings) ^
        const DeepCollectionEquality().hash(activeSubscriptions) ^
        const DeepCollectionEquality().hash(userPrivacyType) ^
        const DeepCollectionEquality().hash(authUserSimilarity) ^
        const DeepCollectionEquality().hash(lastOnlineAt) ^
        const DeepCollectionEquality().hash(tradeNotificationsSnoozed) ^
        const DeepCollectionEquality().hash(allNotificationsSnoozed) ^
        const DeepCollectionEquality().hash(goldConnection) ^
        const DeepCollectionEquality().hash(isGoldMember) ^
        const DeepCollectionEquality().hash(irisProConnection) ^
        const DeepCollectionEquality().hash(hasInstitutionConnected) ^
        const DeepCollectionEquality().hash(defaultPaymentMethodKey) ^
        const DeepCollectionEquality().hash(defaultPaymentMethod) ^
        const DeepCollectionEquality().hash(mutualFollowedBy) ^
        const DeepCollectionEquality().hash(nbrUnreadMessages) ^
        const DeepCollectionEquality().hash(nbrUnseenNotifications) ^
        const DeepCollectionEquality().hash(tradePerformance) ^
        const DeepCollectionEquality().hash(tradePerformances) ^
        const DeepCollectionEquality().hash(tradePerformanceConnections) ^
        const DeepCollectionEquality().hash(customerRemoteId) ^
        const DeepCollectionEquality().hash(sellerRemoteId) ^
        const DeepCollectionEquality().hash(percentileConnection) ^
        const DeepCollectionEquality().hash(tradeStatVisibility) ^
        const DeepCollectionEquality().hash(badgeType) ^
        const DeepCollectionEquality().hash(experienceLevel) ^
        const DeepCollectionEquality().hash(featureAccess) ^
        const DeepCollectionEquality().hash(topInterestedAssets) ^
        const DeepCollectionEquality().hash(authUserUser) ^
        const DeepCollectionEquality().hash(dailyPercentGain) ^
        const DeepCollectionEquality().hash(dailySnapshotJson) ^
        const DeepCollectionEquality().hash(autoPilotOnboardingConnection) ^
        const DeepCollectionEquality().hash(performance) ^
        const DeepCollectionEquality().hash(temporarySnapshotHistoricalPoints) ^
        const DeepCollectionEquality().hash(irisPositionsConnection) ^
        const DeepCollectionEquality().hash(positionsSummaryConnection) ^
        const DeepCollectionEquality().hash(waitlists) ^
        const DeepCollectionEquality().hash(autoPilotOnboardingCompleted) ^
        const DeepCollectionEquality().hash(hasActiveAutoPilotSubscription);
  }

  @override
  String toString() => 'User(${toJson()})';
}
