import 'package:iris_common/data/models/enums/execution_type.dart';
import 'package:iris_common/data/models/enums/auto_pilot_settings_status.dart';
import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/enums/dollar_cost_average_interval.dart';
import 'package:iris_common/data/models/enums/autopilot_dca_status.dart';
import 'package:collection/collection.dart';

class AutoPilotSettingsCreateInput {
  final int? masterPortfolioKey;
  final int? slavePortfolioKey;
  final int? slaveUserKey;
  final double? allocationAmount;
  final EXECUTION_TYPE? executionType;
  final AUTO_PILOT_SETTINGS_STATUS? status;
  final List<POSITION_TYPE>? positionTypesToTrade;
  final List<int>? whitelistedAssetKeys;
  final bool? tradeEquityFractionals;
  final bool? tradeOptionsFractionals;
  final bool? tradeCryptoFractionals;
  final double? dollarCostAverageCeilingAmount;
  final double? dollarCostAverageAmount;
  final bool? cashIsPosition;
  final bool? trimmingEnabled;
  final DOLLAR_COST_AVERAGE_INTERVAL? dollarCostAverageInterval;
  final AUTOPILOT_DCA_STATUS? dollarCostAverageStatus;
  const AutoPilotSettingsCreateInput(
      {required this.masterPortfolioKey,
      this.slavePortfolioKey,
      required this.slaveUserKey,
      this.allocationAmount,
      this.executionType,
      this.status,
      this.positionTypesToTrade,
      this.whitelistedAssetKeys,
      this.tradeEquityFractionals,
      this.tradeOptionsFractionals,
      this.tradeCryptoFractionals,
      this.dollarCostAverageCeilingAmount,
      this.dollarCostAverageAmount,
      this.cashIsPosition,
      this.trimmingEnabled,
      this.dollarCostAverageInterval,
      this.dollarCostAverageStatus});
  AutoPilotSettingsCreateInput copyWith(
      {int? masterPortfolioKey,
      int? slavePortfolioKey,
      int? slaveUserKey,
      double? allocationAmount,
      EXECUTION_TYPE? executionType,
      AUTO_PILOT_SETTINGS_STATUS? status,
      List<POSITION_TYPE>? positionTypesToTrade,
      List<int>? whitelistedAssetKeys,
      bool? tradeEquityFractionals,
      bool? tradeOptionsFractionals,
      bool? tradeCryptoFractionals,
      double? dollarCostAverageCeilingAmount,
      double? dollarCostAverageAmount,
      bool? cashIsPosition,
      bool? trimmingEnabled,
      DOLLAR_COST_AVERAGE_INTERVAL? dollarCostAverageInterval,
      AUTOPILOT_DCA_STATUS? dollarCostAverageStatus}) {
    return AutoPilotSettingsCreateInput(
      masterPortfolioKey: masterPortfolioKey ?? this.masterPortfolioKey,
      slavePortfolioKey: slavePortfolioKey ?? this.slavePortfolioKey,
      slaveUserKey: slaveUserKey ?? this.slaveUserKey,
      allocationAmount: allocationAmount ?? this.allocationAmount,
      executionType: executionType ?? this.executionType,
      status: status ?? this.status,
      positionTypesToTrade: positionTypesToTrade ?? this.positionTypesToTrade,
      whitelistedAssetKeys: whitelistedAssetKeys ?? this.whitelistedAssetKeys,
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
      cashIsPosition: cashIsPosition ?? this.cashIsPosition,
      trimmingEnabled: trimmingEnabled ?? this.trimmingEnabled,
      dollarCostAverageInterval:
          dollarCostAverageInterval ?? this.dollarCostAverageInterval,
      dollarCostAverageStatus:
          dollarCostAverageStatus ?? this.dollarCostAverageStatus,
    );
  }

