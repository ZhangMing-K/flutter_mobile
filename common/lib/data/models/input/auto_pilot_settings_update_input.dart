import 'package:iris_common/data/models/enums/execution_type.dart';
import 'package:iris_common/data/models/input/whitelist_option_input.dart';
import 'package:iris_common/data/models/input/position_types_option_input.dart';
import 'package:iris_common/data/models/enums/dollar_cost_average_interval.dart';
import 'package:iris_common/data/models/enums/autopilot_dca_status.dart';
import 'package:collection/collection.dart';

class AutoPilotSettingsUpdateInput {
  final int? autoPilotSettingsKey;
  final double? allocationAmount;
  final int? slavePortfolioKey;
  final EXECUTION_TYPE? executionType;
  final WhitelistOptionInput? whitelistOption;
  final PositionTypesOptionInput? positionTypesOption;
  final bool? tradeEquityFractionals;
  final bool? tradeOptionsFractionals;
  final bool? tradeCryptoFractionals;
  final int? dollarCostAverageCeilingAmount;
  final int? dollarCostAverageAmount;
  final int? subscriptionKey;
  final bool? cashIsPosition;
  final bool? trimmingEnabled;
  final DOLLAR_COST_AVERAGE_INTERVAL? dollarCostAverageInterval;
  final AUTOPILOT_DCA_STATUS? dollarCostAverageStatus;
  const AutoPilotSettingsUpdateInput(
      {required this.autoPilotSettingsKey,
      this.allocationAmount,
      this.slavePortfolioKey,
      this.executionType,
      this.whitelistOption,
      this.positionTypesOption,
      this.tradeEquityFractionals,
      this.tradeOptionsFractionals,
      this.tradeCryptoFractionals,
      this.dollarCostAverageCeilingAmount,
      this.dollarCostAverageAmount,
      this.subscriptionKey,
      this.cashIsPosition,
      this.trimmingEnabled,
      this.dollarCostAverageInterval,
      this.dollarCostAverageStatus});
  AutoPilotSettingsUpdateInput copyWith(
      {int? autoPilotSettingsKey,
      double? allocationAmount,
      int? slavePortfolioKey,
      EXECUTION_TYPE? executionType,
      WhitelistOptionInput? whitelistOption,
      PositionTypesOptionInput? positionTypesOption,
      bool? tradeEquityFractionals,
      bool? tradeOptionsFractionals,
      bool? tradeCryptoFractionals,
      int? dollarCostAverageCeilingAmount,
      int? dollarCostAverageAmount,
      int? subscriptionKey,
      bool? cashIsPosition,
      bool? trimmingEnabled,
      DOLLAR_COST_AVERAGE_INTERVAL? dollarCostAverageInterval,
      AUTOPILOT_DCA_STATUS? dollarCostAverageStatus}) {
    return AutoPilotSettingsUpdateInput(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      allocationAmount: allocationAmount ?? this.allocationAmount,
      slavePortfolioKey: slavePortfolioKey ?? this.slavePortfolioKey,
      executionType: executionType ?? this.executionType,
      whitelistOption: whitelistOption ?? this.whitelistOption,
      positionTypesOption: positionTypesOption ?? this.positionTypesOption,
      tradeEquityFractionals:
          tradeEquityFractionals ?? this.tradeEquityFractionals,
      tradeOptionsFractionals:
          tradeOptionsFractionals ?? this.tradeOptionsFractionals,
      tradeCryptoFractionals:
          tradeCryptoFractionals ?? this.tradeCryptoFractionals,
      dollarCostAverageCeilingAmount:
          dollarCostAverageCeilingAmount ?? this.dollarCostAverageCeilingAmount,
      dollarCostAverageAmount:
          dollarCostAverageAmount ?? this.dollarCostAverageAmount,
      subscriptionKey: subscriptionKey ?? this.subscriptionKey,
      cashIsPosition: cashIsPosition ?? this.cashIsPosition,
      trimmingEnabled: trimmingEnabled ?? this.trimmingEnabled,
      dollarCostAverageInterval:
          dollarCostAverageInterval ?? this.dollarCostAverageInterval,
      dollarCostAverageStatus:
          dollarCostAverageStatus ?? this.dollarCostAverageStatus,
    );
  }

