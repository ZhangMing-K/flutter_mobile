import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class JediPortfolioScreeningData {
  final Portfolio? portfolio;
  final double? buyingPower;
  final double? accountValue;
  const JediPortfolioScreeningData(
      {this.portfolio, this.buyingPower, this.accountValue});
  JediPortfolioScreeningData copyWith(
      {Portfolio? portfolio, double? buyingPower, double? accountValue}) {
    return JediPortfolioScreeningData(
      portfolio: portfolio ?? this.portfolio,
      buyingPower: buyingPower ?? this.buyingPower,
      accountValue: accountValue ?? this.accountValue,
    );
  }

  factory JediPortfolioScreeningData.fromJson(Map<String, dynamic> json) {
    return JediPortfolioScreeningData(
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      buyingPower: json['buyingPower']?.toDouble(),
      accountValue: json['accountValue']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolio'] = portfolio?.toJson();
    data['buyingPower'] = buyingPower;
    data['accountValue'] = accountValue;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediPortfolioScreeningData &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.buyingPower, buyingPower) ||
                const DeepCollectionEquality()
                    .equals(other.buyingPower, buyingPower)) &&
            (identical(other.accountValue, accountValue) ||
                const DeepCollectionEquality()
                    .equals(other.accountValue, accountValue)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(buyingPower) ^
        const DeepCollectionEquality().hash(accountValue);
  }

  @override
  String toString() => 'JediPortfolioScreeningData(${toJson()})';
}