  factory AutoPilotSettingsCreateInput.fromJson(Map<String, dynamic> json) {
    return AutoPilotSettingsCreateInput(
      masterPortfolioKey: json['masterPortfolioKey'],
      slavePortfolioKey: json['slavePortfolioKey'],
      slaveUserKey: json['slaveUserKey'],
      allocationAmount: json['allocationAmount']?.toDouble(),
      executionType: json['executionType'] != null
          ? EXECUTION_TYPE.values.byName(json['executionType'])
          : null,
      status: json['status'] != null
          ? AUTO_PILOT_SETTINGS_STATUS.values.byName(json['status'])
          : null,
      positionTypesToTrade: json['positionTypesToTrade']
          ?.map<POSITION_TYPE>((o) => POSITION_TYPE.values.byName(o))
          .toList(),
      whitelistedAssetKeys:
          json['whitelistedAssetKeys']?.map<int>((o) => (o as int)).toList(),
      tradeEquityFractionals: json['tradeEquityFractionals'],
      tradeOptionsFractionals: json['tradeOptionsFractionals'],
      tradeCryptoFractionals: json['tradeCryptoFractionals'],
      dollarCostAverageCeilingAmount:
          json['dollarCostAverageCeilingAmount']?.toDouble(),
      dollarCostAverageAmount: json['dollarCostAverageAmount']?.toDouble(),
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
    data['masterPortfolioKey'] = masterPortfolioKey;
    data['slavePortfolioKey'] = slavePortfolioKey;
    data['slaveUserKey'] = slaveUserKey;
    data['allocationAmount'] = allocationAmount;
    data['executionType'] = executionType?.name;
    data['status'] = status?.name;
    data['positionTypesToTrade'] =
        positionTypesToTrade?.map((item) => item.name).toList();
    data['whitelistedAssetKeys'] = whitelistedAssetKeys;
    data['tradeEquityFractionals'] = tradeEquityFractionals;
    data['tradeOptionsFractionals'] = tradeOptionsFractionals;
    data['tradeCryptoFractionals'] = tradeCryptoFractionals;
    data['dollarCostAverageCeilingAmount'] = dollarCostAverageCeilingAmount;
    data['dollarCostAverageAmount'] = dollarCostAverageAmount;
    data['cashIsPosition'] = cashIsPosition;
    data['trimmingEnabled'] = trimmingEnabled;
    data['dollarCostAverageInterval'] = dollarCostAverageInterval?.name;
    data['dollarCostAverageStatus'] = dollarCostAverageStatus?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettingsCreateInput &&
            (identical(other.masterPortfolioKey, masterPortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.masterPortfolioKey, masterPortfolioKey)) &&
            (identical(other.slavePortfolioKey, slavePortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.slavePortfolioKey, slavePortfolioKey)) &&
            (identical(other.slaveUserKey, slaveUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.slaveUserKey, slaveUserKey)) &&
            (identical(other.allocationAmount, allocationAmount) ||
                const DeepCollectionEquality()
                    .equals(other.allocationAmount, allocationAmount)) &&
            (identical(other.executionType, executionType) ||
                const DeepCollectionEquality()
                    .equals(other.executionType, executionType)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.positionTypesToTrade, positionTypesToTrade) ||
                const DeepCollectionEquality().equals(
                    other.positionTypesToTrade, positionTypesToTrade)) &&
            (identical(other.whitelistedAssetKeys, whitelistedAssetKeys) ||
                const DeepCollectionEquality().equals(
                    other.whitelistedAssetKeys, whitelistedAssetKeys)) &&
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
        const DeepCollectionEquality().hash(masterPortfolioKey) ^
        const DeepCollectionEquality().hash(slavePortfolioKey) ^
        const DeepCollectionEquality().hash(slaveUserKey) ^
        const DeepCollectionEquality().hash(allocationAmount) ^
        const DeepCollectionEquality().hash(executionType) ^
        const DeepCollectionEquality().hash(status) ^
        const DeepCollectionEquality().hash(positionTypesToTrade) ^
        const DeepCollectionEquality().hash(whitelistedAssetKeys) ^
        const DeepCollectionEquality().hash(tradeEquityFractionals) ^
        const DeepCollectionEquality().hash(tradeOptionsFractionals) ^
        const DeepCollectionEquality().hash(tradeCryptoFractionals) ^
        const DeepCollectionEquality().hash(dollarCostAverageCeilingAmount) ^
        const DeepCollectionEquality().hash(dollarCostAverageAmount) ^
        const DeepCollectionEquality().hash(cashIsPosition) ^
        const DeepCollectionEquality().hash(trimmingEnabled) ^
        const DeepCollectionEquality().hash(dollarCostAverageInterval) ^
        const DeepCollectionEquality().hash(dollarCostAverageStatus);
  }

  @override
  String toString() => 'AutoPilotSettingsCreateInput(${toJson()})';
}
