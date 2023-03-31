import 'package:collection/collection.dart';

class JediAutoPilotInitiateOrdersThatFailedToAutoPilotArgs {
  final int? masterPortfolioKey;
  final int? slavePortfoliokey;
  final int? autoPilotSettingsKey;
  const JediAutoPilotInitiateOrdersThatFailedToAutoPilotArgs(
      {this.masterPortfolioKey,
      this.slavePortfoliokey,
      this.autoPilotSettingsKey});
  JediAutoPilotInitiateOrdersThatFailedToAutoPilotArgs copyWith(
      {int? masterPortfolioKey,
      int? slavePortfoliokey,
      int? autoPilotSettingsKey}) {
    return JediAutoPilotInitiateOrdersThatFailedToAutoPilotArgs(
      masterPortfolioKey: masterPortfolioKey ?? this.masterPortfolioKey,
      slavePortfoliokey: slavePortfoliokey ?? this.slavePortfoliokey,
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
    );
  }

  factory JediAutoPilotInitiateOrdersThatFailedToAutoPilotArgs.fromJson(
      Map<String, dynamic> json) {
    return JediAutoPilotInitiateOrdersThatFailedToAutoPilotArgs(
      masterPortfolioKey: json['masterPortfolioKey'],
      slavePortfoliokey: json['slavePortfoliokey'],
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
    );
  }

  Map toJson() {
    Map _data = {};
    _data['masterPortfolioKey'] = masterPortfolioKey;
    _data['slavePortfoliokey'] = slavePortfoliokey;
    _data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    return _data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotInitiateOrdersThatFailedToAutoPilotArgs &&
            (identical(other.masterPortfolioKey, masterPortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.masterPortfolioKey, masterPortfolioKey)) &&
            (identical(other.slavePortfoliokey, slavePortfoliokey) ||
                const DeepCollectionEquality()
                    .equals(other.slavePortfoliokey, slavePortfoliokey)) &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotSettingsKey, autoPilotSettingsKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(masterPortfolioKey) ^
        const DeepCollectionEquality().hash(slavePortfoliokey) ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey);
  }

  @override
  String toString() =>
      'JediAutoPilotInitiateOrdersThatFailedToAutoPilotArgs(${toJson()})';
}
