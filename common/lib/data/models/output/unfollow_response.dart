import 'package:collection/collection.dart';

class UnfollowResponse {
  final String? success;
  const UnfollowResponse({this.success});
  UnfollowResponse copyWith({String? success}) {
    return UnfollowResponse(
      success: success ?? this.success,
    );
  }

  factory UnfollowResponse.fromJson(Map<String, dynamic> json) {
    return UnfollowResponse(
      success: json['success'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UnfollowResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(success);
  }

  @override
  String toString() => 'UnfollowResponse(${toJson()})';
}
