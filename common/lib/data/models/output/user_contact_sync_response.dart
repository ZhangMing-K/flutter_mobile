import 'package:collection/collection.dart';

class UserContactSyncResponse {
  final bool? success;
  const UserContactSyncResponse({this.success});
  UserContactSyncResponse copyWith({bool? success}) {
    return UserContactSyncResponse(
      success: success ?? this.success,
    );
  }

  factory UserContactSyncResponse.fromJson(Map<String, dynamic> json) {
    return UserContactSyncResponse(
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
        (other is UserContactSyncResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(success);
  }

  @override
  String toString() => 'UserContactSyncResponse(${toJson()})';
}
