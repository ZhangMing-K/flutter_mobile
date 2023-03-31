import 'package:iris_common/data/models/enums/social_source.dart';
import 'package:collection/collection.dart';

class SocialUserPollContentInput {
  final SOCIAL_SOURCE? source;
  final int? userKey;
  const SocialUserPollContentInput(
      {required this.source, required this.userKey});
  SocialUserPollContentInput copyWith({SOCIAL_SOURCE? source, int? userKey}) {
    return SocialUserPollContentInput(
      source: source ?? this.source,
      userKey: userKey ?? this.userKey,
    );
  }

  factory SocialUserPollContentInput.fromJson(Map<String, dynamic> json) {
    return SocialUserPollContentInput(
      source: json['source'] != null
          ? SOCIAL_SOURCE.values.byName(json['source'])
          : null,
      userKey: json['userKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['source'] = source?.name;
    data['userKey'] = userKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SocialUserPollContentInput &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality().equals(other.userKey, userKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(source) ^
        const DeepCollectionEquality().hash(userKey);
  }

  @override
  String toString() => 'SocialUserPollContentInput(${toJson()})';
}
