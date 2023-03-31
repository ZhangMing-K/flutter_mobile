import 'package:iris_common/data/models/output/purchase_item.dart';
import 'package:collection/collection.dart';

class PurchaseItemsGetResponse {
  final List<PurchaseItem>? purchaseItems;
  const PurchaseItemsGetResponse({this.purchaseItems});
  PurchaseItemsGetResponse copyWith({List<PurchaseItem>? purchaseItems}) {
    return PurchaseItemsGetResponse(
      purchaseItems: purchaseItems ?? this.purchaseItems,
    );
  }

  factory PurchaseItemsGetResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseItemsGetResponse(
      purchaseItems: json['purchaseItems']
          ?.map<PurchaseItem>((o) => PurchaseItem.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['purchaseItems'] =
        purchaseItems?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PurchaseItemsGetResponse &&
            (identical(other.purchaseItems, purchaseItems) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItems, purchaseItems)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(purchaseItems);
  }

  @override
  String toString() => 'PurchaseItemsGetResponse(${toJson()})';
}
