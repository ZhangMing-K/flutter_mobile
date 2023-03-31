import 'package:iris_common/data/models/enums/social_source.dart';
import 'package:iris_common/data/models/enums/content_sync_frequency.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class Integration {
  final int? integrationKey;
  final int? userKey;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? token;
  final String? refreshToken;
  final String? tokenSecret;
  final String? remoteId;
  final String? pictureUrl;
  final SOCIAL_SOURCE? source;
  final CONTENT_SYNC_FREQUENCY? contentSyncFrequency;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  const Integration(
      {this.integrationKey,
      this.userKey,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.token,
      this.refreshToken,
      this.tokenSecret,
      this.remoteId,
      this.pictureUrl,
      this.source,
      this.contentSyncFrequency,
      this.createdAt,
      this.updatedAt,
      this.user});
  Integration copyWith(
      {int? integrationKey,
      int? userKey,
      String? firstName,
      String? lastName,
      String? username,
      String? email,
      String? token,
      String? refreshToken,
      String? tokenSecret,
      String? remoteId,
      String? pictureUrl,
      SOCIAL_SOURCE? source,
      CONTENT_SYNC_FREQUENCY? contentSyncFrequency,
      DateTime? createdAt,
      DateTime? updatedAt,
      User? user}) {
    return Integration(
      integrationKey: integrationKey ?? this.integrationKey,
      userKey: userKey ?? this.userKey,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      tokenSecret: tokenSecret ?? this.tokenSecret,
      remoteId: remoteId ?? this.remoteId,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      source: source ?? this.source,
      contentSyncFrequency: contentSyncFrequency ?? this.contentSyncFrequency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }

  factory Integration.fromJson(Map<String, dynamic> json) {
    return Integration(
      integrationKey: json['integrationKey'],
      userKey: json['userKey'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      email: json['email'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      tokenSecret: json['tokenSecret'],
      remoteId: json['remoteId'],
      pictureUrl: json['pictureUrl'],
      source: json['source'] != null
          ? SOCIAL_SOURCE.values.byName(json['source'])
          : null,
      contentSyncFrequency: json['contentSyncFrequency'] != null
          ? CONTENT_SYNC_FREQUENCY.values.byName(json['contentSyncFrequency'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['integrationKey'] = integrationKey;
    data['userKey'] = userKey;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    data['tokenSecret'] = tokenSecret;
    data['remoteId'] = remoteId;
    data['pictureUrl'] = pictureUrl;
    data['source'] = source?.name;
    data['contentSyncFrequency'] = contentSyncFrequency?.name;
    data['createdAt'] = createdAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    data['user'] = user?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Integration &&
            (identical(other.integrationKey, integrationKey) ||
                const DeepCollectionEquality()
                    .equals(other.integrationKey, integrationKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality()
                    .equals(other.refreshToken, refreshToken)) &&
            (identical(other.tokenSecret, tokenSecret) ||
                const DeepCollectionEquality()
                    .equals(other.tokenSecret, tokenSecret)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.pictureUrl, pictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.pictureUrl, pictureUrl)) &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.contentSyncFrequency, contentSyncFrequency) ||
                const DeepCollectionEquality().equals(
                    other.contentSyncFrequency, contentSyncFrequency)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(integrationKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(firstName) ^
        const DeepCollectionEquality().hash(lastName) ^
        const DeepCollectionEquality().hash(username) ^
        const DeepCollectionEquality().hash(email) ^
        const DeepCollectionEquality().hash(token) ^
        const DeepCollectionEquality().hash(refreshToken) ^
        const DeepCollectionEquality().hash(tokenSecret) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(pictureUrl) ^
        const DeepCollectionEquality().hash(source) ^
        const DeepCollectionEquality().hash(contentSyncFrequency) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(updatedAt) ^
        const DeepCollectionEquality().hash(user);
  }

  @override
  String toString() => 'Integration(${toJson()})';
}
