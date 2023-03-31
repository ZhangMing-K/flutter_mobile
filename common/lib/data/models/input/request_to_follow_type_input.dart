import 'package:iris_common/data/models/enums/follow_request_entity_type.dart';
import 'package:collection/collection.dart';

class RequestToFollowTypeInput {
  final int? lookupKey;
  final FOLLOW_REQUEST_ENTITY_TYPE? entityType;
  final int? fromTextKey;
  const RequestToFollowTypeInput(
      {required this.lookupKey, required this.entityType, this.fromTextKey});
  RequestToFollowTypeInput copyWith(
      {int? lookupKey,
      FOLLOW_REQUEST_ENTITY_TYPE? entityType,
      int? fromTextKey}) {
    return RequestToFollowTypeInput(
      lookupKey: lookupKey ?? this.lookupKey,
      entityType: entityType ?? this.entityType,
      fromTextKey: fromTextKey ?? this.fromTextKey,
    );
  }

  factory RequestToFollowTypeInput.fromJson(Map<String, dynamic> json) {
    return RequestToFollowTypeInput(
      lookupKey: json['lookupKey'],
      entityType: json['entityType'] != null
          ? FOLLOW_REQUEST_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      fromTextKey: json['fromTextKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['lookupKey'] = lookupKey;
    data['entityType'] = entityType?.name;
    data['fromTextKey'] = fromTextKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RequestToFollowTypeInput &&
            (identical(other.lookupKey, lookupKey) ||
                const DeepCollectionEquality()
                    .equals(other.lookupKey, lookupKey)) &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.fromTextKey, fromTextKey) ||
                const DeepCollectionEquality()
                    .equals(other.fromTextKey, fromTextKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(lookupKey) ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(fromTextKey);
  }

  @override
  String toString() => 'RequestToFollowTypeInput(${toJson()})';
}
