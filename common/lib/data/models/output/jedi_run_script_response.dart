import 'package:collection/collection.dart';

class JediRunScriptResponse {
  final bool? success;
  final String? reason;
  const JediRunScriptResponse({required this.success, this.reason});
  JediRunScriptResponse copyWith({bool? success, String? reason}) {
    return JediRunScriptResponse(
      success: success ?? this.success,
      reason: reason ?? this.reason,
    );
  }

  factory JediRunScriptResponse.fromJson(Map<String, dynamic> json) {
    return JediRunScriptResponse(
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
        (other is JediRunScriptResponse &&
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
  String toString() => 'JediRunScriptResponse(${toJson()})';
}
