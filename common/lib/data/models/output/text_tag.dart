import 'package:iris_common/data/models/enums/tag_entity_type.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class TextTag {
  final int? textTagKey;
  final int? textKey;
  final TAG_ENTITY_TYPE? entityType;
  final int? entityKey;
  final String? contentUrl;
  final String? remoteId;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final double? entityValue;
  final double? entityDayChangePercent;
  final TextModel? text;
  const TextTag(
      {this.textTagKey,
      this.textKey,
      this.entityType,
      this.entityKey,
      this.contentUrl,
      this.remoteId,
      this.createdAt,
      this.deletedAt,
      this.entityValue,
      this.entityDayChangePercent,
      this.text});
  TextTag copyWith(
      {int? textTagKey,
      int? textKey,
      TAG_ENTITY_TYPE? entityType,
      int? entityKey,
      String? contentUrl,
      String? remoteId,
      DateTime? createdAt,
      DateTime? deletedAt,
      double? entityValue,
      double? entityDayChangePercent,
      TextModel? text}) {
    return TextTag(
      textTagKey: textTagKey ?? this.textTagKey,
      textKey: textKey ?? this.textKey,
      entityType: entityType ?? this.entityType,
      entityKey: entityKey ?? this.entityKey,
      contentUrl: contentUrl ?? this.contentUrl,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      entityValue: entityValue ?? this.entityValue,
      entityDayChangePercent:
          entityDayChangePercent ?? this.entityDayChangePercent,
      text: text ?? this.text,
    );
  }

  factory TextTag.fromJson(Map<String, dynamic> json) {
    return TextTag(
      textTagKey: json['textTagKey'],
      textKey: json['textKey'],
      entityType: json['entityType'] != null
          ? TAG_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      entityKey: json['entityKey'],
      contentUrl: json['contentUrl'],
      remoteId: json['remoteId'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      entityValue: json['entityValue']?.toDouble(),
      entityDayChangePercent: json['entityDayChangePercent']?.toDouble(),
      text: json['text'] != null ? TextModel.fromJson(json['text']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['textTagKey'] = textTagKey;
    data['textKey'] = textKey;
    data['entityType'] = entityType?.name;
    data['entityKey'] = entityKey;
    data['contentUrl'] = contentUrl;
    data['remoteId'] = remoteId;
    data['createdAt'] = createdAt?.toString();
    data['deletedAt'] = deletedAt?.toString();
    data['entityValue'] = entityValue;
    data['entityDayChangePercent'] = entityDayChangePercent;
    data['text'] = text?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextTag &&
            (identical(other.textTagKey, textTagKey) ||
                const DeepCollectionEquality()
                    .equals(other.textTagKey, textTagKey)) &&
            (identical(other.textKey, textKey) ||
                const DeepCollectionEquality()
                    .equals(other.textKey, textKey)) &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.entityKey, entityKey) ||
                const DeepCollectionEquality()
                    .equals(other.entityKey, entityKey)) &&
            (identical(other.contentUrl, contentUrl) ||
                const DeepCollectionEquality()
                    .equals(other.contentUrl, contentUrl)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.deletedAt, deletedAt) ||
                const DeepCollectionEquality()
                    .equals(other.deletedAt, deletedAt)) &&
            (identical(other.entityValue, entityValue) ||
                const DeepCollectionEquality()
                    .equals(other.entityValue, entityValue)) &&
            (identical(other.entityDayChangePercent, entityDayChangePercent) ||
                const DeepCollectionEquality().equals(
                    other.entityDayChangePercent, entityDayChangePercent)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(textTagKey) ^
        const DeepCollectionEquality().hash(textKey) ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(entityKey) ^
        const DeepCollectionEquality().hash(contentUrl) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(deletedAt) ^
        const DeepCollectionEquality().hash(entityValue) ^
        const DeepCollectionEquality().hash(entityDayChangePercent) ^
        const DeepCollectionEquality().hash(text);
  }

  @override
  String toString() => 'TextTag(${toJson()})';
}
