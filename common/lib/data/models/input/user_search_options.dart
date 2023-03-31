import 'package:iris_common/data/models/enums/user_search_following.dart';
import 'package:collection/collection.dart';

class UserSearchOptions {
  final int? userKey;
  final USER_SEARCH_FOLLOWING? searchFollowing;
  const UserSearchOptions(
      {required this.userKey, required this.searchFollowing});
  UserSearchOptions copyWith(
      {int? userKey, USER_SEARCH_FOLLOWING? searchFollowing}) {
    return UserSearchOptions(
      userKey: userKey ?? this.userKey,
      searchFollowing: searchFollowing ?? this.searchFollowing,
    );
  }

  factory UserSearchOptions.fromJson(Map<String, dynamic> json) {
    return UserSearchOptions(
      userKey: json['userKey'],
      searchFollowing: json['searchFollowing'] != null
          ? USER_SEARCH_FOLLOWING.values.byName(json['searchFollowing'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['searchFollowing'] = searchFollowing?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSearchOptions &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.searchFollowing, searchFollowing) ||
                const DeepCollectionEquality()
                    .equals(other.searchFollowing, searchFollowing)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(searchFollowing);
  }

  @override
  String toString() => 'UserSearchOptions(${toJson()})';
}
