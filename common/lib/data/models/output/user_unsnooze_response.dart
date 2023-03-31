import 'package:iris_common/data/models/output/user_snooze.dart';
import 'package:collection/collection.dart';

class UserUnsnoozeResponse {
  final UserSnooze? userSnooze;
  const UserUnsnoozeResponse({this.userSnooze});
  UserUnsnoozeResponse copyWith({UserSnooze? userSnooze}) {
    return UserUnsnoozeResponse(
      userSnooze: userSnooze ?? this.userSnooze,
    );
  }

  factory UserUnsnoozeResponse.fromJson(Map<String, dynamic> json) {
    return UserUnsnoozeResponse(
      userSnooze: json['userSnooze'] != null
          ? UserSnooze.fromJson(json['userSnooze'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userSnooze'] = userSnooze?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserUnsnoozeResponse &&
            (identical(other.userSnooze, userSnooze) ||
                const DeepCollectionEquality()
                    .equals(other.userSnooze, userSnooze)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userSnooze);
  }

  @override
  String toString() => 'UserUnsnoozeResponse(${toJson()})';
}
