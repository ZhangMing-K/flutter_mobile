import 'package:iris_common/data/models/enums/auto_pilot_settings_status.dart';
import 'package:collection/collection.dart';

class AutoPilotInitializeArgs {
  final int? masterPortfolioKey;
  final int? slavePortfolioKey;
  final double? allocationAmount;
  final bool? cashIsPosition;
  final AUTO_PILOT_SETTINGS_STATUS? status;
  final bool? syncToMaster;
  const AutoPilotInitializeArgs(
      {required this.masterPortfolioKey,
      required this.slavePortfolioKey,
      required this.allocationAmount,
      this.cashIsPosition,
      this.status,
      this.syncToMaster});
  AutoPilotInitializeArgs copyWith(
      {int? masterPortfolioKey,
      int? slavePortfolioKey,
      double? allocationAmount,
      bool? cashIsPosition,
      AUTO_PILOT_SETTINGS_STATUS? status,
      bool? syncToMaster}) {
    return AutoPilotInitializeArgs(
      masterPortfolioKey: masterPortfolioKey ?? this.masterPortfolioKey,
      slavePortfolioKey: slavePortfolioKey ?? this.slavePortfolioKey,
      allocationAmount: allocationAmount ?? this.allocationAmount,
      cashIsPosition: cashIsPosition ?? this.cashIsPosition,
      status: status ?? this.status,
      syncToMaster: syncToMaster ?? this.syncToMaster,
    );
  }

  factory AutoPilotInitializeArgs.fromJson(Map<String, dynamic> json) {
    return AutoPilotInitializeArgs(
      masterPortfolioKey: json['masterPortfolioKey'],
      slavePortfolioKey: json['slavePortfolioKey'],
      allocationAmount: json['allocationAmount']?.toDouble(),
      cashIsPosition: json['cashIsPosition'],
      status: json['status'] != null
          ? AUTO_PILOT_SETTINGS_STATUS.values.byName(json['status'])
          : null,
      syncToMaster: json['syncToMaster'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['masterPortfolioKey'] = masterPortfolioKey;
    data['slavePortfolioKey'] = slavePortfolioKey;
    data['allocationAmount'] = allocationAmount;
    data['cashIsPosition'] = cashIsPosition;
    data['status'] = status?.name;
    data['syncToMaster'] = syncToMaster;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotInitializeArgs &&
            (identical(other.masterPortfolioKey, masterPortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.masterPortfolioKey, masterPortfolioKey)) &&
            (identical(other.slavePortfolioKey, slavePortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.slavePortfolioKey, slavePortfolioKey)) &&
            (identical(other.allocationAmount, allocationAmount) ||
                const DeepCollectionEquality()
                    .equals(other.allocationAmount, allocationAmount)) &&
            (identical(other.cashIsPosition, cashIsPosition) ||
                const DeepCollectionEquality()
                    .equals(other.cashIsPosition, cashIsPosition)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.syncToMaster, syncToMaster) ||
                const DeepCollectionEquality()
                    .equals(other.syncToMaster, syncToMaster)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(masterPortfolioKey) ^
        const DeepCollectionEquality().hash(slavePortfolioKey) ^
        const DeepCollectionEquality().hash(allocationAmount) ^
        const DeepCollectionEquality().hash(cashIsPosition) ^
        const DeepCollectionEquality().hash(status) ^
        const DeepCollectionEquality().hash(syncToMaster);
  }

  @override
  String toString() => 'AutoPilotInitializeArgs(${toJson()})';
}
