import 'package:iris_common/data/models/output/user_snooze.dart';
import 'package:collection/collection.dart';

class UserSnoozeResponse {
  final UserSnooze? userSnooze;
  const UserSnoozeResponse({this.userSnooze});
  UserSnoozeResponse copyWith({UserSnooze? userSnooze}) {
    return UserSnoozeResponse(
      userSnooze: userSnooze ?? this.userSnooze,
    );
  }

  factory UserSnoozeResponse.fromJson(Map<String, dynamic> json) {
    return UserSnoozeResponse(
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
        (other is UserSnoozeResponse &&
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
  String toString() => 'UserSnoozeResponse(${toJson()})';
}
