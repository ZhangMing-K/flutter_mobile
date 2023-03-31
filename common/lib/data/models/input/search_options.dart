import 'package:iris_common/data/models/enums/follow_request_entity_type.dart';
import 'package:iris_common/data/models/enums/search_following.dart';
import 'package:collection/collection.dart';

class SearchOptions {
  final FOLLOW_REQUEST_ENTITY_TYPE? entityType;
  final int? entityKey;
  final SEARCH_FOLLOWING? searchFollowing;
  const SearchOptions(
      {required this.entityType,
      required this.entityKey,
      required this.searchFollowing});
  SearchOptions copyWith(
      {FOLLOW_REQUEST_ENTITY_TYPE? entityType,
      int? entityKey,
      SEARCH_FOLLOWING? searchFollowing}) {
    return SearchOptions(
      entityType: entityType ?? this.entityType,
      entityKey: entityKey ?? this.entityKey,
      searchFollowing: searchFollowing ?? this.searchFollowing,
    );
  }

  factory SearchOptions.fromJson(Map<String, dynamic> json) {
    return SearchOptions(
      entityType: json['entityType'] != null
          ? FOLLOW_REQUEST_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      entityKey: json['entityKey'],
      searchFollowing: json['searchFollowing'] != null
          ? SEARCH_FOLLOWING.values.byName(json['searchFollowing'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['entityType'] = entityType?.name;
    data['entityKey'] = entityKey;
    data['searchFollowing'] = searchFollowing?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SearchOptions &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.entityKey, entityKey) ||
                const DeepCollectionEquality()
                    .equals(other.entityKey, entityKey)) &&
            (identical(other.searchFollowing, searchFollowing) ||
                const DeepCollectionEquality()
                    .equals(other.searchFollowing, searchFollowing)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(entityKey) ^
        const DeepCollectionEquality().hash(searchFollowing);
  }

  @override
  String toString() => 'SearchOptions(${toJson()})';
}
