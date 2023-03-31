import 'package:iris_common/data/models/enums/social_source.dart';
import 'package:collection/collection.dart';

class SocialLinkInput {
  final String? token;
  final SOCIAL_SOURCE? socialSource;
  final String? verifierToken;
  final int? userKey;
  final int? integrationKey;
  const SocialLinkInput(
      {this.token,
      required this.socialSource,
      this.verifierToken,
      this.userKey,
      this.integrationKey});
  SocialLinkInput copyWith(
      {String? token,
      SOCIAL_SOURCE? socialSource,
      String? verifierToken,
      int? userKey,
      int? integrationKey}) {
    return SocialLinkInput(
      token: token ?? this.token,
      socialSource: socialSource ?? this.socialSource,
      verifierToken: verifierToken ?? this.verifierToken,
      userKey: userKey ?? this.userKey,
      integrationKey: integrationKey ?? this.integrationKey,
    );
  }

  factory SocialLinkInput.fromJson(Map<String, dynamic> json) {
    return SocialLinkInput(
      token: json['token'],
      socialSource: json['socialSource'] != null
          ? SOCIAL_SOURCE.values.byName(json['socialSource'])
          : null,
      verifierToken: json['verifierToken'],
      userKey: json['userKey'],
      integrationKey: json['integrationKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['socialSource'] = socialSource?.name;
    data['verifierToken'] = verifierToken;
    data['userKey'] = userKey;
    data['integrationKey'] = integrationKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SocialLinkInput &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.socialSource, socialSource) ||
                const DeepCollectionEquality()
                    .equals(other.socialSource, socialSource)) &&
            (identical(other.verifierToken, verifierToken) ||
                const DeepCollectionEquality()
                    .equals(other.verifierToken, verifierToken)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.integrationKey, integrationKey) ||
                const DeepCollectionEquality()
                    .equals(other.integrationKey, integrationKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(token) ^
        const DeepCollectionEquality().hash(socialSource) ^
        const DeepCollectionEquality().hash(verifierToken) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(integrationKey);
  }

  @override
  String toString() => 'SocialLinkInput(${toJson()})';
}
