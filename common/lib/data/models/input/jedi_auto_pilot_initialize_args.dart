import 'package:iris_common/data/models/enums/auto_pilot_settings_status.dart';
import 'package:collection/collection.dart';

class JediAutoPilotInitializeArgs {
  final int? masterPortfolioKey;
  final int? slavePortfolioKey;
  final double? allocationAmount;
  final AUTO_PILOT_SETTINGS_STATUS? status;
  final bool? syncToMaster;
  final bool? cashIsPosition;
  final bool? trimmingEnabled;
  const JediAutoPilotInitializeArgs(
      {required this.masterPortfolioKey,
      required this.slavePortfolioKey,
      required this.allocationAmount,
      this.status,
      this.syncToMaster,
      this.cashIsPosition,
      this.trimmingEnabled});
  JediAutoPilotInitializeArgs copyWith(
      {int? masterPortfolioKey,
      int? slavePortfolioKey,
      double? allocationAmount,
      AUTO_PILOT_SETTINGS_STATUS? status,
      bool? syncToMaster,
      bool? cashIsPosition,
      bool? trimmingEnabled}) {
    return JediAutoPilotInitializeArgs(
      masterPortfolioKey: masterPortfolioKey ?? this.masterPortfolioKey,
      slavePortfolioKey: slavePortfolioKey ?? this.slavePortfolioKey,
      allocationAmount: allocationAmount ?? this.allocationAmount,
      status: status ?? this.status,
      syncToMaster: syncToMaster ?? this.syncToMaster,
      cashIsPosition: cashIsPosition ?? this.cashIsPosition,
      trimmingEnabled: trimmingEnabled ?? this.trimmingEnabled,
    );
  }

  factory JediAutoPilotInitializeArgs.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotInitializeArgs(
      masterPortfolioKey: json['masterPortfolioKey'],
      slavePortfolioKey: json['slavePortfolioKey'],
      allocationAmount: json['allocationAmount']?.toDouble(),
      status: json['status'] != null
          ? AUTO_PILOT_SETTINGS_STATUS.values.byName(json['status'])
          : null,
      syncToMaster: json['syncToMaster'],
      cashIsPosition: json['cashIsPosition'],
      trimmingEnabled: json['trimmingEnabled'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['masterPortfolioKey'] = masterPortfolioKey;
    data['slavePortfolioKey'] = slavePortfolioKey;
    data['allocationAmount'] = allocationAmount;
    data['status'] = status?.name;
    data['syncToMaster'] = syncToMaster;
    data['cashIsPosition'] = cashIsPosition;
    data['trimmingEnabled'] = trimmingEnabled;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotInitializeArgs &&
            (identical(other.masterPortfolioKey, masterPortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.masterPortfolioKey, masterPortfolioKey)) &&
            (identical(other.slavePortfolioKey, slavePortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.slavePortfolioKey, slavePortfolioKey)) &&
            (identical(other.allocationAmount, allocationAmount) ||
                const DeepCollectionEquality()
                    .equals(other.allocationAmount, allocationAmount)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.syncToMaster, syncToMaster) ||
                const DeepCollectionEquality()
                    .equals(other.syncToMaster, syncToMaster)) &&
            (identical(other.cashIsPosition, cashIsPosition) ||
                const DeepCollectionEquality()
                    .equals(other.cashIsPosition, cashIsPosition)) &&
            (identical(other.trimmingEnabled, trimmingEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.trimmingEnabled, trimmingEnabled)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(masterPortfolioKey) ^
        const DeepCollectionEquality().hash(slavePortfolioKey) ^
        const DeepCollectionEquality().hash(allocationAmount) ^
        const DeepCollectionEquality().hash(status) ^
        const DeepCollectionEquality().hash(syncToMaster) ^
        const DeepCollectionEquality().hash(cashIsPosition) ^
        const DeepCollectionEquality().hash(trimmingEnabled);
  }

  @override
  String toString() => 'JediAutoPilotInitializeArgs(${toJson()})';
}
