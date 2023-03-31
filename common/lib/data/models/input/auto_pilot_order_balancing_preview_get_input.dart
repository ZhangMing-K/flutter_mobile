import 'package:collection/collection.dart';

class AutoPilotOrderBalancingPreviewGetInput {
  final int? autoPilotSettingsKey;
  const AutoPilotOrderBalancingPreviewGetInput({this.autoPilotSettingsKey});
  AutoPilotOrderBalancingPreviewGetInput copyWith({int? autoPilotSettingsKey}) {
    return AutoPilotOrderBalancingPreviewGetInput(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
    );
  }

  factory AutoPilotOrderBalancingPreviewGetInput.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotOrderBalancingPreviewGetInput(
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
        (other is AutoPilotOrderBalancingPreviewGetInput &&
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
  String toString() => 'AutoPilotOrderBalancingPreviewGetInput(${toJson()})';
}
