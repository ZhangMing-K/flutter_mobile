import 'package:iris_common/data/models/enums/purchase_item_price_interval.dart';
import 'package:iris_common/data/models/output/purchase_item_price.dart';
import 'package:iris_common/data/models/output/user_subscription.dart';
import 'package:collection/collection.dart';

class GoldConnection {
  final bool? isGoldMember;
  final bool? autoRenew;
  final PURCHASE_ITEM_PRICE_INTERVAL? interval;
  final int? intervalCount;
  final double? userPayingPrice;
  final PurchaseItemPrice? purchaseItemPrice;
  final UserSubscription? subscription;
  const GoldConnection(
      {this.isGoldMember,
      this.autoRenew,
      this.interval,
      this.intervalCount,
      this.userPayingPrice,
      this.purchaseItemPrice,
      this.subscription});
  GoldConnection copyWith(
      {bool? isGoldMember,
      bool? autoRenew,
      PURCHASE_ITEM_PRICE_INTERVAL? interval,
      int? intervalCount,
      double? userPayingPrice,
      PurchaseItemPrice? purchaseItemPrice,
      UserSubscription? subscription}) {
    return GoldConnection(
      isGoldMember: isGoldMember ?? this.isGoldMember,
      autoRenew: autoRenew ?? this.autoRenew,
      interval: interval ?? this.interval,
      intervalCount: intervalCount ?? this.intervalCount,
      userPayingPrice: userPayingPrice ?? this.userPayingPrice,
      purchaseItemPrice: purchaseItemPrice ?? this.purchaseItemPrice,
      subscription: subscription ?? this.subscription,
    );
  }

  factory GoldConnection.fromJson(Map<String, dynamic> json) {
    return GoldConnection(
      isGoldMember: json['isGoldMember'],
      autoRenew: json['autoRenew'],
      interval: json['interval'] != null
          ? PURCHASE_ITEM_PRICE_INTERVAL.values.byName(json['interval'])
          : null,
      intervalCount: json['intervalCount'],
      userPayingPrice: json['userPayingPrice']?.toDouble(),
      purchaseItemPrice: json['purchaseItemPrice'] != null
          ? PurchaseItemPrice.fromJson(json['purchaseItemPrice'])
          : null,
      subscription: json['subscription'] != null
          ? UserSubscription.fromJson(json['subscription'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['isGoldMember'] = isGoldMember;
    data['autoRenew'] = autoRenew;
    data['interval'] = interval?.name;
    data['intervalCount'] = intervalCount;
    data['userPayingPrice'] = userPayingPrice;
    data['purchaseItemPrice'] = purchaseItemPrice?.toJson();
    data['subscription'] = subscription?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GoldConnection &&
            (identical(other.isGoldMember, isGoldMember) ||
                const DeepCollectionEquality()
                    .equals(other.isGoldMember, isGoldMember)) &&
            (identical(other.autoRenew, autoRenew) ||
                const DeepCollectionEquality()
                    .equals(other.autoRenew, autoRenew)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)) &&
            (identical(other.intervalCount, intervalCount) ||
                const DeepCollectionEquality()
                    .equals(other.intervalCount, intervalCount)) &&
            (identical(other.userPayingPrice, userPayingPrice) ||
                const DeepCollectionEquality()
                    .equals(other.userPayingPrice, userPayingPrice)) &&
            (identical(other.purchaseItemPrice, purchaseItemPrice) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItemPrice, purchaseItemPrice)) &&
            (identical(other.subscription, subscription) ||
                const DeepCollectionEquality()
                    .equals(other.subscription, subscription)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(isGoldMember) ^
        const DeepCollectionEquality().hash(autoRenew) ^
        const DeepCollectionEquality().hash(interval) ^
        const DeepCollectionEquality().hash(intervalCount) ^
        const DeepCollectionEquality().hash(userPayingPrice) ^
        const DeepCollectionEquality().hash(purchaseItemPrice) ^
        const DeepCollectionEquality().hash(subscription);
  }

  @override
  String toString() => 'GoldConnection(${toJson()})';
}
