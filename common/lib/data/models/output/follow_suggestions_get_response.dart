import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class FollowSuggestionsGetResponse {
  final List<User>? users;
  final String? nextCursor;
  const FollowSuggestionsGetResponse({this.users, this.nextCursor});
  FollowSuggestionsGetResponse copyWith(
      {List<User>? users, String? nextCursor}) {
    return FollowSuggestionsGetResponse(
      users: users ?? this.users,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory FollowSuggestionsGetResponse.fromJson(Map<String, dynamic> json) {
    return FollowSuggestionsGetResponse(
      users: json['users']?.map<User>((o) => User.fromJson(o)).toList(),
      nextCursor: json['nextCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['users'] = users?.map((item) => item.toJson()).toList();
    data['nextCursor'] = nextCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FollowSuggestionsGetResponse &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)) &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(users) ^
        const DeepCollectionEquality().hash(nextCursor);
  }

  @override
  String toString() => 'FollowSuggestionsGetResponse(${toJson()})';
}
