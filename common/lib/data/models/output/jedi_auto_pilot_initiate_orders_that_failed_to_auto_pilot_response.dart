import 'package:collection/collection.dart';

class JediAutoPilotInitiateOrdersThatFailedToAutoPilotResponse {
  final bool? success;
  final String? message;
  const JediAutoPilotInitiateOrdersThatFailedToAutoPilotResponse(
      {this.success, this.message});
  JediAutoPilotInitiateOrdersThatFailedToAutoPilotResponse copyWith(
      {bool? success, String? message}) {
    return JediAutoPilotInitiateOrdersThatFailedToAutoPilotResponse(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  factory JediAutoPilotInitiateOrdersThatFailedToAutoPilotResponse.fromJson(
      Map<String, dynamic> json) {
    return JediAutoPilotInitiateOrdersThatFailedToAutoPilotResponse(
      success: json['success'],
      message: json['message'],
    );
  }

  Map toJson() {
    Map _data = {};
    _data['success'] = success;
    _data['message'] = message;
    return _data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotInitiateOrdersThatFailedToAutoPilotResponse &&
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
  String toString() =>
      'JediAutoPilotInitiateOrdersThatFailedToAutoPilotResponse(${toJson()})';
}
