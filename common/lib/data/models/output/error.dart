import 'package:collection/collection.dart';

class Error {
  final String? message;
  const Error({this.message});
  Error copyWith({String? message}) {
    return Error(
      message: message ?? this.message,
    );
  }

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      message: json['message'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);
  }

  @override
  String toString() => 'Error(${toJson()})';
}
