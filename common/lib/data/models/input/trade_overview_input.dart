import 'package:iris_common/data/models/input/overview_between_input.dart';
import 'package:iris_common/data/models/enums/sentiment_type.dart';
import 'package:iris_common/data/models/enums/overview_order_by.dart';
import 'package:iris_common/data/models/enums/overview_field_order_by.dart';
import 'package:collection/collection.dart';

class TradeOverviewInput {
  final OverviewBetweenInput? between;
  final int? limit;
  final int? offset;
  final SENTIMENT_TYPE? sentimentType;
  final OVERVIEW_ORDER_BY? orderBy;
  final OVERVIEW_FIELD_ORDER_BY? orderByField;
  const TradeOverviewInput(
      {required this.between,
      this.limit,
      this.offset,
      required this.sentimentType,
      this.orderBy,
      this.orderByField});
  TradeOverviewInput copyWith(
      {OverviewBetweenInput? between,
      int? limit,
      int? offset,
      SENTIMENT_TYPE? sentimentType,
      OVERVIEW_ORDER_BY? orderBy,
      OVERVIEW_FIELD_ORDER_BY? orderByField}) {
    return TradeOverviewInput(
      between: between ?? this.between,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      sentimentType: sentimentType ?? this.sentimentType,
      orderBy: orderBy ?? this.orderBy,
      orderByField: orderByField ?? this.orderByField,
    );
  }

  factory TradeOverviewInput.fromJson(Map<String, dynamic> json) {
    return TradeOverviewInput(
      between: json['between'] != null
          ? OverviewBetweenInput.fromJson(json['between'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
      sentimentType: json['sentimentType'] != null
          ? SENTIMENT_TYPE.values.byName(json['sentimentType'])
          : null,
      orderBy: json['orderBy'] != null
          ? OVERVIEW_ORDER_BY.values.byName(json['orderBy'])
          : null,
      orderByField: json['orderByField'] != null
          ? OVERVIEW_FIELD_ORDER_BY.values.byName(json['orderByField'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['between'] = between?.toJson();
    data['limit'] = limit;
    data['offset'] = offset;
    data['sentimentType'] = sentimentType?.name;
    data['orderBy'] = orderBy?.name;
    data['orderByField'] = orderByField?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TradeOverviewInput &&
            (identical(other.between, between) ||
                const DeepCollectionEquality()
                    .equals(other.between, between)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.sentimentType, sentimentType) ||
                const DeepCollectionEquality()
                    .equals(other.sentimentType, sentimentType)) &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality()
                    .equals(other.orderBy, orderBy)) &&
            (identical(other.orderByField, orderByField) ||
                const DeepCollectionEquality()
                    .equals(other.orderByField, orderByField)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(between) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(sentimentType) ^
        const DeepCollectionEquality().hash(orderBy) ^
        const DeepCollectionEquality().hash(orderByField);
  }

  @override
  String toString() => 'TradeOverviewInput(${toJson()})';
}
