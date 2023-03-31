import 'package:iris_common/data/models/enums/query_order.dart';
import 'package:collection/collection.dart';

class CommentsGetInput {
  final int? parentKey;
  final int? limit;
  final int? offset;
  final QUERY_ORDER? order;
  const CommentsGetInput(
      {required this.parentKey, this.limit, this.offset, this.order});
  CommentsGetInput copyWith(
      {int? parentKey, int? limit, int? offset, QUERY_ORDER? order}) {
    return CommentsGetInput(
      parentKey: parentKey ?? this.parentKey,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      order: order ?? this.order,
    );
  }

  factory CommentsGetInput.fromJson(Map<String, dynamic> json) {
    return CommentsGetInput(
      parentKey: json['parentKey'],
      limit: json['limit'],
      offset: json['offset'],
      order: json['order'] != null
          ? QUERY_ORDER.values.byName(json['order'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['parentKey'] = parentKey;
    data['limit'] = limit;
    data['offset'] = offset;
    data['order'] = order?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CommentsGetInput &&
            (identical(other.parentKey, parentKey) ||
                const DeepCollectionEquality()
                    .equals(other.parentKey, parentKey)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(parentKey) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(order);
  }

  @override
  String toString() => 'CommentsGetInput(${toJson()})';
}
