import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/account_from_broker.dart';
import 'package:collection/collection.dart';

class PortfolioConnectResponse {
  final String? message;
  final String? challengeId;
  final String? deviceToken;
  final Portfolio? portfolio;
  final int? portfolioKey;
  final List<AccountFromBroker>? brokerAccounts;
  const PortfolioConnectResponse(
      {this.message,
      this.challengeId,
      this.deviceToken,
      this.portfolio,
      this.portfolioKey,
      this.brokerAccounts});
  PortfolioConnectResponse copyWith(
      {String? message,
      String? challengeId,
      String? deviceToken,
      Portfolio? portfolio,
      int? portfolioKey,
      List<AccountFromBroker>? brokerAccounts}) {
    return PortfolioConnectResponse(
      message: message ?? this.message,
      challengeId: challengeId ?? this.challengeId,
      deviceToken: deviceToken ?? this.deviceToken,
      portfolio: portfolio ?? this.portfolio,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      brokerAccounts: brokerAccounts ?? this.brokerAccounts,
    );
  }

  factory PortfolioConnectResponse.fromJson(Map<String, dynamic> json) {
    return PortfolioConnectResponse(
      message: json['message'],
      challengeId: json['challengeId'],
      deviceToken: json['deviceToken'],
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      portfolioKey: json['portfolioKey'],
      brokerAccounts: json['brokerAccounts']
          ?.map<AccountFromBroker>((o) => AccountFromBroker.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['challengeId'] = challengeId;
    data['deviceToken'] = deviceToken;
    data['portfolio'] = portfolio?.toJson();
    data['portfolioKey'] = portfolioKey;
    data['brokerAccounts'] =
        brokerAccounts?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioConnectResponse &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.challengeId, challengeId) ||
                const DeepCollectionEquality()
                    .equals(other.challengeId, challengeId)) &&
            (identical(other.deviceToken, deviceToken) ||
                const DeepCollectionEquality()
                    .equals(other.deviceToken, deviceToken)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.brokerAccounts, brokerAccounts) ||
                const DeepCollectionEquality()
                    .equals(other.brokerAccounts, brokerAccounts)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(message) ^
        const DeepCollectionEquality().hash(challengeId) ^
        const DeepCollectionEquality().hash(deviceToken) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(brokerAccounts);
  }

  @override
  String toString() => 'PortfolioConnectResponse(${toJson()})';
}
