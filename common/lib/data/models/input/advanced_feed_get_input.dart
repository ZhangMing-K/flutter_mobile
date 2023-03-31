import 'package:iris_common/data/models/enums/feed_category.dart';
import 'package:iris_common/data/models/enums/text_type.dart';
import 'package:iris_common/data/models/input/feed_order_by.dart';
import 'package:collection/collection.dart';

class AdvancedFeedGetInput {
  final FEED_CATEGORY? feedCategory;
  final bool? saved;
  final bool? featured;
  final List<TEXT_TYPE>? textTypes;
  final List<int>? collectionKeys;
  final List<int>? assetKeys;
  final List<int>? taggedUserKeys;
  final List<int>? creatorUserKeys;
  final FeedOrderBy? orderBy;
  final int? limit;
  final int? offset;
  final String? cursor;
  const AdvancedFeedGetInput(
      {this.feedCategory,
      this.saved,
      this.featured,
      required this.textTypes,
      this.collectionKeys,
      this.assetKeys,
      this.taggedUserKeys,
      this.creatorUserKeys,
      this.orderBy,
      required this.limit,
      this.offset,
      this.cursor});
  AdvancedFeedGetInput copyWith(
      {FEED_CATEGORY? feedCategory,
      bool? saved,
      bool? featured,
      List<TEXT_TYPE>? textTypes,
      List<int>? collectionKeys,
      List<int>? assetKeys,
      List<int>? taggedUserKeys,
      List<int>? creatorUserKeys,
      FeedOrderBy? orderBy,
      int? limit,
      int? offset,
      String? cursor}) {
    return AdvancedFeedGetInput(
      feedCategory: feedCategory ?? this.feedCategory,
      saved: saved ?? this.saved,
      featured: featured ?? this.featured,
      textTypes: textTypes ?? this.textTypes,
      collectionKeys: collectionKeys ?? this.collectionKeys,
      assetKeys: assetKeys ?? this.assetKeys,
      taggedUserKeys: taggedUserKeys ?? this.taggedUserKeys,
      creatorUserKeys: creatorUserKeys ?? this.creatorUserKeys,
      orderBy: orderBy ?? this.orderBy,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      cursor: cursor ?? this.cursor,
    );
  }

  factory AdvancedFeedGetInput.fromJson(Map<String, dynamic> json) {
    return AdvancedFeedGetInput(
      feedCategory: json['feedCategory'] != null
          ? FEED_CATEGORY.values.byName(json['feedCategory'])
          : null,
      saved: json['saved'],
      featured: json['featured'],
      textTypes: json['textTypes']
          ?.map<TEXT_TYPE>((o) => TEXT_TYPE.values.byName(o))
          .toList(),
      collectionKeys:
          json['collectionKeys']?.map<int>((o) => (o as int)).toList(),
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      taggedUserKeys:
          json['taggedUserKeys']?.map<int>((o) => (o as int)).toList(),
      creatorUserKeys:
          json['creatorUserKeys']?.map<int>((o) => (o as int)).toList(),
      orderBy: json['orderBy'] != null
          ? FeedOrderBy.fromJson(json['orderBy'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['feedCategory'] = feedCategory?.name;
    data['saved'] = saved;
    data['featured'] = featured;
    data['textTypes'] = textTypes?.map((item) => item.name).toList();
    data['collectionKeys'] = collectionKeys;
    data['assetKeys'] = assetKeys;
    data['taggedUserKeys'] = taggedUserKeys;
    data['creatorUserKeys'] = creatorUserKeys;
    data['orderBy'] = orderBy?.toJson();
    data['limit'] = limit;
    data['offset'] = offset;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdvancedFeedGetInput &&
            (identical(other.feedCategory, feedCategory) ||
                const DeepCollectionEquality()
                    .equals(other.feedCategory, feedCategory)) &&
            (identical(other.saved, saved) ||
                const DeepCollectionEquality().equals(other.saved, saved)) &&
            (identical(other.featured, featured) ||
                const DeepCollectionEquality()
                    .equals(other.featured, featured)) &&
            (identical(other.textTypes, textTypes) ||
                const DeepCollectionEquality()
                    .equals(other.textTypes, textTypes)) &&
            (identical(other.collectionKeys, collectionKeys) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKeys, collectionKeys)) &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.taggedUserKeys, taggedUserKeys) ||
                const DeepCollectionEquality()
                    .equals(other.taggedUserKeys, taggedUserKeys)) &&
            (identical(other.creatorUserKeys, creatorUserKeys) ||
                const DeepCollectionEquality()
                    .equals(other.creatorUserKeys, creatorUserKeys)) &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality()
                    .equals(other.orderBy, orderBy)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(feedCategory) ^
        const DeepCollectionEquality().hash(saved) ^
        const DeepCollectionEquality().hash(featured) ^
        const DeepCollectionEquality().hash(textTypes) ^
        const DeepCollectionEquality().hash(collectionKeys) ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(taggedUserKeys) ^
        const DeepCollectionEquality().hash(creatorUserKeys) ^
        const DeepCollectionEquality().hash(orderBy) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'AdvancedFeedGetInput(${toJson()})';
}
