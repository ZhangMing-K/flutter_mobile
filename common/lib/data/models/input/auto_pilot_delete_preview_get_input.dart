import 'package:collection/collection.dart';

class AutoPilotDeletePreviewGetInput {
  final int? autoPilotSettingsKey;
  const AutoPilotDeletePreviewGetInput({required this.autoPilotSettingsKey});
  AutoPilotDeletePreviewGetInput copyWith({int? autoPilotSettingsKey}) {
    return AutoPilotDeletePreviewGetInput(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
    );
  }

  factory AutoPilotDeletePreviewGetInput.fromJson(Map<String, dynamic> json) {
    return AutoPilotDeletePreviewGetInput(
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
        (other is AutoPilotDeletePreviewGetInput &&
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
  String toString() => 'AutoPilotDeletePreviewGetInput(${toJson()})';
}
