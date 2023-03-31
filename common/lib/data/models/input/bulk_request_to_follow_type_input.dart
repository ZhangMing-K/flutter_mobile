import 'package:iris_common/data/models/enums/follow_request_entity_type.dart';
import 'package:collection/collection.dart';

class BulkRequestToFollowTypeInput {
  final List<int>? lookupKeys;
  final FOLLOW_REQUEST_ENTITY_TYPE? entityType;
  const BulkRequestToFollowTypeInput(
      {required this.lookupKeys, required this.entityType});
  BulkRequestToFollowTypeInput copyWith(
      {List<int>? lookupKeys, FOLLOW_REQUEST_ENTITY_TYPE? entityType}) {
    return BulkRequestToFollowTypeInput(
      lookupKeys: lookupKeys ?? this.lookupKeys,
      entityType: entityType ?? this.entityType,
    );
  }

  factory BulkRequestToFollowTypeInput.fromJson(Map<String, dynamic> json) {
    return BulkRequestToFollowTypeInput(
      lookupKeys: json['lookupKeys']?.map<int>((o) => (o as int)).toList(),
      entityType: json['entityType'] != null
          ? FOLLOW_REQUEST_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['lookupKeys'] = lookupKeys;
    data['entityType'] = entityType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BulkRequestToFollowTypeInput &&
            (identical(other.lookupKeys, lookupKeys) ||
                const DeepCollectionEquality()
                    .equals(other.lookupKeys, lookupKeys)) &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(lookupKeys) ^
        const DeepCollectionEquality().hash(entityType);
  }

  @override
  String toString() => 'BulkRequestToFollowTypeInput(${toJson()})';
}
