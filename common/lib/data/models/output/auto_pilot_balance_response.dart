import 'package:iris_common/data/models/output/auto_pilot_settings.dart';
import 'package:collection/collection.dart';

class AutoPilotBalanceResponse {
  final bool? success;
  final AutoPilotSettings? autoPilotSettings;
  final String? message;
  const AutoPilotBalanceResponse(
      {required this.success, this.autoPilotSettings, this.message});
  AutoPilotBalanceResponse copyWith(
      {bool? success, AutoPilotSettings? autoPilotSettings, String? message}) {
    return AutoPilotBalanceResponse(
      success: success ?? this.success,
      autoPilotSettings: autoPilotSettings ?? this.autoPilotSettings,
      message: message ?? this.message,
    );
  }

  factory AutoPilotBalanceResponse.fromJson(Map<String, dynamic> json) {
    return AutoPilotBalanceResponse(
      success: json['success'],
      autoPilotSettings: json['autoPilotSettings'] != null
          ? AutoPilotSettings.fromJson(json['autoPilotSettings'])
          : null,
      message: json['message'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['autoPilotSettings'] = autoPilotSettings?.toJson();
    data['message'] = message;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotBalanceResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality()
                    .equals(other.success, success)) &&
            (identical(other.autoPilotSettings, autoPilotSettings) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotSettings, autoPilotSettings)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(success) ^
        const DeepCollectionEquality().hash(autoPilotSettings) ^
        const DeepCollectionEquality().hash(message);
  }

  @override
  String toString() => 'AutoPilotBalanceResponse(${toJson()})';
}
