import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class MutualFollowedBy {
  final List<User>? users;
  final int? total;
  const MutualFollowedBy({this.users, this.total});
  MutualFollowedBy copyWith({List<User>? users, int? total}) {
    return MutualFollowedBy(
      users: users ?? this.users,
      total: total ?? this.total,
    );
  }

  factory MutualFollowedBy.fromJson(Map<String, dynamic> json) {
    return MutualFollowedBy(
      users: json['users']?.map<User>((o) => User.fromJson(o)).toList(),
      total: json['total'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['users'] = users?.map((item) => item.toJson()).toList();
    data['total'] = total;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MutualFollowedBy &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(users) ^
        const DeepCollectionEquality().hash(total);
  }

  @override
  String toString() => 'MutualFollowedBy(${toJson()})';
}
