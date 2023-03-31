import 'package:collection/collection.dart';

class JediAutoPilotInitializeResponse {
  final bool? success;
  final String? reason;
  const JediAutoPilotInitializeResponse({required this.success, this.reason});
  JediAutoPilotInitializeResponse copyWith({bool? success, String? reason}) {
    return JediAutoPilotInitializeResponse(
      success: success ?? this.success,
      reason: reason ?? this.reason,
    );
  }

  factory JediAutoPilotInitializeResponse.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotInitializeResponse(
      success: json['success'],
      reason: json['reason'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['reason'] = reason;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotInitializeResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality()
                    .equals(other.success, success)) &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(success) ^
        const DeepCollectionEquality().hash(reason);
  }

  @override
  String toString() => 'JediAutoPilotInitializeResponse(${toJson()})';
}
