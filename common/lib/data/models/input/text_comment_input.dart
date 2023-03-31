import 'package:iris_common/data/models/enums/query_order.dart';
import 'package:collection/collection.dart';

class TextCommentInput {
  final int? limit;
  final int? offset;
  final QUERY_ORDER? order;
  const TextCommentInput({this.limit, this.offset, this.order});
  TextCommentInput copyWith({int? limit, int? offset, QUERY_ORDER? order}) {
    return TextCommentInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      order: order ?? this.order,
    );
  }

  factory TextCommentInput.fromJson(Map<String, dynamic> json) {
    return TextCommentInput(
      limit: json['limit'],
      offset: json['offset'],
      order: json['order'] != null
          ? QUERY_ORDER.values.byName(json['order'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['order'] = order?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextCommentInput &&
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
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(order);
  }

  @override
  String toString() => 'TextCommentInput(${toJson()})';
}
