import 'package:iris_common/data/models/output/user_user.dart';
import 'package:collection/collection.dart';

class GlobalUserUserUpdateResponse {
  final List<UserUser>? userUsers;
  const GlobalUserUserUpdateResponse({this.userUsers});
  GlobalUserUserUpdateResponse copyWith({List<UserUser>? userUsers}) {
    return GlobalUserUserUpdateResponse(
      userUsers: userUsers ?? this.userUsers,
    );
  }

  factory GlobalUserUserUpdateResponse.fromJson(Map<String, dynamic> json) {
    return GlobalUserUserUpdateResponse(
      userUsers: json['userUsers']
          ?.map<UserUser>((o) => UserUser.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userUsers'] = userUsers?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GlobalUserUserUpdateResponse &&
            (identical(other.userUsers, userUsers) ||
                const DeepCollectionEquality()
                    .equals(other.userUsers, userUsers)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userUsers);
  }

  @override
  String toString() => 'GlobalUserUserUpdateResponse(${toJson()})';
}
