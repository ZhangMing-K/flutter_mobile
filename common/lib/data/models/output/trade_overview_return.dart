import 'package:iris_common/data/models/output/asset_overview_item.dart';
import 'package:collection/collection.dart';

class TradeOverviewReturn {
  final List<AssetOverviewItem>? items;
  const TradeOverviewReturn({this.items});
  TradeOverviewReturn copyWith({List<AssetOverviewItem>? items}) {
    return TradeOverviewReturn(
      items: items ?? this.items,
    );
  }

  factory TradeOverviewReturn.fromJson(Map<String, dynamic> json) {
    return TradeOverviewReturn(
      items: json['items']
          ?.map<AssetOverviewItem>((o) => AssetOverviewItem.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['items'] = items?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TradeOverviewReturn &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(items);
  }

  @override
  String toString() => 'TradeOverviewReturn(${toJson()})';
}
