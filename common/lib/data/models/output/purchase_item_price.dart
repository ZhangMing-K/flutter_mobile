import 'package:iris_common/data/models/enums/purchase_item_price_status.dart';
import 'package:iris_common/data/models/output/coupon_connection.dart';
import 'package:iris_common/data/models/enums/purchase_item_price_interval.dart';
import 'package:iris_common/data/models/output/purchase_item.dart';
import 'package:collection/collection.dart';

class PurchaseItemPrice {
  final int? purchaseItemPriceKey;
  final int? purchaseItemKey;
  final PURCHASE_ITEM_PRICE_STATUS? status;
  final String? name;
  final String? remoteId;
  final double? price;
  final CouponConnection? couponConnection;
  final PURCHASE_ITEM_PRICE_INTERVAL? interval;
  final int? intervalCount;
  final DateTime? createdAt;
  final PurchaseItem? purchaseItem;
  const PurchaseItemPrice(
      {this.purchaseItemPriceKey,
      this.purchaseItemKey,
      this.status,
      this.name,
      this.remoteId,
      this.price,
      this.couponConnection,
      this.interval,
      this.intervalCount,
      this.createdAt,
      this.purchaseItem});
  PurchaseItemPrice copyWith(
      {int? purchaseItemPriceKey,
      int? purchaseItemKey,
      PURCHASE_ITEM_PRICE_STATUS? status,
      String? name,
      String? remoteId,
      double? price,
      CouponConnection? couponConnection,
      PURCHASE_ITEM_PRICE_INTERVAL? interval,
      int? intervalCount,
      DateTime? createdAt,
      PurchaseItem? purchaseItem}) {
    return PurchaseItemPrice(
      purchaseItemPriceKey: purchaseItemPriceKey ?? this.purchaseItemPriceKey,
      purchaseItemKey: purchaseItemKey ?? this.purchaseItemKey,
      status: status ?? this.status,
      name: name ?? this.name,
      remoteId: remoteId ?? this.remoteId,
      price: price ?? this.price,
      couponConnection: couponConnection ?? this.couponConnection,
      interval: interval ?? this.interval,
      intervalCount: intervalCount ?? this.intervalCount,
      createdAt: createdAt ?? this.createdAt,
      purchaseItem: purchaseItem ?? this.purchaseItem,
    );
  }

  factory PurchaseItemPrice.fromJson(Map<String, dynamic> json) {
    return PurchaseItemPrice(
      purchaseItemPriceKey: json['purchaseItemPriceKey'],
      purchaseItemKey: json['purchaseItemKey'],
      status: json['status'] != null
          ? PURCHASE_ITEM_PRICE_STATUS.values.byName(json['status'])
          : null,
      name: json['name'],
      remoteId: json['remoteId'],
      price: json['price']?.toDouble(),
      couponConnection: json['couponConnection'] != null
          ? CouponConnection.fromJson(json['couponConnection'])
          : null,
      interval: json['interval'] != null
          ? PURCHASE_ITEM_PRICE_INTERVAL.values.byName(json['interval'])
          : null,
      intervalCount: json['intervalCount'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      purchaseItem: json['purchaseItem'] != null
          ? PurchaseItem.fromJson(json['purchaseItem'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['purchaseItemPriceKey'] = purchaseItemPriceKey;
    data['purchaseItemKey'] = purchaseItemKey;
    data['status'] = status?.name;
    data['name'] = name;
    data['remoteId'] = remoteId;
    data['price'] = price;
    data['couponConnection'] = couponConnection?.toJson();
    data['interval'] = interval?.name;
    data['intervalCount'] = intervalCount;
    data['createdAt'] = createdAt?.toString();
    data['purchaseItem'] = purchaseItem?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PurchaseItemPrice &&
            (identical(other.purchaseItemPriceKey, purchaseItemPriceKey) ||
                const DeepCollectionEquality().equals(
                    other.purchaseItemPriceKey, purchaseItemPriceKey)) &&
            (identical(other.purchaseItemKey, purchaseItemKey) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItemKey, purchaseItemKey)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.couponConnection, couponConnection) ||
                const DeepCollectionEquality()
                    .equals(other.couponConnection, couponConnection)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)) &&
            (identical(other.intervalCount, intervalCount) ||
                const DeepCollectionEquality()
                    .equals(other.intervalCount, intervalCount)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.purchaseItem, purchaseItem) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItem, purchaseItem)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(purchaseItemPriceKey) ^
        const DeepCollectionEquality().hash(purchaseItemKey) ^
        const DeepCollectionEquality().hash(status) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(price) ^
        const DeepCollectionEquality().hash(couponConnection) ^
        const DeepCollectionEquality().hash(interval) ^
        const DeepCollectionEquality().hash(intervalCount) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(purchaseItem);
  }

  @override
  String toString() => 'PurchaseItemPrice(${toJson()})';
}
