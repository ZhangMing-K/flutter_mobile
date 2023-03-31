import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:collection/collection.dart';

class AutoPilotInitializeResponse {
  final bool? success;
  final AutoPilotSettings? autoPilotSettings;
  final String? reason;
  const AutoPilotInitializeResponse(
      {required this.success, this.autoPilotSettings, this.reason});
  AutoPilotInitializeResponse copyWith(
      {bool? success, AutoPilotSettings? autoPilotSettings, String? reason}) {
    return AutoPilotInitializeResponse(
      success: success ?? this.success,
      autoPilotSettings: autoPilotSettings ?? this.autoPilotSettings,
      reason: reason ?? this.reason,
    );
  }

  factory AutoPilotInitializeResponse.fromJson(Map<String, dynamic> json) {
    return AutoPilotInitializeResponse(
      success: json['success'],
      autoPilotSettings: json['autoPilotSettings'] != null
          ? AutoPilotSettings.fromJson(json['autoPilotSettings'])
          : null,
      reason: json['reason'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['autoPilotSettings'] = autoPilotSettings?.toJson();
    data['reason'] = reason;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotInitializeResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality()
                    .equals(other.success, success)) &&
            (identical(other.autoPilotSettings, autoPilotSettings) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotSettings, autoPilotSettings)) &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(success) ^
        const DeepCollectionEquality().hash(autoPilotSettings) ^
        const DeepCollectionEquality().hash(reason);
  }

  @override
  String toString() => 'AutoPilotInitializeResponse(${toJson()})';
}
