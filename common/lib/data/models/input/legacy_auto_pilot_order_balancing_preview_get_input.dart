import 'package:iris_common/data/models/enums/balance_type.dart';
import 'package:collection/collection.dart';

class LegacyAutoPilotOrderBalancingPreviewGetInput {
  final int? autoPilotSettingsKey;
  final int? masterPortfolioKey;
  final int? slavePortfolioKey;
  final int? slaveUserKey;
  final bool? syncToMaster;
  final bool? allocateRemainingBuyingPower;
  final bool? closeOutStandingPositions;
  final BALANCE_TYPE? balanceType;
  final int? amount;
  final int? nbrPositionsToInclude;
  final bool? balanceToEligibleFullShares;
  final bool? cashIsPosition;
  const LegacyAutoPilotOrderBalancingPreviewGetInput(
      {this.autoPilotSettingsKey,
      this.masterPortfolioKey,
      this.slavePortfolioKey,
      this.slaveUserKey,
      this.syncToMaster,
      this.allocateRemainingBuyingPower,
      this.closeOutStandingPositions,
      required this.balanceType,
      this.amount,
      this.nbrPositionsToInclude,
      this.balanceToEligibleFullShares,
      this.cashIsPosition});
  LegacyAutoPilotOrderBalancingPreviewGetInput copyWith(
      {int? autoPilotSettingsKey,
      int? masterPortfolioKey,
      int? slavePortfolioKey,
      int? slaveUserKey,
      bool? syncToMaster,
      bool? allocateRemainingBuyingPower,
      bool? closeOutStandingPositions,
      BALANCE_TYPE? balanceType,
      int? amount,
      int? nbrPositionsToInclude,
      bool? balanceToEligibleFullShares,
      bool? cashIsPosition}) {
    return LegacyAutoPilotOrderBalancingPreviewGetInput(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      masterPortfolioKey: masterPortfolioKey ?? this.masterPortfolioKey,
      slavePortfolioKey: slavePortfolioKey ?? this.slavePortfolioKey,
      slaveUserKey: slaveUserKey ?? this.slaveUserKey,
      syncToMaster: syncToMaster ?? this.syncToMaster,
      allocateRemainingBuyingPower:
          allocateRemainingBuyingPower ?? this.allocateRemainingBuyingPower,
      closeOutStandingPositions:
          closeOutStandingPositions ?? this.closeOutStandingPositions,
      balanceType: balanceType ?? this.balanceType,
      amount: amount ?? this.amount,
      nbrPositionsToInclude:
          nbrPositionsToInclude ?? this.nbrPositionsToInclude,
      balanceToEligibleFullShares:
          balanceToEligibleFullShares ?? this.balanceToEligibleFullShares,
      cashIsPosition: cashIsPosition ?? this.cashIsPosition,
    );
  }

  factory LegacyAutoPilotOrderBalancingPreviewGetInput.fromJson(
      Map<String, dynamic> json) {
    return LegacyAutoPilotOrderBalancingPreviewGetInput(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      masterPortfolioKey: json['masterPortfolioKey'],
      slavePortfolioKey: json['slavePortfolioKey'],
      slaveUserKey: json['slaveUserKey'],
      syncToMaster: json['syncToMaster'],
      allocateRemainingBuyingPower: json['allocateRemainingBuyingPower'],
      closeOutStandingPositions: json['closeOutStandingPositions'],
      balanceType: json['balanceType'] != null
          ? BALANCE_TYPE.values.byName(json['balanceType'])
          : null,
      amount: json['amount'],
      nbrPositionsToInclude: json['nbrPositionsToInclude'],
      balanceToEligibleFullShares: json['balanceToEligibleFullShares'],
      cashIsPosition: json['cashIsPosition'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['masterPortfolioKey'] = masterPortfolioKey;
    data['slavePortfolioKey'] = slavePortfolioKey;
    data['slaveUserKey'] = slaveUserKey;
    data['syncToMaster'] = syncToMaster;
    data['allocateRemainingBuyingPower'] = allocateRemainingBuyingPower;
    data['closeOutStandingPositions'] = closeOutStandingPositions;
    data['balanceType'] = balanceType?.name;
    data['amount'] = amount;
    data['nbrPositionsToInclude'] = nbrPositionsToInclude;
    data['balanceToEligibleFullShares'] = balanceToEligibleFullShares;
    data['cashIsPosition'] = cashIsPosition;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LegacyAutoPilotOrderBalancingPreviewGetInput &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.masterPortfolioKey, masterPortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.masterPortfolioKey, masterPortfolioKey)) &&
            (identical(other.slavePortfolioKey, slavePortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.slavePortfolioKey, slavePortfolioKey)) &&
            (identical(other.slaveUserKey, slaveUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.slaveUserKey, slaveUserKey)) &&
            (identical(other.syncToMaster, syncToMaster) ||
                const DeepCollectionEquality()
                    .equals(other.syncToMaster, syncToMaster)) &&
            (identical(other.allocateRemainingBuyingPower,
                    allocateRemainingBuyingPower) ||
                const DeepCollectionEquality().equals(
                    other.allocateRemainingBuyingPower,
                    allocateRemainingBuyingPower)) &&
            (identical(other.closeOutStandingPositions, closeOutStandingPositions) ||
                const DeepCollectionEquality().equals(
                    other.closeOutStandingPositions,
                    closeOutStandingPositions)) &&
            (identical(other.balanceType, balanceType) ||
                const DeepCollectionEquality()
                    .equals(other.balanceType, balanceType)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.nbrPositionsToInclude, nbrPositionsToInclude) ||
                const DeepCollectionEquality().equals(
                    other.nbrPositionsToInclude, nbrPositionsToInclude)) &&
            (identical(other.balanceToEligibleFullShares,
                    balanceToEligibleFullShares) ||
                const DeepCollectionEquality().equals(
                    other.balanceToEligibleFullShares,
                    balanceToEligibleFullShares)) &&
            (identical(other.cashIsPosition, cashIsPosition) ||
                const DeepCollectionEquality()
                    .equals(other.cashIsPosition, cashIsPosition)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(masterPortfolioKey) ^
        const DeepCollectionEquality().hash(slavePortfolioKey) ^
        const DeepCollectionEquality().hash(slaveUserKey) ^
        const DeepCollectionEquality().hash(syncToMaster) ^
        const DeepCollectionEquality().hash(allocateRemainingBuyingPower) ^
        const DeepCollectionEquality().hash(closeOutStandingPositions) ^
        const DeepCollectionEquality().hash(balanceType) ^
        const DeepCollectionEquality().hash(amount) ^
        const DeepCollectionEquality().hash(nbrPositionsToInclude) ^
        const DeepCollectionEquality().hash(balanceToEligibleFullShares) ^
        const DeepCollectionEquality().hash(cashIsPosition);
  }

  @override
  String toString() =>
      'LegacyAutoPilotOrderBalancingPreviewGetInput(${toJson()})';
}
