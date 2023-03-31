import 'package:iris_common/data/models/output/auto_pilot_portfolio_performance_info.dart';
import 'package:iris_common/data/models/output/auto_pilot_holdings_connection.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:collection/collection.dart';

class AutoPilotPortfolio {
  final int? portfolioKey;
  final int? userKey;
  final String? description;
  final String? portfolioName;
  final String? userFullName;
  final String? userSubtitle;
  final String? userProfileImage;
  final String? portfolioCardImageUrl;
  final int? nbrAutoPilotedBy;
  final AutoPilotPortfolioPerformanceInfo? performanceInfo;
  final AutoPilotHoldingsConnection? holdingsConnection;
  final List<Order>? orders;
  const AutoPilotPortfolio(
      {required this.portfolioKey,
      required this.userKey,
      this.description,
      this.portfolioName,
      this.userFullName,
      this.userSubtitle,
      this.userProfileImage,
      required this.portfolioCardImageUrl,
      this.nbrAutoPilotedBy,
      this.performanceInfo,
      this.holdingsConnection,
      this.orders});
  AutoPilotPortfolio copyWith(
      {int? portfolioKey,
      int? userKey,
      String? description,
      String? portfolioName,
      String? userFullName,
      String? userSubtitle,
      String? userProfileImage,
      String? portfolioCardImageUrl,
      int? nbrAutoPilotedBy,
      AutoPilotPortfolioPerformanceInfo? performanceInfo,
      AutoPilotHoldingsConnection? holdingsConnection,
      List<Order>? orders}) {
    return AutoPilotPortfolio(
      portfolioKey: portfolioKey ?? this.portfolioKey,
      userKey: userKey ?? this.userKey,
      description: description ?? this.description,
      portfolioName: portfolioName ?? this.portfolioName,
      userFullName: userFullName ?? this.userFullName,
      userSubtitle: userSubtitle ?? this.userSubtitle,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      portfolioCardImageUrl:
          portfolioCardImageUrl ?? this.portfolioCardImageUrl,
      nbrAutoPilotedBy: nbrAutoPilotedBy ?? this.nbrAutoPilotedBy,
      performanceInfo: performanceInfo ?? this.performanceInfo,
      holdingsConnection: holdingsConnection ?? this.holdingsConnection,
      orders: orders ?? this.orders,
    );
  }

  factory AutoPilotPortfolio.fromJson(Map<String, dynamic> json) {
    return AutoPilotPortfolio(
      portfolioKey: json['portfolioKey'],
      userKey: json['userKey'],
      description: json['description'],
      portfolioName: json['portfolioName'],
      userFullName: json['userFullName'],
      userSubtitle: json['userSubtitle'],
      userProfileImage: json['userProfileImage'],
      portfolioCardImageUrl: json['portfolioCardImageUrl'],
      nbrAutoPilotedBy: json['nbrAutoPilotedBy'],
      performanceInfo: json['performanceInfo'] != null
          ? AutoPilotPortfolioPerformanceInfo.fromJson(json['performanceInfo'])
          : null,
      holdingsConnection: json['holdingsConnection'] != null
          ? AutoPilotHoldingsConnection.fromJson(json['holdingsConnection'])
          : null,
      orders: json['orders']?.map<Order>((o) => Order.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioKey'] = portfolioKey;
    data['userKey'] = userKey;
    data['description'] = description;
    data['portfolioName'] = portfolioName;
    data['userFullName'] = userFullName;
    data['userSubtitle'] = userSubtitle;
    data['userProfileImage'] = userProfileImage;
    data['portfolioCardImageUrl'] = portfolioCardImageUrl;
    data['nbrAutoPilotedBy'] = nbrAutoPilotedBy;
    data['performanceInfo'] = performanceInfo?.toJson();
    data['holdingsConnection'] = holdingsConnection?.toJson();
    data['orders'] = orders?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotPortfolio &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.portfolioName, portfolioName) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioName, portfolioName)) &&
            (identical(other.userFullName, userFullName) ||
                const DeepCollectionEquality()
                    .equals(other.userFullName, userFullName)) &&
            (identical(other.userSubtitle, userSubtitle) ||
                const DeepCollectionEquality()
                    .equals(other.userSubtitle, userSubtitle)) &&
            (identical(other.userProfileImage, userProfileImage) ||
                const DeepCollectionEquality()
                    .equals(other.userProfileImage, userProfileImage)) &&
            (identical(other.portfolioCardImageUrl, portfolioCardImageUrl) ||
                const DeepCollectionEquality().equals(
                    other.portfolioCardImageUrl, portfolioCardImageUrl)) &&
            (identical(other.nbrAutoPilotedBy, nbrAutoPilotedBy) ||
                const DeepCollectionEquality()
                    .equals(other.nbrAutoPilotedBy, nbrAutoPilotedBy)) &&
            (identical(other.performanceInfo, performanceInfo) ||
                const DeepCollectionEquality()
                    .equals(other.performanceInfo, performanceInfo)) &&
            (identical(other.holdingsConnection, holdingsConnection) ||
                const DeepCollectionEquality()
                    .equals(other.holdingsConnection, holdingsConnection)) &&
            (identical(other.orders, orders) ||
                const DeepCollectionEquality().equals(other.orders, orders)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(portfolioName) ^
        const DeepCollectionEquality().hash(userFullName) ^
        const DeepCollectionEquality().hash(userSubtitle) ^
        const DeepCollectionEquality().hash(userProfileImage) ^
        const DeepCollectionEquality().hash(portfolioCardImageUrl) ^
        const DeepCollectionEquality().hash(nbrAutoPilotedBy) ^
        const DeepCollectionEquality().hash(performanceInfo) ^
        const DeepCollectionEquality().hash(holdingsConnection) ^
        const DeepCollectionEquality().hash(orders);
  }

  @override
  String toString() => 'AutoPilotPortfolio(${toJson()})';
}
