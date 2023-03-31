import 'package:iris_common/data/models/input/between_input.dart';
import 'package:iris_common/data/models/enums/feed_order_by_type.dart';
import 'package:collection/collection.dart';

class FeedOrderBy {
  final BetweenInput? timeSpan;
  final FEED_ORDER_BY_TYPE? orderByType;
  const FeedOrderBy({this.timeSpan, this.orderByType});
  FeedOrderBy copyWith(
      {BetweenInput? timeSpan, FEED_ORDER_BY_TYPE? orderByType}) {
    return FeedOrderBy(
      timeSpan: timeSpan ?? this.timeSpan,
      orderByType: orderByType ?? this.orderByType,
    );
  }

  factory FeedOrderBy.fromJson(Map<String, dynamic> json) {
    return FeedOrderBy(
      timeSpan: json['timeSpan'] != null
          ? BetweenInput.fromJson(json['timeSpan'])
          : null,
      orderByType: json['orderByType'] != null
          ? FEED_ORDER_BY_TYPE.values.byName(json['orderByType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['timeSpan'] = timeSpan?.toJson();
    data['orderByType'] = orderByType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FeedOrderBy &&
            (identical(other.timeSpan, timeSpan) ||
                const DeepCollectionEquality()
                    .equals(other.timeSpan, timeSpan)) &&
            (identical(other.orderByType, orderByType) ||
                const DeepCollectionEquality()
                    .equals(other.orderByType, orderByType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(timeSpan) ^
        const DeepCollectionEquality().hash(orderByType);
  }

  @override
  String toString() => 'FeedOrderBy(${toJson()})';
}
