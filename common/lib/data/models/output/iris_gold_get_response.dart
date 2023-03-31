import 'package:iris_common/data/models/output/purchase_item.dart';
import 'package:iris_common/data/models/output/purchase_item_price.dart';
import 'package:collection/collection.dart';

class IrisGoldGetResponse {
  final PurchaseItem? purchaseItem;
  final List<PurchaseItemPrice>? purchaseItemPrices;
  const IrisGoldGetResponse({this.purchaseItem, this.purchaseItemPrices});
  IrisGoldGetResponse copyWith(
      {PurchaseItem? purchaseItem,
      List<PurchaseItemPrice>? purchaseItemPrices}) {
    return IrisGoldGetResponse(
      purchaseItem: purchaseItem ?? this.purchaseItem,
      purchaseItemPrices: purchaseItemPrices ?? this.purchaseItemPrices,
    );
  }

  factory IrisGoldGetResponse.fromJson(Map<String, dynamic> json) {
    return IrisGoldGetResponse(
      purchaseItem: json['purchaseItem'] != null
          ? PurchaseItem.fromJson(json['purchaseItem'])
          : null,
      purchaseItemPrices: json['purchaseItemPrices']
          ?.map<PurchaseItemPrice>((o) => PurchaseItemPrice.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['purchaseItem'] = purchaseItem?.toJson();
    data['purchaseItemPrices'] =
        purchaseItemPrices?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IrisGoldGetResponse &&
            (identical(other.purchaseItem, purchaseItem) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItem, purchaseItem)) &&
            (identical(other.purchaseItemPrices, purchaseItemPrices) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItemPrices, purchaseItemPrices)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(purchaseItem) ^
        const DeepCollectionEquality().hash(purchaseItemPrices);
  }

  @override
  String toString() => 'IrisGoldGetResponse(${toJson()})';
}
