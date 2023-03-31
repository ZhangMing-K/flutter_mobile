import 'package:iris_common/data/models/output/purchase_item.dart';
import 'package:collection/collection.dart';

class PurchaseItemCreateResponse {
  final PurchaseItem? purchaseItem;
  const PurchaseItemCreateResponse({this.purchaseItem});
  PurchaseItemCreateResponse copyWith({PurchaseItem? purchaseItem}) {
    return PurchaseItemCreateResponse(
      purchaseItem: purchaseItem ?? this.purchaseItem,
    );
  }

  factory PurchaseItemCreateResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseItemCreateResponse(
      purchaseItem: json['purchaseItem'] != null
          ? PurchaseItem.fromJson(json['purchaseItem'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['purchaseItem'] = purchaseItem?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PurchaseItemCreateResponse &&
            (identical(other.purchaseItem, purchaseItem) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItem, purchaseItem)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(purchaseItem);
  }

  @override
  String toString() => 'PurchaseItemCreateResponse(${toJson()})';
}
