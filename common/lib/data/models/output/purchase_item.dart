import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/enums/subscription_type.dart';
import 'package:iris_common/data/models/output/user_subscription.dart';
import 'package:iris_common/data/models/output/purchase_item_price.dart';
import 'package:collection/collection.dart';

class PurchaseItem {
  final int? purchaseItemKey;
  final int? profileUserKey;
  final User? profileUser;
  final SUBSCRIPTION_TYPE? subscriptionType;
  final bool? isSubscription;
  final String? description;
  final String? name;
  final String? remoteId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<UserSubscription>? subscriptions;
  final UserSubscription? authUserSubscription;
  final PurchaseItemPrice? dayPurchaseItemPrice;
  final PurchaseItemPrice? threeMonthPurchaseItemPrice;
  final PurchaseItemPrice? yearPurchaseItemPrice;
  final PurchaseItemPrice? purchaseItemPrice;
  final List<PurchaseItemPrice>? purchaseItemPrices;
  const PurchaseItem(
      {this.purchaseItemKey,
      this.profileUserKey,
      this.profileUser,
      this.subscriptionType,
      this.isSubscription,
      this.description,
      this.name,
      this.remoteId,
      this.createdAt,
      this.updatedAt,
      this.subscriptions,
      this.authUserSubscription,
      this.dayPurchaseItemPrice,
      this.threeMonthPurchaseItemPrice,
      this.yearPurchaseItemPrice,
      this.purchaseItemPrice,
      this.purchaseItemPrices});
  PurchaseItem copyWith(
      {int? purchaseItemKey,
      int? profileUserKey,
      User? profileUser,
      SUBSCRIPTION_TYPE? subscriptionType,
      bool? isSubscription,
      String? description,
      String? name,
      String? remoteId,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<UserSubscription>? subscriptions,
      UserSubscription? authUserSubscription,
      PurchaseItemPrice? dayPurchaseItemPrice,
      PurchaseItemPrice? threeMonthPurchaseItemPrice,
      PurchaseItemPrice? yearPurchaseItemPrice,
      PurchaseItemPrice? purchaseItemPrice,
      List<PurchaseItemPrice>? purchaseItemPrices}) {
    return PurchaseItem(
      purchaseItemKey: purchaseItemKey ?? this.purchaseItemKey,
      profileUserKey: profileUserKey ?? this.profileUserKey,
      profileUser: profileUser ?? this.profileUser,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      isSubscription: isSubscription ?? this.isSubscription,
      description: description ?? this.description,
      name: name ?? this.name,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      subscriptions: subscriptions ?? this.subscriptions,
      authUserSubscription: authUserSubscription ?? this.authUserSubscription,
      dayPurchaseItemPrice: dayPurchaseItemPrice ?? this.dayPurchaseItemPrice,
      threeMonthPurchaseItemPrice:
          threeMonthPurchaseItemPrice ?? this.threeMonthPurchaseItemPrice,
      yearPurchaseItemPrice:
          yearPurchaseItemPrice ?? this.yearPurchaseItemPrice,
      purchaseItemPrice: purchaseItemPrice ?? this.purchaseItemPrice,
      purchaseItemPrices: purchaseItemPrices ?? this.purchaseItemPrices,
    );
  }

