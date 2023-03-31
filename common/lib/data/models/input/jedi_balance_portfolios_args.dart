import 'package:collection/collection.dart';

class JediBalancePortfoliosArgs {
  final List<int>? autoPilotSettingsKeys;
  final bool? syncToMaster;
  final bool? closeOutStandingPositions;
  final bool? allocateRemainingBuyingPower;
  const JediBalancePortfoliosArgs(
      {required this.autoPilotSettingsKeys,
      this.syncToMaster,
      this.closeOutStandingPositions,
      this.allocateRemainingBuyingPower});
  JediBalancePortfoliosArgs copyWith(
      {List<int>? autoPilotSettingsKeys,
      bool? syncToMaster,
      bool? closeOutStandingPositions,
      bool? allocateRemainingBuyingPower}) {
    return JediBalancePortfoliosArgs(
      autoPilotSettingsKeys:
          autoPilotSettingsKeys ?? this.autoPilotSettingsKeys,
      syncToMaster: syncToMaster ?? this.syncToMaster,
      closeOutStandingPositions:
          closeOutStandingPositions ?? this.closeOutStandingPositions,
      allocateRemainingBuyingPower:
          allocateRemainingBuyingPower ?? this.allocateRemainingBuyingPower,
    );
  }

  factory JediBalancePortfoliosArgs.fromJson(Map<String, dynamic> json) {
    return JediBalancePortfoliosArgs(
      autoPilotSettingsKeys:
          json['autoPilotSettingsKeys']?.map<int>((o) => (o as int)).toList(),
      syncToMaster: json['syncToMaster'],
      closeOutStandingPositions: json['closeOutStandingPositions'],
      allocateRemainingBuyingPower: json['allocateRemainingBuyingPower'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKeys'] = autoPilotSettingsKeys;
    data['syncToMaster'] = syncToMaster;
    data['closeOutStandingPositions'] = closeOutStandingPositions;
    data['allocateRemainingBuyingPower'] = allocateRemainingBuyingPower;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediBalancePortfoliosArgs &&
            (identical(other.autoPilotSettingsKeys, autoPilotSettingsKeys) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKeys, autoPilotSettingsKeys)) &&
            (identical(other.syncToMaster, syncToMaster) ||
                const DeepCollectionEquality()
                    .equals(other.syncToMaster, syncToMaster)) &&
            (identical(other.closeOutStandingPositions,
                    closeOutStandingPositions) ||
                const DeepCollectionEquality().equals(
                    other.closeOutStandingPositions,
                    closeOutStandingPositions)) &&
            (identical(other.allocateRemainingBuyingPower,
                    allocateRemainingBuyingPower) ||
                const DeepCollectionEquality().equals(
                    other.allocateRemainingBuyingPower,
                    allocateRemainingBuyingPower)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKeys) ^
        const DeepCollectionEquality().hash(syncToMaster) ^
        const DeepCollectionEquality().hash(closeOutStandingPositions) ^
        const DeepCollectionEquality().hash(allocateRemainingBuyingPower);
  }

  @override
  String toString() => 'JediBalancePortfoliosArgs(${toJson()})';
}
