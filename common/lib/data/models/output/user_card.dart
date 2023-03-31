import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class UserCard {
  final User? user;
  final String? subtitle;
  const UserCard({this.user, this.subtitle});
  UserCard copyWith({User? user, String? subtitle}) {
    return UserCard(
      user: user ?? this.user,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  factory UserCard.fromJson(Map<String, dynamic> json) {
    return UserCard(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      subtitle: json['subtitle'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['subtitle'] = subtitle;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserCard &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.subtitle, subtitle) ||
                const DeepCollectionEquality()
                    .equals(other.subtitle, subtitle)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(subtitle);
  }

  @override
  String toString() => 'UserCard(${toJson()})';
}
