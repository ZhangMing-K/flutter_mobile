import 'package:iris_common/data/models/enums/follow_request_entity_type.dart';
import 'package:collection/collection.dart';

class UnfollowInput {
  final FOLLOW_REQUEST_ENTITY_TYPE? entityType;
  final int? entityKey;
  const UnfollowInput({required this.entityType, required this.entityKey});
  UnfollowInput copyWith(
      {FOLLOW_REQUEST_ENTITY_TYPE? entityType, int? entityKey}) {
    return UnfollowInput(
      entityType: entityType ?? this.entityType,
      entityKey: entityKey ?? this.entityKey,
    );
  }

  factory UnfollowInput.fromJson(Map<String, dynamic> json) {
    return UnfollowInput(
      entityType: json['entityType'] != null
          ? FOLLOW_REQUEST_ENTITY_TYPE.values.byName(json['entityType'])
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
        (other is UnfollowInput &&
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
  String toString() => 'UnfollowInput(${toJson()})';
}
