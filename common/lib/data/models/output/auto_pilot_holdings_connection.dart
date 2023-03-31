import 'package:iris_common/data/models/output/auto_pilot_portfolio_current_holding.dart';
import 'package:collection/collection.dart';

class AutoPilotHoldingsConnection {
  final List<AutoPilotPortfolioCurrentHolding>? currentHoldings;
  const AutoPilotHoldingsConnection({required this.currentHoldings});
  AutoPilotHoldingsConnection copyWith(
      {List<AutoPilotPortfolioCurrentHolding>? currentHoldings}) {
    return AutoPilotHoldingsConnection(
      currentHoldings: currentHoldings ?? this.currentHoldings,
    );
  }

  factory AutoPilotHoldingsConnection.fromJson(Map<String, dynamic> json) {
    return AutoPilotHoldingsConnection(
      currentHoldings: json['currentHoldings']
          ?.map<AutoPilotPortfolioCurrentHolding>(
              (o) => AutoPilotPortfolioCurrentHolding.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['currentHoldings'] =
        currentHoldings?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotHoldingsConnection &&
            (identical(other.currentHoldings, currentHoldings) ||
                const DeepCollectionEquality()
                    .equals(other.currentHoldings, currentHoldings)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(currentHoldings);
  }

  @override
  String toString() => 'AutoPilotHoldingsConnection(${toJson()})';
}
