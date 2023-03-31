import 'package:iris_common/data/models/output/follow_suggestion.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class DiscoverPageItem {
  final FollowSuggestion? followSuggestion;
  final List<Order>? orders;
  final List<TextModel>? texts;
  const DiscoverPageItem({this.followSuggestion, this.orders, this.texts});
  DiscoverPageItem copyWith(
      {FollowSuggestion? followSuggestion,
      List<Order>? orders,
      List<TextModel>? texts}) {
    return DiscoverPageItem(
      followSuggestion: followSuggestion ?? this.followSuggestion,
      orders: orders ?? this.orders,
      texts: texts ?? this.texts,
    );
  }

  factory DiscoverPageItem.fromJson(Map<String, dynamic> json) {
    return DiscoverPageItem(
      followSuggestion: json['followSuggestion'] != null
          ? FollowSuggestion.fromJson(json['followSuggestion'])
          : null,
      orders: json['orders']?.map<Order>((o) => Order.fromJson(o)).toList(),
      texts:
          json['texts']?.map<TextModel>((o) => TextModel.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['followSuggestion'] = followSuggestion?.toJson();
    data['orders'] = orders?.map((item) => item.toJson()).toList();
    data['texts'] = texts?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DiscoverPageItem &&
            (identical(other.followSuggestion, followSuggestion) ||
                const DeepCollectionEquality()
                    .equals(other.followSuggestion, followSuggestion)) &&
            (identical(other.orders, orders) ||
                const DeepCollectionEquality().equals(other.orders, orders)) &&
            (identical(other.texts, texts) ||
                const DeepCollectionEquality().equals(other.texts, texts)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(followSuggestion) ^
        const DeepCollectionEquality().hash(orders) ^
        const DeepCollectionEquality().hash(texts);
  }

  @override
  String toString() => 'DiscoverPageItem(${toJson()})';
}
