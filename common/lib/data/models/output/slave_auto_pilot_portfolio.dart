import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:iris_common/data/models/output/auto_pilot_portfolio.dart';
import 'package:iris_common/data/models/enums/broker_name.dart';
import 'package:iris_common/data/models/output/auto_pilot_position.dart';
import 'package:collection/collection.dart';

class SlaveAutoPilotPortfolio {
  final int? slavePortfolioKey;
  final int? slaveUserKey;
  final int? autoPilotSettingsKey;
  final AutoPilotSettings? autoPilotSettings;
  final double? allocationAmount;
  final int? masterPortfolioKey;
  final AutoPilotPortfolio? masterPortfolio;
  final BROKER_NAME? brokerName;
  final List<AutoPilotPosition>? currentPositions;
  final double? totalValue;
  final double? totalProfitLoss;
  final double? totalReturn;
  final double? autoPilotCash;
  const SlaveAutoPilotPortfolio(
      {required this.slavePortfolioKey,
      required this.slaveUserKey,
      required this.autoPilotSettingsKey,
      required this.autoPilotSettings,
      required this.allocationAmount,
      required this.masterPortfolioKey,
      this.masterPortfolio,
      this.brokerName,
      required this.currentPositions,
      required this.totalValue,
      required this.totalProfitLoss,
      required this.totalReturn,
      required this.autoPilotCash});
  SlaveAutoPilotPortfolio copyWith(
      {int? slavePortfolioKey,
      int? slaveUserKey,
      int? autoPilotSettingsKey,
      AutoPilotSettings? autoPilotSettings,
      double? allocationAmount,
      int? masterPortfolioKey,
      AutoPilotPortfolio? masterPortfolio,
      BROKER_NAME? brokerName,
      List<AutoPilotPosition>? currentPositions,
      double? totalValue,
      double? totalProfitLoss,
      double? totalReturn,
      double? autoPilotCash}) {
    return SlaveAutoPilotPortfolio(
      slavePortfolioKey: slavePortfolioKey ?? this.slavePortfolioKey,
      slaveUserKey: slaveUserKey ?? this.slaveUserKey,
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      autoPilotSettings: autoPilotSettings ?? this.autoPilotSettings,
      allocationAmount: allocationAmount ?? this.allocationAmount,
      masterPortfolioKey: masterPortfolioKey ?? this.masterPortfolioKey,
      masterPortfolio: masterPortfolio ?? this.masterPortfolio,
      brokerName: brokerName ?? this.brokerName,
      currentPositions: currentPositions ?? this.currentPositions,
      totalValue: totalValue ?? this.totalValue,
      totalProfitLoss: totalProfitLoss ?? this.totalProfitLoss,
      totalReturn: totalReturn ?? this.totalReturn,
      autoPilotCash: autoPilotCash ?? this.autoPilotCash,
    );
  }

  factory SlaveAutoPilotPortfolio.fromJson(Map<String, dynamic> json) {
    return SlaveAutoPilotPortfolio(
      slavePortfolioKey: json['slavePortfolioKey'],
      slaveUserKey: json['slaveUserKey'],
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      autoPilotSettings: json['autoPilotSettings'] != null
          ? AutoPilotSettings.fromJson(json['autoPilotSettings'])
          : null,
      allocationAmount: json['allocationAmount']?.toDouble(),
      masterPortfolioKey: json['masterPortfolioKey'],
      masterPortfolio: json['masterPortfolio'] != null
          ? AutoPilotPortfolio.fromJson(json['masterPortfolio'])
          : null,
      brokerName: json['brokerName'] != null
          ? BROKER_NAME.values.byName(json['brokerName'])
          : null,
      currentPositions: json['currentPositions']
          ?.map<AutoPilotPosition>((o) => AutoPilotPosition.fromJson(o))
          .toList(),
      totalValue: json['totalValue']?.toDouble(),
      totalProfitLoss: json['totalProfitLoss']?.toDouble(),
      totalReturn: json['totalReturn']?.toDouble(),
      autoPilotCash: json['autoPilotCash']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['slavePortfolioKey'] = slavePortfolioKey;
    data['slaveUserKey'] = slaveUserKey;
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['autoPilotSettings'] = autoPilotSettings?.toJson();
    data['allocationAmount'] = allocationAmount;
    data['masterPortfolioKey'] = masterPortfolioKey;
    data['masterPortfolio'] = masterPortfolio?.toJson();
    data['brokerName'] = brokerName?.name;
    data['currentPositions'] =
        currentPositions?.map((item) => item.toJson()).toList();
    data['totalValue'] = totalValue;
    data['totalProfitLoss'] = totalProfitLoss;
    data['totalReturn'] = totalReturn;
    data['autoPilotCash'] = autoPilotCash;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SlaveAutoPilotPortfolio &&
            (identical(other.slavePortfolioKey, slavePortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.slavePortfolioKey, slavePortfolioKey)) &&
            (identical(other.slaveUserKey, slaveUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.slaveUserKey, slaveUserKey)) &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.autoPilotSettings, autoPilotSettings) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotSettings, autoPilotSettings)) &&
            (identical(other.allocationAmount, allocationAmount) ||
                const DeepCollectionEquality()
                    .equals(other.allocationAmount, allocationAmount)) &&
            (identical(other.masterPortfolioKey, masterPortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.masterPortfolioKey, masterPortfolioKey)) &&
            (identical(other.masterPortfolio, masterPortfolio) ||
                const DeepCollectionEquality()
                    .equals(other.masterPortfolio, masterPortfolio)) &&
            (identical(other.brokerName, brokerName) ||
                const DeepCollectionEquality()
                    .equals(other.brokerName, brokerName)) &&
            (identical(other.currentPositions, currentPositions) ||
                const DeepCollectionEquality()
                    .equals(other.currentPositions, currentPositions)) &&
            (identical(other.totalValue, totalValue) ||
                const DeepCollectionEquality()
                    .equals(other.totalValue, totalValue)) &&
            (identical(other.totalProfitLoss, totalProfitLoss) ||
                const DeepCollectionEquality()
                    .equals(other.totalProfitLoss, totalProfitLoss)) &&
            (identical(other.totalReturn, totalReturn) ||
                const DeepCollectionEquality()
                    .equals(other.totalReturn, totalReturn)) &&
            (identical(other.autoPilotCash, autoPilotCash) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotCash, autoPilotCash)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(slavePortfolioKey) ^
        const DeepCollectionEquality().hash(slaveUserKey) ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(autoPilotSettings) ^
        const DeepCollectionEquality().hash(allocationAmount) ^
        const DeepCollectionEquality().hash(masterPortfolioKey) ^
        const DeepCollectionEquality().hash(masterPortfolio) ^
        const DeepCollectionEquality().hash(brokerName) ^
        const DeepCollectionEquality().hash(currentPositions) ^
        const DeepCollectionEquality().hash(totalValue) ^
        const DeepCollectionEquality().hash(totalProfitLoss) ^
        const DeepCollectionEquality().hash(totalReturn) ^
        const DeepCollectionEquality().hash(autoPilotCash);
  }

  @override
  String toString() => 'SlaveAutoPilotPortfolio(${toJson()})';
}
