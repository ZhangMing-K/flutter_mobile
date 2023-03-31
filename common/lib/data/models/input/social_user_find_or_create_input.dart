import 'package:iris_common/data/models/enums/social_source.dart';
import 'package:collection/collection.dart';

class SocialUserFindOrCreateInput {
  final SOCIAL_SOURCE? source;
  final String? username;
  final bool? overridePrivateConstraint;
  final bool? pollRecentPosts;
  const SocialUserFindOrCreateInput(
      {required this.source,
      required this.username,
      this.overridePrivateConstraint,
      this.pollRecentPosts});
  SocialUserFindOrCreateInput copyWith(
      {SOCIAL_SOURCE? source,
      String? username,
      bool? overridePrivateConstraint,
      bool? pollRecentPosts}) {
    return SocialUserFindOrCreateInput(
      source: source ?? this.source,
      username: username ?? this.username,
      overridePrivateConstraint:
          overridePrivateConstraint ?? this.overridePrivateConstraint,
      pollRecentPosts: pollRecentPosts ?? this.pollRecentPosts,
    );
  }

  factory SocialUserFindOrCreateInput.fromJson(Map<String, dynamic> json) {
    return SocialUserFindOrCreateInput(
      source: json['source'] != null
          ? SOCIAL_SOURCE.values.byName(json['source'])
          : null,
      username: json['username'],
      overridePrivateConstraint: json['overridePrivateConstraint'],
      pollRecentPosts: json['pollRecentPosts'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['source'] = source?.name;
    data['username'] = username;
    data['overridePrivateConstraint'] = overridePrivateConstraint;
    data['pollRecentPosts'] = pollRecentPosts;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SocialUserFindOrCreateInput &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.overridePrivateConstraint,
                    overridePrivateConstraint) ||
                const DeepCollectionEquality().equals(
                    other.overridePrivateConstraint,
                    overridePrivateConstraint)) &&
            (identical(other.pollRecentPosts, pollRecentPosts) ||
                const DeepCollectionEquality()
                    .equals(other.pollRecentPosts, pollRecentPosts)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(source) ^
        const DeepCollectionEquality().hash(username) ^
        const DeepCollectionEquality().hash(overridePrivateConstraint) ^
        const DeepCollectionEquality().hash(pollRecentPosts);
  }

  @override
  String toString() => 'SocialUserFindOrCreateInput(${toJson()})';
}
