import 'package:iris_common/data/models/output/auth_user_follow_info.dart';
import 'package:iris_common/data/models/output/follow_stats.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/enums/connection_status.dart';
import 'package:iris_common/data/models/enums/broker_name.dart';
import 'package:iris_common/data/models/output/broker_account.dart';
import 'package:iris_common/data/models/output/investment_profile.dart';
import 'package:iris_common/data/models/output/positions_connection.dart';
import 'package:iris_common/data/models/output/portfolio_historical.dart';
import 'package:iris_common/data/models/output/historical.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:iris_common/data/models/output/snapshot.dart';
import 'package:iris_common/data/models/output/position_analysis.dart';
import 'package:iris_common/data/models/output/trade_analysis.dart';
import 'package:iris_common/data/models/output/trade_statistics.dart';
import 'package:iris_common/data/models/output/flag.dart';
import 'package:iris_common/data/models/output/user_relation.dart';
import 'package:iris_common/data/models/enums/portfolio_visibility_setting.dart';
import 'package:iris_common/data/models/output/trade_performance.dart';
import 'package:iris_common/data/models/output/broker_connection.dart';
import 'package:iris_common/data/models/output/percentile_connection.dart';
import 'package:iris_common/data/models/output/get_performance_response.dart';
import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:iris_common/data/models/output/positions_get_response.dart';
import 'package:iris_common/data/models/output/positions_summary_get_response.dart';
import 'package:iris_common/data/models/output/temporary_snapshot_historical_points.dart';
import 'package:iris_common/data/models/output/pilot_performance.dart';
import 'package:iris_common/data/models/output/portfolio_financial_info.dart';
import 'package:collection/collection.dart';

