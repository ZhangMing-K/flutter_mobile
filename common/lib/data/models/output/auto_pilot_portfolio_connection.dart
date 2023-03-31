import 'package:collection/collection.dart';

class AutoPilotPortfolioConnection {
  final double? autoPilotValue;
  final double? profitLoss;
  final double? autoPilotBuyingPower;
  const AutoPilotPortfolioConnection(
      {this.autoPilotValue, this.profitLoss, this.autoPilotBuyingPower});
  AutoPilotPortfolioConnection copyWith(
      {double? autoPilotValue,
      double? profitLoss,
      double? autoPilotBuyingPower}) {
    return AutoPilotPortfolioConnection(
      autoPilotValue: autoPilotValue ?? this.autoPilotValue,
      profitLoss: profitLoss ?? this.profitLoss,
      autoPilotBuyingPower: autoPilotBuyingPower ?? this.autoPilotBuyingPower,
    );
  }

  factory AutoPilotPortfolioConnection.fromJson(Map<String, dynamic> json) {
    return AutoPilotPortfolioConnection(
      autoPilotValue: json['autoPilotValue']?.toDouble(),
      profitLoss: json['profitLoss']?.toDouble(),
      autoPilotBuyingPower: json['autoPilotBuyingPower']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotValue'] = autoPilotValue;
    data['profitLoss'] = profitLoss;
    data['autoPilotBuyingPower'] = autoPilotBuyingPower;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotPortfolioConnection &&
            (identical(other.autoPilotValue, autoPilotValue) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotValue, autoPilotValue)) &&
            (identical(other.profitLoss, profitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.profitLoss, profitLoss)) &&
            (identical(other.autoPilotBuyingPower, autoPilotBuyingPower) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotBuyingPower, autoPilotBuyingPower)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotValue) ^
        const DeepCollectionEquality().hash(profitLoss) ^
        const DeepCollectionEquality().hash(autoPilotBuyingPower);
  }

  @override
  String toString() => 'AutoPilotPortfolioConnection(${toJson()})';
}
