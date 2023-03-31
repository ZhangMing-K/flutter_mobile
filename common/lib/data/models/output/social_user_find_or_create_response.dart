import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class SocialUserFindOrCreateResponse {
  final User? user;
  const SocialUserFindOrCreateResponse({this.user});
  SocialUserFindOrCreateResponse copyWith({User? user}) {
    return SocialUserFindOrCreateResponse(
      user: user ?? this.user,
    );
  }

  factory SocialUserFindOrCreateResponse.fromJson(Map<String, dynamic> json) {
    return SocialUserFindOrCreateResponse(
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
        (other is SocialUserFindOrCreateResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);
  }

  @override
  String toString() => 'SocialUserFindOrCreateResponse(${toJson()})';
}
