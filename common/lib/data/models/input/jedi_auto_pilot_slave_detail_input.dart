import 'package:collection/collection.dart';

class JediAutoPilotSlaveDetailInput {
  final int? autoPilotSettingsKey;
  const JediAutoPilotSlaveDetailInput({required this.autoPilotSettingsKey});
  JediAutoPilotSlaveDetailInput copyWith({int? autoPilotSettingsKey}) {
    return JediAutoPilotSlaveDetailInput(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
    );
  }

  factory JediAutoPilotSlaveDetailInput.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotSlaveDetailInput(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotSlaveDetailInput &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotSettingsKey, autoPilotSettingsKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey);
  }

  @override
  String toString() => 'JediAutoPilotSlaveDetailInput(${toJson()})';
}
