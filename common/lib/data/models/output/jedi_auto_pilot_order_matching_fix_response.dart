import 'package:collection/collection.dart';

class JediAutoPilotOrderMatchingFixResponse {
  final bool? success;
  final String? message;
  const JediAutoPilotOrderMatchingFixResponse({this.success, this.message});
  JediAutoPilotOrderMatchingFixResponse copyWith(
      {bool? success, String? message}) {
    return JediAutoPilotOrderMatchingFixResponse(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  factory JediAutoPilotOrderMatchingFixResponse.fromJson(
      Map<String, dynamic> json) {
    return JediAutoPilotOrderMatchingFixResponse(
      success: json['success'],
      message: json['message'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotOrderMatchingFixResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality()
                    .equals(other.success, success)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(success) ^
        const DeepCollectionEquality().hash(message);
  }

  @override
  String toString() => 'JediAutoPilotOrderMatchingFixResponse(${toJson()})';
}
