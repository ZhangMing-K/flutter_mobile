import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/enums/allocation_type.dart';
import 'package:iris_common/data/models/enums/auto_pilot_settings_status.dart';
import 'package:iris_common/data/models/enums/setup_status.dart';
import 'package:iris_common/data/models/enums/execution_type.dart';
import 'package:iris_common/data/models/output/auto_pilot_expected_return_connection.dart';
import 'package:iris_common/data/models/enums/dollar_cost_average_interval.dart';
import 'package:iris_common/data/models/enums/autopilot_dca_status.dart';
import 'package:iris_common/data/models/output/auto_pilot_portfolio_connection.dart';
import 'package:iris_common/data/models/enums/auto_pilot_onboarding_step.dart';
import 'package:collection/collection.dart';

class AutoPilotSettings {
  final int? autoPilotSettingsKey;
  final int? masterUserKey;
  final User? masterUser;
  final int? masterPortfolioKey;
  final Portfolio? masterPortfolio;
  final int? slaveUserKey;
  final User? slaveUser;
  final int? slavePortfolioKey;
  final Portfolio? slavePortfolio;
  final double? allocationAmount;
  final double? allocationPercent;
  final ALLOCATION_TYPE? allocationType;
  final AUTO_PILOT_SETTINGS_STATUS? status;
  final SETUP_STATUS? setupStatus;
  final EXECUTION_TYPE? executionType;
  final bool? tradeEquityFractionals;
  final bool? tradeOptionsFractionals;
  final bool? tradeCryptoFractionals;
  final int? dollarCostAverageCeilingAmount;
  final int? dollarCostAverageAmount;
  final int? subscriptionKey;
  final AutoPilotExpectedReturnConnection? expectedReturnConnection;
  final DOLLAR_COST_AVERAGE_INTERVAL? dollarCostAverageInterval;
  final AUTOPILOT_DCA_STATUS? dollarCostAverageStatus;
  final AutoPilotPortfolioConnection? autoPilotPortfolioConnection;
  final double? brokerBuyingPower;
  final List<AUTO_PILOT_ONBOARDING_STEP>? missingOnboardingSteps;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const AutoPilotSettings(
      {this.autoPilotSettingsKey,
      this.masterUserKey,
      this.masterUser,
      this.masterPortfolioKey,
      this.masterPortfolio,
      this.slaveUserKey,
      this.slaveUser,
      this.slavePortfolioKey,
      this.slavePortfolio,
      this.allocationAmount,
      this.allocationPercent,
      this.allocationType,
      this.status,
      this.setupStatus,
      this.executionType,
      this.tradeEquityFractionals,
      this.tradeOptionsFractionals,
      this.tradeCryptoFractionals,
      this.dollarCostAverageCeilingAmount,
      this.dollarCostAverageAmount,
      this.subscriptionKey,
      this.expectedReturnConnection,
      this.dollarCostAverageInterval,
      this.dollarCostAverageStatus,
      this.autoPilotPortfolioConnection,
      this.brokerBuyingPower,
      this.missingOnboardingSteps,
      this.createdAt,
      this.updatedAt});
  AutoPilotSettings copyWith(
      {int? autoPilotSettingsKey,
      int? masterUserKey,
      User? masterUser,
      int? masterPortfolioKey,
      Portfolio? masterPortfolio,
      int? slaveUserKey,
      User? slaveUser,
      int? slavePortfolioKey,
      Portfolio? slavePortfolio,
      double? allocationAmount,
      double? allocationPercent,
      ALLOCATION_TYPE? allocationType,
      AUTO_PILOT_SETTINGS_STATUS? status,
      SETUP_STATUS? setupStatus,
      EXECUTION_TYPE? executionType,
      bool? tradeEquityFractionals,
      bool? tradeOptionsFractionals,
      bool? tradeCryptoFractionals,
      int? dollarCostAverageCeilingAmount,
      int? dollarCostAverageAmount,
      int? subscriptionKey,
      AutoPilotExpectedReturnConnection? expectedReturnConnection,
      DOLLAR_COST_AVERAGE_INTERVAL? dollarCostAverageInterval,
      AUTOPILOT_DCA_STATUS? dollarCostAverageStatus,
      AutoPilotPortfolioConnection? autoPilotPortfolioConnection,
      double? brokerBuyingPower,
      List<AUTO_PILOT_ONBOARDING_STEP>? missingOnboardingSteps,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return AutoPilotSettings(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      masterUserKey: masterUserKey ?? this.masterUserKey,
      masterUser: masterUser ?? this.masterUser,
      masterPortfolioKey: masterPortfolioKey ?? this.masterPortfolioKey,
      masterPortfolio: masterPortfolio ?? this.masterPortfolio,
      slaveUserKey: slaveUserKey ?? this.slaveUserKey,
      slaveUser: slaveUser ?? this.slaveUser,
      slavePortfolioKey: slavePortfolioKey ?? this.slavePortfolioKey,
      slavePortfolio: slavePortfolio ?? this.slavePortfolio,
      allocationAmount: allocationAmount ?? this.allocationAmount,
      allocationPercent: allocationPercent ?? this.allocationPercent,
      allocationType: allocationType ?? this.allocationType,
      status: status ?? this.status,
      setupStatus: setupStatus ?? this.setupStatus,
      executionType: executionType ?? this.executionType,
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
      expectedReturnConnection:
          expectedReturnConnection ?? this.expectedReturnConnection,
      dollarCostAverageInterval:
          dollarCostAverageInterval ?? this.dollarCostAverageInterval,
      dollarCostAverageStatus:
          dollarCostAverageStatus ?? this.dollarCostAverageStatus,
      autoPilotPortfolioConnection:
          autoPilotPortfolioConnection ?? this.autoPilotPortfolioConnection,
      brokerBuyingPower: brokerBuyingPower ?? this.brokerBuyingPower,
      missingOnboardingSteps:
          missingOnboardingSteps ?? this.missingOnboardingSteps,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory AutoPilotSettings.fromJson(Map<String, dynamic> json) {
    return AutoPilotSettings(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      masterUserKey: json['masterUserKey'],
      masterUser:
          json['masterUser'] != null ? User.fromJson(json['masterUser']) : null,
      masterPortfolioKey: json['masterPortfolioKey'],
      masterPortfolio: json['masterPortfolio'] != null
          ? Portfolio.fromJson(json['masterPortfolio'])
          : null,
      slaveUserKey: json['slaveUserKey'],
      slaveUser:
          json['slaveUser'] != null ? User.fromJson(json['slaveUser']) : null,
      slavePortfolioKey: json['slavePortfolioKey'],
      slavePortfolio: json['slavePortfolio'] != null
          ? Portfolio.fromJson(json['slavePortfolio'])
          : null,
      allocationAmount: json['allocationAmount']?.toDouble(),
      allocationPercent: json['allocationPercent']?.toDouble(),
      allocationType: json['allocationType'] != null
          ? ALLOCATION_TYPE.values.byName(json['allocationType'])
          : null,
      status: json['status'] != null
          ? AUTO_PILOT_SETTINGS_STATUS.values.byName(json['status'])
          : null,
      setupStatus: json['setupStatus'] != null
          ? SETUP_STATUS.values.byName(json['setupStatus'])
          : null,
      executionType: json['executionType'] != null
          ? EXECUTION_TYPE.values.byName(json['executionType'])
          : null,
      tradeEquityFractionals: json['tradeEquityFractionals'],
      tradeOptionsFractionals: json['tradeOptionsFractionals'],
      tradeCryptoFractionals: json['tradeCryptoFractionals'],
      dollarCostAverageCeilingAmount: json['dollarCostAverageCeilingAmount'],
      dollarCostAverageAmount: json['dollarCostAverageAmount'],
      subscriptionKey: json['subscriptionKey'],
      expectedReturnConnection: json['expectedReturnConnection'] != null
          ? AutoPilotExpectedReturnConnection.fromJson(
              json['expectedReturnConnection'])
          : null,
      dollarCostAverageInterval: json['dollarCostAverageInterval'] != null
          ? DOLLAR_COST_AVERAGE_INTERVAL.values
              .byName(json['dollarCostAverageInterval'])
          : null,
      dollarCostAverageStatus: json['dollarCostAverageStatus'] != null
          ? AUTOPILOT_DCA_STATUS.values.byName(json['dollarCostAverageStatus'])
          : null,
      autoPilotPortfolioConnection: json['autoPilotPortfolioConnection'] != null
          ? AutoPilotPortfolioConnection.fromJson(
              json['autoPilotPortfolioConnection'])
          : null,
      brokerBuyingPower: json['brokerBuyingPower']?.toDouble(),
      missingOnboardingSteps: json['missingOnboardingSteps']
          ?.map<AUTO_PILOT_ONBOARDING_STEP>(
              (o) => AUTO_PILOT_ONBOARDING_STEP.values.byName(o))
          .toList(),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['masterUserKey'] = masterUserKey;
    data['masterUser'] = masterUser?.toJson();
    data['masterPortfolioKey'] = masterPortfolioKey;
    data['masterPortfolio'] = masterPortfolio?.toJson();
    data['slaveUserKey'] = slaveUserKey;
    data['slaveUser'] = slaveUser?.toJson();
    data['slavePortfolioKey'] = slavePortfolioKey;
    data['slavePortfolio'] = slavePortfolio?.toJson();
    data['allocationAmount'] = allocationAmount;
    data['allocationPercent'] = allocationPercent;
    data['allocationType'] = allocationType?.name;
    data['status'] = status?.name;
    data['setupStatus'] = setupStatus?.name;
    data['executionType'] = executionType?.name;
    data['tradeEquityFractionals'] = tradeEquityFractionals;
    data['tradeOptionsFractionals'] = tradeOptionsFractionals;
    data['tradeCryptoFractionals'] = tradeCryptoFractionals;
    data['dollarCostAverageCeilingAmount'] = dollarCostAverageCeilingAmount;
    data['dollarCostAverageAmount'] = dollarCostAverageAmount;
    data['subscriptionKey'] = subscriptionKey;
    data['expectedReturnConnection'] = expectedReturnConnection?.toJson();
    data['dollarCostAverageInterval'] = dollarCostAverageInterval?.name;
    data['dollarCostAverageStatus'] = dollarCostAverageStatus?.name;
    data['autoPilotPortfolioConnection'] =
        autoPilotPortfolioConnection?.toJson();
    data['brokerBuyingPower'] = brokerBuyingPower;
    data['missingOnboardingSteps'] =
        missingOnboardingSteps?.map((item) => item.name).toList();
    data['createdAt'] = createdAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettings &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.masterUserKey, masterUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.masterUserKey, masterUserKey)) &&
            (identical(other.masterUser, masterUser) ||
                const DeepCollectionEquality()
                    .equals(other.masterUser, masterUser)) &&
            (identical(other.masterPortfolioKey, masterPortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.masterPortfolioKey, masterPortfolioKey)) &&
            (identical(other.masterPortfolio, masterPortfolio) ||
                const DeepCollectionEquality()
                    .equals(other.masterPortfolio, masterPortfolio)) &&
            (identical(other.slaveUserKey, slaveUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.slaveUserKey, slaveUserKey)) &&
            (identical(other.slaveUser, slaveUser) ||
                const DeepCollectionEquality()
                    .equals(other.slaveUser, slaveUser)) &&
            (identical(other.slavePortfolioKey, slavePortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.slavePortfolioKey, slavePortfolioKey)) &&
            (identical(other.slavePortfolio, slavePortfolio) ||
                const DeepCollectionEquality()
                    .equals(other.slavePortfolio, slavePortfolio)) &&
            (identical(other.allocationAmount, allocationAmount) ||
                const DeepCollectionEquality()
                    .equals(other.allocationAmount, allocationAmount)) &&
            (identical(other.allocationPercent, allocationPercent) ||
                const DeepCollectionEquality()
                    .equals(other.allocationPercent, allocationPercent)) &&
            (identical(other.allocationType, allocationType) ||
                const DeepCollectionEquality()
                    .equals(other.allocationType, allocationType)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.setupStatus, setupStatus) ||
                const DeepCollectionEquality()
                    .equals(other.setupStatus, setupStatus)) &&
            (identical(other.executionType, executionType) ||
                const DeepCollectionEquality()
                    .equals(other.executionType, executionType)) &&
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
            (identical(other.subscriptionKey, subscriptionKey) || const DeepCollectionEquality().equals(other.subscriptionKey, subscriptionKey)) &&
            (identical(other.expectedReturnConnection, expectedReturnConnection) || const DeepCollectionEquality().equals(other.expectedReturnConnection, expectedReturnConnection)) &&
            (identical(other.dollarCostAverageInterval, dollarCostAverageInterval) || const DeepCollectionEquality().equals(other.dollarCostAverageInterval, dollarCostAverageInterval)) &&
            (identical(other.dollarCostAverageStatus, dollarCostAverageStatus) || const DeepCollectionEquality().equals(other.dollarCostAverageStatus, dollarCostAverageStatus)) &&
            (identical(other.autoPilotPortfolioConnection, autoPilotPortfolioConnection) || const DeepCollectionEquality().equals(other.autoPilotPortfolioConnection, autoPilotPortfolioConnection)) &&
            (identical(other.brokerBuyingPower, brokerBuyingPower) || const DeepCollectionEquality().equals(other.brokerBuyingPower, brokerBuyingPower)) &&
            (identical(other.missingOnboardingSteps, missingOnboardingSteps) || const DeepCollectionEquality().equals(other.missingOnboardingSteps, missingOnboardingSteps)) &&
            (identical(other.createdAt, createdAt) || const DeepCollectionEquality().equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) || const DeepCollectionEquality().equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(masterUserKey) ^
        const DeepCollectionEquality().hash(masterUser) ^
        const DeepCollectionEquality().hash(masterPortfolioKey) ^
        const DeepCollectionEquality().hash(masterPortfolio) ^
        const DeepCollectionEquality().hash(slaveUserKey) ^
        const DeepCollectionEquality().hash(slaveUser) ^
        const DeepCollectionEquality().hash(slavePortfolioKey) ^
        const DeepCollectionEquality().hash(slavePortfolio) ^
        const DeepCollectionEquality().hash(allocationAmount) ^
        const DeepCollectionEquality().hash(allocationPercent) ^
        const DeepCollectionEquality().hash(allocationType) ^
        const DeepCollectionEquality().hash(status) ^
        const DeepCollectionEquality().hash(setupStatus) ^
        const DeepCollectionEquality().hash(executionType) ^
        const DeepCollectionEquality().hash(tradeEquityFractionals) ^
        const DeepCollectionEquality().hash(tradeOptionsFractionals) ^
        const DeepCollectionEquality().hash(tradeCryptoFractionals) ^
        const DeepCollectionEquality().hash(dollarCostAverageCeilingAmount) ^
        const DeepCollectionEquality().hash(dollarCostAverageAmount) ^
        const DeepCollectionEquality().hash(subscriptionKey) ^
        const DeepCollectionEquality().hash(expectedReturnConnection) ^
        const DeepCollectionEquality().hash(dollarCostAverageInterval) ^
        const DeepCollectionEquality().hash(dollarCostAverageStatus) ^
        const DeepCollectionEquality().hash(autoPilotPortfolioConnection) ^
        const DeepCollectionEquality().hash(brokerBuyingPower) ^
        const DeepCollectionEquality().hash(missingOnboardingSteps) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(updatedAt);
  }

  @override
  String toString() => 'AutoPilotSettings(${toJson()})';
}