  factory PurchaseItem.fromJson(Map<String, dynamic> json) {
    return PurchaseItem(
      purchaseItemKey: json['purchaseItemKey'],
      profileUserKey: json['profileUserKey'],
      profileUser: json['profileUser'] != null
          ? User.fromJson(json['profileUser'])
          : null,
      subscriptionType: json['subscriptionType'] != null
          ? SUBSCRIPTION_TYPE.values.byName(json['subscriptionType'])
          : null,
      isSubscription: json['isSubscription'],
      description: json['description'],
      name: json['name'],
      remoteId: json['remoteId'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      subscriptions: json['subscriptions']
          ?.map<UserSubscription>((o) => UserSubscription.fromJson(o))
          .toList(),
      authUserSubscription: json['authUserSubscription'] != null
          ? UserSubscription.fromJson(json['authUserSubscription'])
          : null,
      dayPurchaseItemPrice: json['dayPurchaseItemPrice'] != null
          ? PurchaseItemPrice.fromJson(json['dayPurchaseItemPrice'])
          : null,
      threeMonthPurchaseItemPrice: json['threeMonthPurchaseItemPrice'] != null
          ? PurchaseItemPrice.fromJson(json['threeMonthPurchaseItemPrice'])
          : null,
      yearPurchaseItemPrice: json['yearPurchaseItemPrice'] != null
          ? PurchaseItemPrice.fromJson(json['yearPurchaseItemPrice'])
          : null,
      purchaseItemPrice: json['purchaseItemPrice'] != null
          ? PurchaseItemPrice.fromJson(json['purchaseItemPrice'])
          : null,
      purchaseItemPrices: json['purchaseItemPrices']
          ?.map<PurchaseItemPrice>((o) => PurchaseItemPrice.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['purchaseItemKey'] = purchaseItemKey;
    data['profileUserKey'] = profileUserKey;
    data['profileUser'] = profileUser?.toJson();
    data['subscriptionType'] = subscriptionType?.name;
    data['isSubscription'] = isSubscription;
    data['description'] = description;
    data['name'] = name;
    data['remoteId'] = remoteId;
    data['createdAt'] = createdAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    data['subscriptions'] =
        subscriptions?.map((item) => item.toJson()).toList();
    data['authUserSubscription'] = authUserSubscription?.toJson();
    data['dayPurchaseItemPrice'] = dayPurchaseItemPrice?.toJson();
    data['threeMonthPurchaseItemPrice'] = threeMonthPurchaseItemPrice?.toJson();
    data['yearPurchaseItemPrice'] = yearPurchaseItemPrice?.toJson();
    data['purchaseItemPrice'] = purchaseItemPrice?.toJson();
    data['purchaseItemPrices'] =
        purchaseItemPrices?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PurchaseItem &&
            (identical(other.purchaseItemKey, purchaseItemKey) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItemKey, purchaseItemKey)) &&
            (identical(other.profileUserKey, profileUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.profileUserKey, profileUserKey)) &&
            (identical(other.profileUser, profileUser) ||
                const DeepCollectionEquality()
                    .equals(other.profileUser, profileUser)) &&
            (identical(other.subscriptionType, subscriptionType) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionType, subscriptionType)) &&
            (identical(other.isSubscription, isSubscription) ||
                const DeepCollectionEquality()
                    .equals(other.isSubscription, isSubscription)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.subscriptions, subscriptions) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptions, subscriptions)) &&
            (identical(other.authUserSubscription, authUserSubscription) ||
                const DeepCollectionEquality().equals(
                    other.authUserSubscription, authUserSubscription)) &&
            (identical(other.dayPurchaseItemPrice, dayPurchaseItemPrice) ||
                const DeepCollectionEquality().equals(
                    other.dayPurchaseItemPrice, dayPurchaseItemPrice)) &&
            (identical(other.threeMonthPurchaseItemPrice,
                    threeMonthPurchaseItemPrice) ||
                const DeepCollectionEquality().equals(
                    other.threeMonthPurchaseItemPrice,
                    threeMonthPurchaseItemPrice)) &&
            (identical(other.yearPurchaseItemPrice, yearPurchaseItemPrice) ||
                const DeepCollectionEquality().equals(
                    other.yearPurchaseItemPrice, yearPurchaseItemPrice)) &&
            (identical(other.purchaseItemPrice, purchaseItemPrice) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItemPrice, purchaseItemPrice)) &&
            (identical(other.purchaseItemPrices, purchaseItemPrices) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItemPrices, purchaseItemPrices)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(purchaseItemKey) ^
        const DeepCollectionEquality().hash(profileUserKey) ^
        const DeepCollectionEquality().hash(profileUser) ^
        const DeepCollectionEquality().hash(subscriptionType) ^
        const DeepCollectionEquality().hash(isSubscription) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(updatedAt) ^
        const DeepCollectionEquality().hash(subscriptions) ^
        const DeepCollectionEquality().hash(authUserSubscription) ^
        const DeepCollectionEquality().hash(dayPurchaseItemPrice) ^
        const DeepCollectionEquality().hash(threeMonthPurchaseItemPrice) ^
        const DeepCollectionEquality().hash(yearPurchaseItemPrice) ^
        const DeepCollectionEquality().hash(purchaseItemPrice) ^
        const DeepCollectionEquality().hash(purchaseItemPrices);
  }

  @override
  String toString() => 'PurchaseItem(${toJson()})';
}
