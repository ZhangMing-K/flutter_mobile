import 'package:iris_common/data/models/enums/follow_request_status.dart';
import 'package:iris_common/data/models/enums/follow_request_order_by.dart';
import 'package:collection/collection.dart';

class FollowRequestInput {
  final List<FOLLOW_REQUEST_STATUS>? requested;
  final List<FOLLOW_REQUEST_STATUS>? otherRequesting;
  final FOLLOW_REQUEST_ORDER_BY? orderBy;
  final int? limit;
  final int? offset;
  final String? cursor;
  const FollowRequestInput(
      {this.requested,
      this.otherRequesting,
      this.orderBy,
      this.limit,
      this.offset,
      this.cursor});
  FollowRequestInput copyWith(
      {List<FOLLOW_REQUEST_STATUS>? requested,
      List<FOLLOW_REQUEST_STATUS>? otherRequesting,
      FOLLOW_REQUEST_ORDER_BY? orderBy,
      int? limit,
      int? offset,
      String? cursor}) {
    return FollowRequestInput(
      requested: requested ?? this.requested,
      otherRequesting: otherRequesting ?? this.otherRequesting,
      orderBy: orderBy ?? this.orderBy,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      cursor: cursor ?? this.cursor,
    );
  }

  factory FollowRequestInput.fromJson(Map<String, dynamic> json) {
    return FollowRequestInput(
      requested: json['requested']
          ?.map<FOLLOW_REQUEST_STATUS>(
              (o) => FOLLOW_REQUEST_STATUS.values.byName(o))
          .toList(),
      otherRequesting: json['otherRequesting']
          ?.map<FOLLOW_REQUEST_STATUS>(
              (o) => FOLLOW_REQUEST_STATUS.values.byName(o))
          .toList(),
      orderBy: json['orderBy'] != null
          ? FOLLOW_REQUEST_ORDER_BY.values.byName(json['orderBy'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['requested'] = requested?.map((item) => item.name).toList();
    data['otherRequesting'] =
        otherRequesting?.map((item) => item.name).toList();
    data['orderBy'] = orderBy?.name;
    data['limit'] = limit;
    data['offset'] = offset;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FollowRequestInput &&
            (identical(other.requested, requested) ||
                const DeepCollectionEquality()
                    .equals(other.requested, requested)) &&
            (identical(other.otherRequesting, otherRequesting) ||
                const DeepCollectionEquality()
                    .equals(other.otherRequesting, otherRequesting)) &&
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
        const DeepCollectionEquality().hash(requested) ^
        const DeepCollectionEquality().hash(otherRequesting) ^
        const DeepCollectionEquality().hash(orderBy) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'FollowRequestInput(${toJson()})';
}