  factory AutoPilotSettingsUpdateInput.fromJson(Map<String, dynamic> json) {
    return AutoPilotSettingsUpdateInput(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      allocationAmount: json['allocationAmount']?.toDouble(),
      slavePortfolioKey: json['slavePortfolioKey'],
      executionType: json['executionType'] != null
          ? EXECUTION_TYPE.values.byName(json['executionType'])
          : null,
      whitelistOption: json['whitelistOption'] != null
          ? WhitelistOptionInput.fromJson(json['whitelistOption'])
          : null,
      positionTypesOption: json['positionTypesOption'] != null
          ? PositionTypesOptionInput.fromJson(json['positionTypesOption'])
          : null,
      tradeEquityFractionals: json['tradeEquityFractionals'],
      tradeOptionsFractionals: json['tradeOptionsFractionals'],
      tradeCryptoFractionals: json['tradeCryptoFractionals'],
      dollarCostAverageCeilingAmount: json['dollarCostAverageCeilingAmount'],
      dollarCostAverageAmount: json['dollarCostAverageAmount'],
      subscriptionKey: json['subscriptionKey'],
      cashIsPosition: json['cashIsPosition'],
      trimmingEnabled: json['trimmingEnabled'],
      dollarCostAverageInterval: json['dollarCostAverageInterval'] != null
          ? DOLLAR_COST_AVERAGE_INTERVAL.values
              .byName(json['dollarCostAverageInterval'])
          : null,
      dollarCostAverageStatus: json['dollarCostAverageStatus'] != null
          ? AUTOPILOT_DCA_STATUS.values.byName(json['dollarCostAverageStatus'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['allocationAmount'] = allocationAmount;
    data['slavePortfolioKey'] = slavePortfolioKey;
    data['executionType'] = executionType?.name;
    data['whitelistOption'] = whitelistOption?.toJson();
    data['positionTypesOption'] = positionTypesOption?.toJson();
    data['tradeEquityFractionals'] = tradeEquityFractionals;
    data['tradeOptionsFractionals'] = tradeOptionsFractionals;
    data['tradeCryptoFractionals'] = tradeCryptoFractionals;
    data['dollarCostAverageCeilingAmount'] = dollarCostAverageCeilingAmount;
    data['dollarCostAverageAmount'] = dollarCostAverageAmount;
    data['subscriptionKey'] = subscriptionKey;
    data['cashIsPosition'] = cashIsPosition;
    data['trimmingEnabled'] = trimmingEnabled;
    data['dollarCostAverageInterval'] = dollarCostAverageInterval?.name;
    data['dollarCostAverageStatus'] = dollarCostAverageStatus?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettingsUpdateInput &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.allocationAmount, allocationAmount) ||
                const DeepCollectionEquality()
                    .equals(other.allocationAmount, allocationAmount)) &&
            (identical(other.slavePortfolioKey, slavePortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.slavePortfolioKey, slavePortfolioKey)) &&
            (identical(other.executionType, executionType) ||
                const DeepCollectionEquality()
                    .equals(other.executionType, executionType)) &&
            (identical(other.whitelistOption, whitelistOption) ||
                const DeepCollectionEquality()
                    .equals(other.whitelistOption, whitelistOption)) &&
            (identical(other.positionTypesOption, positionTypesOption) ||
                const DeepCollectionEquality()
                    .equals(other.positionTypesOption, positionTypesOption)) &&
            (identical(other.tradeEquityFractionals, tradeEquityFractionals) ||
                const DeepCollectionEquality().equals(
                    other.tradeEquityFractionals, tradeEquityFractionals)) &&
            (identical(other.tradeOptionsFractionals, tradeOptionsFractionals) ||
                const DeepCollectionEquality().equals(
                    other.tradeOptionsFractionals, tradeOptionsFractionals)) &&
            (identical(other.tradeCryptoFractionals, tradeCryptoFractionals) ||
                const DeepCollectionEquality().equals(
                    other.tradeCryptoFractionals, tradeCryptoFractionals)) &&
            (identical(other.dollarCostAverageCeilingAmount, dollarCostAverageCeilingAmount) ||
                const DeepCollectionEquality().equals(
                    other.dollarCostAverageCeilingAmount,
                    dollarCostAverageCeilingAmount)) &&
            (identical(other.dollarCostAverageAmount, dollarCostAverageAmount) ||
                const DeepCollectionEquality().equals(
                    other.dollarCostAverageAmount, dollarCostAverageAmount)) &&
            (identical(other.subscriptionKey, subscriptionKey) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionKey, subscriptionKey)) &&
            (identical(other.cashIsPosition, cashIsPosition) ||
                const DeepCollectionEquality()
                    .equals(other.cashIsPosition, cashIsPosition)) &&
            (identical(other.trimmingEnabled, trimmingEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.trimmingEnabled, trimmingEnabled)) &&
            (identical(other.dollarCostAverageInterval, dollarCostAverageInterval) ||
                const DeepCollectionEquality().equals(
                    other.dollarCostAverageInterval,
                    dollarCostAverageInterval)) &&
            (identical(other.dollarCostAverageStatus, dollarCostAverageStatus) || const DeepCollectionEquality().equals(other.dollarCostAverageStatus, dollarCostAverageStatus)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(allocationAmount) ^
        const DeepCollectionEquality().hash(slavePortfolioKey) ^
        const DeepCollectionEquality().hash(executionType) ^
        const DeepCollectionEquality().hash(whitelistOption) ^
        const DeepCollectionEquality().hash(positionTypesOption) ^
        const DeepCollectionEquality().hash(tradeEquityFractionals) ^
        const DeepCollectionEquality().hash(tradeOptionsFractionals) ^
        const DeepCollectionEquality().hash(tradeCryptoFractionals) ^
        const DeepCollectionEquality().hash(dollarCostAverageCeilingAmount) ^
        const DeepCollectionEquality().hash(dollarCostAverageAmount) ^
        const DeepCollectionEquality().hash(subscriptionKey) ^
        const DeepCollectionEquality().hash(cashIsPosition) ^
        const DeepCollectionEquality().hash(trimmingEnabled) ^
        const DeepCollectionEquality().hash(dollarCostAverageInterval) ^
        const DeepCollectionEquality().hash(dollarCostAverageStatus);
  }

  @override
  String toString() => 'AutoPilotSettingsUpdateInput(${toJson()})';
}
