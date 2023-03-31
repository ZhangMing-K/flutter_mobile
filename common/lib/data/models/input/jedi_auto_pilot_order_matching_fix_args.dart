import 'package:collection/collection.dart';

class JediAutoPilotOrderMatchingFixArgs {
  final int? masterPortfolioKey;
  final int? slavePortfoliokey;
  final int? autoPilotSettingsKey;
  const JediAutoPilotOrderMatchingFixArgs(
      {this.masterPortfolioKey,
      this.slavePortfoliokey,
      this.autoPilotSettingsKey});
  JediAutoPilotOrderMatchingFixArgs copyWith(
      {int? masterPortfolioKey,
      int? slavePortfoliokey,
      int? autoPilotSettingsKey}) {
    return JediAutoPilotOrderMatchingFixArgs(
      masterPortfolioKey: masterPortfolioKey ?? this.masterPortfolioKey,
      slavePortfoliokey: slavePortfoliokey ?? this.slavePortfoliokey,
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
    );
  }

  factory JediAutoPilotOrderMatchingFixArgs.fromJson(
      Map<String, dynamic> json) {
    return JediAutoPilotOrderMatchingFixArgs(
      masterPortfolioKey: json['masterPortfolioKey'],
      slavePortfoliokey: json['slavePortfoliokey'],
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['masterPortfolioKey'] = masterPortfolioKey;
    data['slavePortfoliokey'] = slavePortfoliokey;
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotOrderMatchingFixArgs &&
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
  String toString() => 'JediAutoPilotOrderMatchingFixArgs(${toJson()})';
}
