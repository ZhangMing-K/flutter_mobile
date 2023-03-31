import 'package:iris_common/data/models/output/purchase_item.dart';
import 'package:iris_common/data/models/output/user_subscription.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class PurchaseItemCheckoutResponse {
  final List<PurchaseItem>? purchaseItems;
  final UserSubscription? subscription;
  final User? user;
  const PurchaseItemCheckoutResponse(
      {this.purchaseItems, this.subscription, this.user});
  PurchaseItemCheckoutResponse copyWith(
      {List<PurchaseItem>? purchaseItems,
      UserSubscription? subscription,
      User? user}) {
    return PurchaseItemCheckoutResponse(
      purchaseItems: purchaseItems ?? this.purchaseItems,
      subscription: subscription ?? this.subscription,
      user: user ?? this.user,
    );
  }

  factory PurchaseItemCheckoutResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseItemCheckoutResponse(
      purchaseItems: json['purchaseItems']
          ?.map<PurchaseItem>((o) => PurchaseItem.fromJson(o))
          .toList(),
      subscription: json['subscription'] != null
          ? UserSubscription.fromJson(json['subscription'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['purchaseItems'] =
        purchaseItems?.map((item) => item.toJson()).toList();
    data['subscription'] = subscription?.toJson();
    data['user'] = user?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PurchaseItemCheckoutResponse &&
            (identical(other.purchaseItems, purchaseItems) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItems, purchaseItems)) &&
            (identical(other.subscription, subscription) ||
                const DeepCollectionEquality()
                    .equals(other.subscription, subscription)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(purchaseItems) ^
        const DeepCollectionEquality().hash(subscription) ^
        const DeepCollectionEquality().hash(user);
  }

  @override
  String toString() => 'PurchaseItemCheckoutResponse(${toJson()})';
}
