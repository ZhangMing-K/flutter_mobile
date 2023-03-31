import 'package:iris_common/data/models/enums/broker_name.dart';
import 'package:collection/collection.dart';

class PortfolioFinancialInfo {
  final int? portfolioKey;
  final BROKER_NAME? brokerName;
  final String? portfolioName;
  final double? buyingPower;
  final double? buyingPowerEquity;
  final double? buyingPowerCrypto;
  final double? buyingPowerOption;
  final DateTime? lastHardCheckAt;
  const PortfolioFinancialInfo(
      {this.portfolioKey,
      this.brokerName,
      this.portfolioName,
      this.buyingPower,
      this.buyingPowerEquity,
      this.buyingPowerCrypto,
      this.buyingPowerOption,
      this.lastHardCheckAt});
  PortfolioFinancialInfo copyWith(
      {int? portfolioKey,
      BROKER_NAME? brokerName,
      String? portfolioName,
      double? buyingPower,
      double? buyingPowerEquity,
      double? buyingPowerCrypto,
      double? buyingPowerOption,
      DateTime? lastHardCheckAt}) {
    return PortfolioFinancialInfo(
      portfolioKey: portfolioKey ?? this.portfolioKey,
      brokerName: brokerName ?? this.brokerName,
      portfolioName: portfolioName ?? this.portfolioName,
      buyingPower: buyingPower ?? this.buyingPower,
      buyingPowerEquity: buyingPowerEquity ?? this.buyingPowerEquity,
      buyingPowerCrypto: buyingPowerCrypto ?? this.buyingPowerCrypto,
      buyingPowerOption: buyingPowerOption ?? this.buyingPowerOption,
      lastHardCheckAt: lastHardCheckAt ?? this.lastHardCheckAt,
    );
  }

  factory PortfolioFinancialInfo.fromJson(Map<String, dynamic> json) {
    return PortfolioFinancialInfo(
      portfolioKey: json['portfolioKey'],
      brokerName: json['brokerName'] != null
          ? BROKER_NAME.values.byName(json['brokerName'])
          : null,
      portfolioName: json['portfolioName'],
      buyingPower: json['buyingPower']?.toDouble(),
      buyingPowerEquity: json['buyingPowerEquity']?.toDouble(),
      buyingPowerCrypto: json['buyingPowerCrypto']?.toDouble(),
      buyingPowerOption: json['buyingPowerOption']?.toDouble(),
      lastHardCheckAt: json['lastHardCheckAt'] != null
          ? DateTime.parse(json['lastHardCheckAt'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioKey'] = portfolioKey;
    data['brokerName'] = brokerName?.name;
    data['portfolioName'] = portfolioName;
    data['buyingPower'] = buyingPower;
    data['buyingPowerEquity'] = buyingPowerEquity;
    data['buyingPowerCrypto'] = buyingPowerCrypto;
    data['buyingPowerOption'] = buyingPowerOption;
    data['lastHardCheckAt'] = lastHardCheckAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioFinancialInfo &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.brokerName, brokerName) ||
                const DeepCollectionEquality()
                    .equals(other.brokerName, brokerName)) &&
            (identical(other.portfolioName, portfolioName) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioName, portfolioName)) &&
            (identical(other.buyingPower, buyingPower) ||
                const DeepCollectionEquality()
                    .equals(other.buyingPower, buyingPower)) &&
            (identical(other.buyingPowerEquity, buyingPowerEquity) ||
                const DeepCollectionEquality()
                    .equals(other.buyingPowerEquity, buyingPowerEquity)) &&
            (identical(other.buyingPowerCrypto, buyingPowerCrypto) ||
                const DeepCollectionEquality()
                    .equals(other.buyingPowerCrypto, buyingPowerCrypto)) &&
            (identical(other.buyingPowerOption, buyingPowerOption) ||
                const DeepCollectionEquality()
                    .equals(other.buyingPowerOption, buyingPowerOption)) &&
            (identical(other.lastHardCheckAt, lastHardCheckAt) ||
                const DeepCollectionEquality()
                    .equals(other.lastHardCheckAt, lastHardCheckAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(brokerName) ^
        const DeepCollectionEquality().hash(portfolioName) ^
        const DeepCollectionEquality().hash(buyingPower) ^
        const DeepCollectionEquality().hash(buyingPowerEquity) ^
        const DeepCollectionEquality().hash(buyingPowerCrypto) ^
        const DeepCollectionEquality().hash(buyingPowerOption) ^
        const DeepCollectionEquality().hash(lastHardCheckAt);
  }

  @override
  String toString() => 'PortfolioFinancialInfo(${toJson()})';
}
