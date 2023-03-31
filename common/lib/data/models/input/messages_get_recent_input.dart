import 'package:iris_common/data/models/enums/message_order_by.dart';
import 'package:iris_common/data/models/enums/relation_location.dart';
import 'package:collection/collection.dart';

class MessagesGetRecentInput {
  final int? limit;
  final int? offset;
  final MESSAGE_ORDER_BY? orderBy;
  final RELATION_LOCATION? relationLocation;
  final String? cursor;
  const MessagesGetRecentInput(
      {required this.limit,
      this.offset,
      this.orderBy,
      this.relationLocation,
      this.cursor});
  MessagesGetRecentInput copyWith(
      {int? limit,
      int? offset,
      MESSAGE_ORDER_BY? orderBy,
      RELATION_LOCATION? relationLocation,
      String? cursor}) {
    return MessagesGetRecentInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      orderBy: orderBy ?? this.orderBy,
      relationLocation: relationLocation ?? this.relationLocation,
      cursor: cursor ?? this.cursor,
    );
  }

  factory MessagesGetRecentInput.fromJson(Map<String, dynamic> json) {
    return MessagesGetRecentInput(
      limit: json['limit'],
      offset: json['offset'],
      orderBy: json['orderBy'] != null
          ? MESSAGE_ORDER_BY.values.byName(json['orderBy'])
          : null,
      relationLocation: json['relationLocation'] != null
          ? RELATION_LOCATION.values.byName(json['relationLocation'])
          : null,
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['orderBy'] = orderBy?.name;
    data['relationLocation'] = relationLocation?.name;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MessagesGetRecentInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality()
                    .equals(other.orderBy, orderBy)) &&
            (identical(other.relationLocation, relationLocation) ||
                const DeepCollectionEquality()
                    .equals(other.relationLocation, relationLocation)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(orderBy) ^
        const DeepCollectionEquality().hash(relationLocation) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'MessagesGetRecentInput(${toJson()})';
}
