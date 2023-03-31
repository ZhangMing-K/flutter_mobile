import 'package:iris_common/data/models/output/user_relation.dart';
import 'package:collection/collection.dart';

class UserRelationsUpdateResponse {
  final List<UserRelation>? userRelations;
  const UserRelationsUpdateResponse({this.userRelations});
  UserRelationsUpdateResponse copyWith({List<UserRelation>? userRelations}) {
    return UserRelationsUpdateResponse(
      userRelations: userRelations ?? this.userRelations,
    );
  }

  factory UserRelationsUpdateResponse.fromJson(Map<String, dynamic> json) {
    return UserRelationsUpdateResponse(
      userRelations: json['userRelations']
          ?.map<UserRelation>((o) => UserRelation.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userRelations'] =
        userRelations?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserRelationsUpdateResponse &&
            (identical(other.userRelations, userRelations) ||
                const DeepCollectionEquality()
                    .equals(other.userRelations, userRelations)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userRelations);
  }

  @override
  String toString() => 'UserRelationsUpdateResponse(${toJson()})';
}
