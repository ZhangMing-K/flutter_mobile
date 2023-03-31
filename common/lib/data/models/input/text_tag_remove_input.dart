import 'package:iris_common/data/models/enums/tag_entity_type.dart';
import 'package:collection/collection.dart';

class TextTagRemoveInput {
  final TAG_ENTITY_TYPE? entityType;
  final int? entityKey;
  const TextTagRemoveInput({required this.entityType, required this.entityKey});
  TextTagRemoveInput copyWith({TAG_ENTITY_TYPE? entityType, int? entityKey}) {
    return TextTagRemoveInput(
      entityType: entityType ?? this.entityType,
      entityKey: entityKey ?? this.entityKey,
    );
  }

  factory TextTagRemoveInput.fromJson(Map<String, dynamic> json) {
    return TextTagRemoveInput(
      entityType: json['entityType'] != null
          ? TAG_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      entityKey: json['entityKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['entityType'] = entityType?.name;
    data['entityKey'] = entityKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextTagRemoveInput &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.entityKey, entityKey) ||
                const DeepCollectionEquality()
                    .equals(other.entityKey, entityKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(entityKey);
  }

  @override
  String toString() => 'TextTagRemoveInput(${toJson()})';
}
