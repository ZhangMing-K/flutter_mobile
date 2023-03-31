import 'package:iris_common/data/models/enums/social_source.dart';
import 'package:iris_common/data/models/enums/content_sync_frequency.dart';
import 'package:collection/collection.dart';

class SocialUserIntegrationUpdateInput {
  final SOCIAL_SOURCE? source;
  final int? userKey;
  final CONTENT_SYNC_FREQUENCY? contentSyncFrequency;
  const SocialUserIntegrationUpdateInput(
      {required this.source, required this.userKey, this.contentSyncFrequency});
  SocialUserIntegrationUpdateInput copyWith(
      {SOCIAL_SOURCE? source,
      int? userKey,
      CONTENT_SYNC_FREQUENCY? contentSyncFrequency}) {
    return SocialUserIntegrationUpdateInput(
      source: source ?? this.source,
      userKey: userKey ?? this.userKey,
      contentSyncFrequency: contentSyncFrequency ?? this.contentSyncFrequency,
    );
  }

  factory SocialUserIntegrationUpdateInput.fromJson(Map<String, dynamic> json) {
    return SocialUserIntegrationUpdateInput(
      source: json['source'] != null
          ? SOCIAL_SOURCE.values.byName(json['source'])
          : null,
      userKey: json['userKey'],
      contentSyncFrequency: json['contentSyncFrequency'] != null
          ? CONTENT_SYNC_FREQUENCY.values.byName(json['contentSyncFrequency'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['source'] = source?.name;
    data['userKey'] = userKey;
    data['contentSyncFrequency'] = contentSyncFrequency?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SocialUserIntegrationUpdateInput &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.contentSyncFrequency, contentSyncFrequency) ||
                const DeepCollectionEquality()
                    .equals(other.contentSyncFrequency, contentSyncFrequency)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(source) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(contentSyncFrequency);
  }

  @override
  String toString() => 'SocialUserIntegrationUpdateInput(${toJson()})';
}
