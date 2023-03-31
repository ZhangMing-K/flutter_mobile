import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class JediUserEditResponse {
  final User? user;
  const JediUserEditResponse({this.user});
  JediUserEditResponse copyWith({User? user}) {
    return JediUserEditResponse(
      user: user ?? this.user,
    );
  }

  factory JediUserEditResponse.fromJson(Map<String, dynamic> json) {
    return JediUserEditResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediUserEditResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);
  }

  @override
  String toString() => 'JediUserEditResponse(${toJson()})';
}
