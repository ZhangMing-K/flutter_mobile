import 'package:collection/collection.dart';

class JediAutoPilotPortfolioFeatureArgs {
  final int? masterPortfolioKey;
  final bool? feature;
  final bool? cashIsPosition;
  final int? maxCashPositionAmount;
  const JediAutoPilotPortfolioFeatureArgs(
      {required this.masterPortfolioKey,
      this.feature,
      this.cashIsPosition,
      this.maxCashPositionAmount});
  JediAutoPilotPortfolioFeatureArgs copyWith(
      {int? masterPortfolioKey,
      bool? feature,
      bool? cashIsPosition,
      int? maxCashPositionAmount}) {
    return JediAutoPilotPortfolioFeatureArgs(
      masterPortfolioKey: masterPortfolioKey ?? this.masterPortfolioKey,
      feature: feature ?? this.feature,
      cashIsPosition: cashIsPosition ?? this.cashIsPosition,
      maxCashPositionAmount:
          maxCashPositionAmount ?? this.maxCashPositionAmount,
    );
  }

  factory JediAutoPilotPortfolioFeatureArgs.fromJson(
      Map<String, dynamic> json) {
    return JediAutoPilotPortfolioFeatureArgs(
      masterPortfolioKey: json['masterPortfolioKey'],
      feature: json['feature'],
      cashIsPosition: json['cashIsPosition'],
      maxCashPositionAmount: json['maxCashPositionAmount'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['masterPortfolioKey'] = masterPortfolioKey;
    data['feature'] = feature;
    data['cashIsPosition'] = cashIsPosition;
    data['maxCashPositionAmount'] = maxCashPositionAmount;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotPortfolioFeatureArgs &&
            (identical(other.masterPortfolioKey, masterPortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.masterPortfolioKey, masterPortfolioKey)) &&
            (identical(other.feature, feature) ||
                const DeepCollectionEquality()
                    .equals(other.feature, feature)) &&
            (identical(other.cashIsPosition, cashIsPosition) ||
                const DeepCollectionEquality()
                    .equals(other.cashIsPosition, cashIsPosition)) &&
            (identical(other.maxCashPositionAmount, maxCashPositionAmount) ||
                const DeepCollectionEquality().equals(
                    other.maxCashPositionAmount, maxCashPositionAmount)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(masterPortfolioKey) ^
        const DeepCollectionEquality().hash(feature) ^
        const DeepCollectionEquality().hash(cashIsPosition) ^
        const DeepCollectionEquality().hash(maxCashPositionAmount);
  }

  @override
  String toString() => 'JediAutoPilotPortfolioFeatureArgs(${toJson()})';
}