class Portfolio {
  final AuthUserFollowInfo? authUserFollowInfo;
  final FollowStats? followStats;
  final User? user;
  final int? portfolioKey;
  final String? accountId;
  final String? portfolioName;
  final String? cardImageUrl;
  final CONNECTION_STATUS? connectionStatus;
  final DateTime? deletedAt;
  final String? nickname;
  final String? description;
  final BROKER_NAME? brokerName;
  final BrokerAccount? brokerAccount;
  final double? buyingPower;
  final InvestmentProfile? investmentProfile;
  final PositionsConnection? positionsConnection;
  final PortfolioHistorical? historical;
  final Historical? historicalV2;
  final double? spanPercentage;
  final List<Order>? orders;
  final List<TextModel>? texts;
  final Snapshot? snapshot;
  final List<PositionAnalysis>? positionAnalysis;
  final List<PositionAnalysis>? openPositions;
  final List<TradeAnalysis>? tradeAnalysis;
  final TradeStatistics? portfolioTradeStatistics;
  final double? averageTradesPerMonth;
  final List<Flag>? flagsReportedAgainst;
  final UserRelation? authUserRelation;
  final PORTFOLIO_VISIBILITY_SETTING? portfolioVisibilitySetting;
  final User? deletedByUser;
  final List<User>? followers;
  final TradePerformance? tradePerformance;
  final BrokerConnection? brokerConnection;
  final PercentileConnection? percentileConnection;
  final GetPerformanceResponse? performance;
  final AutoPilotSettings? existingMasterAutoPilotSettings;
  final PositionsGetResponse? irisPositionsConnection;
  final PositionsSummaryGetResponse? positionsSummaryConnection;
  final TemporarySnapshotHistoricalPoints? temporarySnapshotHistoricalPoints;
  final PilotPerformance? pilotPerformance;
  final PortfolioFinancialInfo? financialInfo;
  const Portfolio(
      {this.authUserFollowInfo,
      this.followStats,
      this.user,
      this.portfolioKey,
      this.accountId,
      this.portfolioName,
      this.cardImageUrl,
      this.connectionStatus,
      this.deletedAt,
      this.nickname,
      this.description,
      this.brokerName,
      this.brokerAccount,
      this.buyingPower,
      this.investmentProfile,
      this.positionsConnection,
      this.historical,
      this.historicalV2,
      this.spanPercentage,
      this.orders,
      this.texts,
      this.snapshot,
      this.positionAnalysis,
      this.openPositions,
      this.tradeAnalysis,
      this.portfolioTradeStatistics,
      this.averageTradesPerMonth,
      this.flagsReportedAgainst,
      this.authUserRelation,
      this.portfolioVisibilitySetting,
      this.deletedByUser,
      this.followers,
      this.tradePerformance,
      this.brokerConnection,
      this.percentileConnection,
      this.performance,
      this.existingMasterAutoPilotSettings,
      this.irisPositionsConnection,
      this.positionsSummaryConnection,
      this.temporarySnapshotHistoricalPoints,
      this.pilotPerformance,
      this.financialInfo});
  Portfolio copyWith(
      {AuthUserFollowInfo? authUserFollowInfo,
      FollowStats? followStats,
      User? user,
      int? portfolioKey,
      String? accountId,
      String? portfolioName,
      String? cardImageUrl,
      CONNECTION_STATUS? connectionStatus,
      DateTime? deletedAt,
      String? nickname,
      String? description,
      BROKER_NAME? brokerName,
      BrokerAccount? brokerAccount,
      double? buyingPower,
      InvestmentProfile? investmentProfile,
      PositionsConnection? positionsConnection,
      PortfolioHistorical? historical,
      Historical? historicalV2,
      double? spanPercentage,
      List<Order>? orders,
      List<TextModel>? texts,
      Snapshot? snapshot,
      List<PositionAnalysis>? positionAnalysis,
      List<PositionAnalysis>? openPositions,
      List<TradeAnalysis>? tradeAnalysis,
      TradeStatistics? portfolioTradeStatistics,
      double? averageTradesPerMonth,
      List<Flag>? flagsReportedAgainst,
      UserRelation? authUserRelation,
      PORTFOLIO_VISIBILITY_SETTING? portfolioVisibilitySetting,
      User? deletedByUser,
      List<User>? followers,
      TradePerformance? tradePerformance,
      BrokerConnection? brokerConnection,
      PercentileConnection? percentileConnection,
      GetPerformanceResponse? performance,
      AutoPilotSettings? existingMasterAutoPilotSettings,
      PositionsGetResponse? irisPositionsConnection,
      PositionsSummaryGetResponse? positionsSummaryConnection,
      TemporarySnapshotHistoricalPoints? temporarySnapshotHistoricalPoints,
      PilotPerformance? pilotPerformance,
      PortfolioFinancialInfo? financialInfo}) {
    return Portfolio(
      authUserFollowInfo: authUserFollowInfo ?? this.authUserFollowInfo,
      followStats: followStats ?? this.followStats,
      user: user ?? this.user,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      accountId: accountId ?? this.accountId,
      portfolioName: portfolioName ?? this.portfolioName,
      cardImageUrl: cardImageUrl ?? this.cardImageUrl,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      deletedAt: deletedAt ?? this.deletedAt,
      nickname: nickname ?? this.nickname,
      description: description ?? this.description,
      brokerName: brokerName ?? this.brokerName,
      brokerAccount: brokerAccount ?? this.brokerAccount,
      buyingPower: buyingPower ?? this.buyingPower,
      investmentProfile: investmentProfile ?? this.investmentProfile,
      positionsConnection: positionsConnection ?? this.positionsConnection,
      historical: historical ?? this.historical,
      historicalV2: historicalV2 ?? this.historicalV2,
      spanPercentage: spanPercentage ?? this.spanPercentage,
      orders: orders ?? this.orders,
      texts: texts ?? this.texts,
      snapshot: snapshot ?? this.snapshot,
      positionAnalysis: positionAnalysis ?? this.positionAnalysis,
      openPositions: openPositions ?? this.openPositions,
      tradeAnalysis: tradeAnalysis ?? this.tradeAnalysis,
      portfolioTradeStatistics:
          portfolioTradeStatistics ?? this.portfolioTradeStatistics,
      averageTradesPerMonth:
          averageTradesPerMonth ?? this.averageTradesPerMonth,
      flagsReportedAgainst: flagsReportedAgainst ?? this.flagsReportedAgainst,
      authUserRelation: authUserRelation ?? this.authUserRelation,
      portfolioVisibilitySetting:
          portfolioVisibilitySetting ?? this.portfolioVisibilitySetting,
      deletedByUser: deletedByUser ?? this.deletedByUser,
      followers: followers ?? this.followers,
      tradePerformance: tradePerformance ?? this.tradePerformance,
      brokerConnection: brokerConnection ?? this.brokerConnection,
      percentileConnection: percentileConnection ?? this.percentileConnection,
      performance: performance ?? this.performance,
      existingMasterAutoPilotSettings: existingMasterAutoPilotSettings ??
          this.existingMasterAutoPilotSettings,
      irisPositionsConnection:
          irisPositionsConnection ?? this.irisPositionsConnection,
      positionsSummaryConnection:
          positionsSummaryConnection ?? this.positionsSummaryConnection,
      temporarySnapshotHistoricalPoints: temporarySnapshotHistoricalPoints ??
          this.temporarySnapshotHistoricalPoints,
      pilotPerformance: pilotPerformance ?? this.pilotPerformance,
      financialInfo: financialInfo ?? this.financialInfo,
    );
  }

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      authUserFollowInfo: json['authUserFollowInfo'] != null
          ? AuthUserFollowInfo.fromJson(json['authUserFollowInfo'])
          : null,
      followStats: json['followStats'] != null
          ? FollowStats.fromJson(json['followStats'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      portfolioKey: json['portfolioKey'],
      accountId: json['accountId'],
      portfolioName: json['portfolioName'],
      cardImageUrl: json['cardImageUrl'],
      connectionStatus: json['connectionStatus'] != null
          ? CONNECTION_STATUS.values.byName(json['connectionStatus'])
          : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      nickname: json['nickname'],
      description: json['description'],
      brokerName: json['brokerName'] != null
          ? BROKER_NAME.values.byName(json['brokerName'])
          : null,
      brokerAccount: json['brokerAccount'] != null
          ? BrokerAccount.fromJson(json['brokerAccount'])
          : null,
      buyingPower: json['buyingPower']?.toDouble(),
      investmentProfile: json['investmentProfile'] != null
          ? InvestmentProfile.fromJson(json['investmentProfile'])
          : null,
      positionsConnection: json['positionsConnection'] != null
          ? PositionsConnection.fromJson(json['positionsConnection'])
          : null,
      historical: json['historical'] != null
          ? PortfolioHistorical.fromJson(json['historical'])
          : null,
      historicalV2: json['historicalV2'] != null
          ? Historical.fromJson(json['historicalV2'])
          : null,
      spanPercentage: json['spanPercentage']?.toDouble(),
      orders: json['orders']?.map<Order>((o) => Order.fromJson(o)).toList(),
      texts:
          json['texts']?.map<TextModel>((o) => TextModel.fromJson(o)).toList(),
      snapshot:
          json['snapshot'] != null ? Snapshot.fromJson(json['snapshot']) : null,
      positionAnalysis: json['positionAnalysis']
          ?.map<PositionAnalysis>((o) => PositionAnalysis.fromJson(o))
          .toList(),
      openPositions: json['openPositions']
          ?.map<PositionAnalysis>((o) => PositionAnalysis.fromJson(o))
          .toList(),
      tradeAnalysis: json['tradeAnalysis']
          ?.map<TradeAnalysis>((o) => TradeAnalysis.fromJson(o))
          .toList(),
      portfolioTradeStatistics: json['portfolioTradeStatistics'] != null
          ? TradeStatistics.fromJson(json['portfolioTradeStatistics'])
          : null,
      averageTradesPerMonth: json['averageTradesPerMonth']?.toDouble(),
      flagsReportedAgainst: json['flagsReportedAgainst']
          ?.map<Flag>((o) => Flag.fromJson(o))
          .toList(),
      authUserRelation: json['authUserRelation'] != null
          ? UserRelation.fromJson(json['authUserRelation'])
          : null,
      portfolioVisibilitySetting: json['portfolioVisibilitySetting'] != null
          ? PORTFOLIO_VISIBILITY_SETTING.values
              .byName(json['portfolioVisibilitySetting'])
          : null,
      deletedByUser: json['deletedByUser'] != null
          ? User.fromJson(json['deletedByUser'])
          : null,
      followers: json['followers']?.map<User>((o) => User.fromJson(o)).toList(),
      tradePerformance: json['tradePerformance'] != null
          ? TradePerformance.fromJson(json['tradePerformance'])
          : null,
      brokerConnection: json['brokerConnection'] != null
          ? BrokerConnection.fromJson(json['brokerConnection'])
          : null,
      percentileConnection: json['percentileConnection'] != null
          ? PercentileConnection.fromJson(json['percentileConnection'])
          : null,
      performance: json['performance'] != null
          ? GetPerformanceResponse.fromJson(json['performance'])
          : null,
      existingMasterAutoPilotSettings:
          json['existingMasterAutoPilotSettings'] != null
              ? AutoPilotSettings.fromJson(
                  json['existingMasterAutoPilotSettings'])
              : null,
      irisPositionsConnection: json['irisPositionsConnection'] != null
          ? PositionsGetResponse.fromJson(json['irisPositionsConnection'])
          : null,
      positionsSummaryConnection: json['positionsSummaryConnection'] != null
          ? PositionsSummaryGetResponse.fromJson(
              json['positionsSummaryConnection'])
          : null,
      temporarySnapshotHistoricalPoints:
          json['temporarySnapshotHistoricalPoints'] != null
              ? TemporarySnapshotHistoricalPoints.fromJson(
                  json['temporarySnapshotHistoricalPoints'])
              : null,
      pilotPerformance: json['pilotPerformance'] != null
          ? PilotPerformance.fromJson(json['pilotPerformance'])
          : null,
      financialInfo: json['financialInfo'] != null
          ? PortfolioFinancialInfo.fromJson(json['financialInfo'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['authUserFollowInfo'] = authUserFollowInfo?.toJson();
    data['followStats'] = followStats?.toJson();
    data['user'] = user?.toJson();
    data['portfolioKey'] = portfolioKey;
    data['accountId'] = accountId;
    data['portfolioName'] = portfolioName;
    data['cardImageUrl'] = cardImageUrl;
    data['connectionStatus'] = connectionStatus?.name;
    data['deletedAt'] = deletedAt?.toString();
    data['nickname'] = nickname;
    data['description'] = description;
    data['brokerName'] = brokerName?.name;
    data['brokerAccount'] = brokerAccount?.toJson();
    data['buyingPower'] = buyingPower;
    data['investmentProfile'] = investmentProfile?.toJson();
    data['positionsConnection'] = positionsConnection?.toJson();
    data['historical'] = historical?.toJson();
    data['historicalV2'] = historicalV2?.toJson();
    data['spanPercentage'] = spanPercentage;
    data['orders'] = orders?.map((item) => item.toJson()).toList();
    data['texts'] = texts?.map((item) => item.toJson()).toList();
    data['snapshot'] = snapshot?.toJson();
    data['positionAnalysis'] =
        positionAnalysis?.map((item) => item.toJson()).toList();
    data['openPositions'] =
        openPositions?.map((item) => item.toJson()).toList();
    data['tradeAnalysis'] =
        tradeAnalysis?.map((item) => item.toJson()).toList();
    data['portfolioTradeStatistics'] = portfolioTradeStatistics?.toJson();
    data['averageTradesPerMonth'] = averageTradesPerMonth;
    data['flagsReportedAgainst'] =
        flagsReportedAgainst?.map((item) => item.toJson()).toList();
    data['authUserRelation'] = authUserRelation?.toJson();
    data['portfolioVisibilitySetting'] = portfolioVisibilitySetting?.name;
    data['deletedByUser'] = deletedByUser?.toJson();
    data['followers'] = followers?.map((item) => item.toJson()).toList();
    data['tradePerformance'] = tradePerformance?.toJson();
    data['brokerConnection'] = brokerConnection?.toJson();
    data['percentileConnection'] = percentileConnection?.toJson();
    data['performance'] = performance?.toJson();
    data['existingMasterAutoPilotSettings'] =
        existingMasterAutoPilotSettings?.toJson();
    data['irisPositionsConnection'] = irisPositionsConnection?.toJson();
    data['positionsSummaryConnection'] = positionsSummaryConnection?.toJson();
    data['temporarySnapshotHistoricalPoints'] =
        temporarySnapshotHistoricalPoints?.toJson();
    data['pilotPerformance'] = pilotPerformance?.toJson();
    data['financialInfo'] = financialInfo?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Portfolio &&
            (identical(other.authUserFollowInfo, authUserFollowInfo) ||
                const DeepCollectionEquality()
                    .equals(other.authUserFollowInfo, authUserFollowInfo)) &&
            (identical(other.followStats, followStats) ||
                const DeepCollectionEquality()
                    .equals(other.followStats, followStats)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.accountId, accountId) ||
                const DeepCollectionEquality()
                    .equals(other.accountId, accountId)) &&
            (identical(other.portfolioName, portfolioName) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioName, portfolioName)) &&
            (identical(other.cardImageUrl, cardImageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.cardImageUrl, cardImageUrl)) &&
            (identical(other.connectionStatus, connectionStatus) ||
                const DeepCollectionEquality()
                    .equals(other.connectionStatus, connectionStatus)) &&
            (identical(other.deletedAt, deletedAt) ||
                const DeepCollectionEquality()
                    .equals(other.deletedAt, deletedAt)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.brokerName, brokerName) ||
                const DeepCollectionEquality()
                    .equals(other.brokerName, brokerName)) &&
            (identical(other.brokerAccount, brokerAccount) ||
                const DeepCollectionEquality()
                    .equals(other.brokerAccount, brokerAccount)) &&
            (identical(other.buyingPower, buyingPower) ||
                const DeepCollectionEquality()
                    .equals(other.buyingPower, buyingPower)) &&
            (identical(other.investmentProfile, investmentProfile) ||
                const DeepCollectionEquality()
                    .equals(other.investmentProfile, investmentProfile)) &&
            (identical(other.positionsConnection, positionsConnection) ||
                const DeepCollectionEquality()
                    .equals(other.positionsConnection, positionsConnection)) &&
            (identical(other.historical, historical) ||
                const DeepCollectionEquality()
                    .equals(other.historical, historical)) &&
            (identical(other.historicalV2, historicalV2) ||
                const DeepCollectionEquality()
                    .equals(other.historicalV2, historicalV2)) &&
            (identical(other.spanPercentage, spanPercentage) ||
                const DeepCollectionEquality()
                    .equals(other.spanPercentage, spanPercentage)) &&
            (identical(other.orders, orders) ||
                const DeepCollectionEquality().equals(other.orders, orders)) &&
            (identical(other.texts, texts) ||
                const DeepCollectionEquality().equals(other.texts, texts)) &&
            (identical(other.snapshot, snapshot) ||
                const DeepCollectionEquality()
                    .equals(other.snapshot, snapshot)) &&
            (identical(other.positionAnalysis, positionAnalysis) ||
                const DeepCollectionEquality()
                    .equals(other.positionAnalysis, positionAnalysis)) &&
            (identical(other.openPositions, openPositions) || const DeepCollectionEquality().equals(other.openPositions, openPositions)) &&
            (identical(other.tradeAnalysis, tradeAnalysis) || const DeepCollectionEquality().equals(other.tradeAnalysis, tradeAnalysis)) &&
            (identical(other.portfolioTradeStatistics, portfolioTradeStatistics) || const DeepCollectionEquality().equals(other.portfolioTradeStatistics, portfolioTradeStatistics)) &&
            (identical(other.averageTradesPerMonth, averageTradesPerMonth) || const DeepCollectionEquality().equals(other.averageTradesPerMonth, averageTradesPerMonth)) &&
            (identical(other.flagsReportedAgainst, flagsReportedAgainst) || const DeepCollectionEquality().equals(other.flagsReportedAgainst, flagsReportedAgainst)) &&
            (identical(other.authUserRelation, authUserRelation) || const DeepCollectionEquality().equals(other.authUserRelation, authUserRelation)) &&
            (identical(other.portfolioVisibilitySetting, portfolioVisibilitySetting) || const DeepCollectionEquality().equals(other.portfolioVisibilitySetting, portfolioVisibilitySetting)) &&
            (identical(other.deletedByUser, deletedByUser) || const DeepCollectionEquality().equals(other.deletedByUser, deletedByUser)) &&
            (identical(other.followers, followers) || const DeepCollectionEquality().equals(other.followers, followers)) &&
            (identical(other.tradePerformance, tradePerformance) || const DeepCollectionEquality().equals(other.tradePerformance, tradePerformance)) &&
            (identical(other.brokerConnection, brokerConnection) || const DeepCollectionEquality().equals(other.brokerConnection, brokerConnection)) &&
            (identical(other.percentileConnection, percentileConnection) || const DeepCollectionEquality().equals(other.percentileConnection, percentileConnection)) &&
            (identical(other.performance, performance) || const DeepCollectionEquality().equals(other.performance, performance)) &&
            (identical(other.existingMasterAutoPilotSettings, existingMasterAutoPilotSettings) || const DeepCollectionEquality().equals(other.existingMasterAutoPilotSettings, existingMasterAutoPilotSettings)) &&
            (identical(other.irisPositionsConnection, irisPositionsConnection) || const DeepCollectionEquality().equals(other.irisPositionsConnection, irisPositionsConnection)) &&
            (identical(other.positionsSummaryConnection, positionsSummaryConnection) || const DeepCollectionEquality().equals(other.positionsSummaryConnection, positionsSummaryConnection)) &&
            (identical(other.temporarySnapshotHistoricalPoints, temporarySnapshotHistoricalPoints) || const DeepCollectionEquality().equals(other.temporarySnapshotHistoricalPoints, temporarySnapshotHistoricalPoints)) &&
            (identical(other.pilotPerformance, pilotPerformance) || const DeepCollectionEquality().equals(other.pilotPerformance, pilotPerformance)) &&
            (identical(other.financialInfo, financialInfo) || const DeepCollectionEquality().equals(other.financialInfo, financialInfo)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(authUserFollowInfo) ^
        const DeepCollectionEquality().hash(followStats) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(accountId) ^
        const DeepCollectionEquality().hash(portfolioName) ^
        const DeepCollectionEquality().hash(cardImageUrl) ^
        const DeepCollectionEquality().hash(connectionStatus) ^
        const DeepCollectionEquality().hash(deletedAt) ^
        const DeepCollectionEquality().hash(nickname) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(brokerName) ^
        const DeepCollectionEquality().hash(brokerAccount) ^
        const DeepCollectionEquality().hash(buyingPower) ^
        const DeepCollectionEquality().hash(investmentProfile) ^
        const DeepCollectionEquality().hash(positionsConnection) ^
        const DeepCollectionEquality().hash(historical) ^
        const DeepCollectionEquality().hash(historicalV2) ^
        const DeepCollectionEquality().hash(spanPercentage) ^
        const DeepCollectionEquality().hash(orders) ^
        const DeepCollectionEquality().hash(texts) ^
        const DeepCollectionEquality().hash(snapshot) ^
        const DeepCollectionEquality().hash(positionAnalysis) ^
        const DeepCollectionEquality().hash(openPositions) ^
        const DeepCollectionEquality().hash(tradeAnalysis) ^
        const DeepCollectionEquality().hash(portfolioTradeStatistics) ^
        const DeepCollectionEquality().hash(averageTradesPerMonth) ^
        const DeepCollectionEquality().hash(flagsReportedAgainst) ^
        const DeepCollectionEquality().hash(authUserRelation) ^
        const DeepCollectionEquality().hash(portfolioVisibilitySetting) ^
        const DeepCollectionEquality().hash(deletedByUser) ^
        const DeepCollectionEquality().hash(followers) ^
        const DeepCollectionEquality().hash(tradePerformance) ^
        const DeepCollectionEquality().hash(brokerConnection) ^
        const DeepCollectionEquality().hash(percentileConnection) ^
        const DeepCollectionEquality().hash(performance) ^
        const DeepCollectionEquality().hash(existingMasterAutoPilotSettings) ^
        const DeepCollectionEquality().hash(irisPositionsConnection) ^
        const DeepCollectionEquality().hash(positionsSummaryConnection) ^
        const DeepCollectionEquality().hash(temporarySnapshotHistoricalPoints) ^
        const DeepCollectionEquality().hash(pilotPerformance) ^
        const DeepCollectionEquality().hash(financialInfo);
  }

  @override
  String toString() => 'Portfolio(${toJson()})';
}
