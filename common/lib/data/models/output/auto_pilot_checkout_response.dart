import 'package:iris_common/data/models/output/purchase_item.dart';
import 'package:iris_common/data/models/output/user_subscription.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class AutoPilotCheckoutResponse {
  final PurchaseItem? purchaseItem;
  final UserSubscription? subscription;
  final User? user;
  const AutoPilotCheckoutResponse(
      {this.purchaseItem, this.subscription, this.user});
  AutoPilotCheckoutResponse copyWith(
      {PurchaseItem? purchaseItem,
      UserSubscription? subscription,
      User? user}) {
    return AutoPilotCheckoutResponse(
      purchaseItem: purchaseItem ?? this.purchaseItem,
      subscription: subscription ?? this.subscription,
      user: user ?? this.user,
    );
  }

  factory AutoPilotCheckoutResponse.fromJson(Map<String, dynamic> json) {
    return AutoPilotCheckoutResponse(
      purchaseItem: json['purchaseItem'] != null
          ? PurchaseItem.fromJson(json['purchaseItem'])
          : null,
      subscription: json['subscription'] != null
          ? UserSubscription.fromJson(json['subscription'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['purchaseItem'] = purchaseItem?.toJson();
    data['subscription'] = subscription?.toJson();
    data['user'] = user?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotCheckoutResponse &&
            (identical(other.purchaseItem, purchaseItem) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItem, purchaseItem)) &&
            (identical(other.subscription, subscription) ||
                const DeepCollectionEquality()
                    .equals(other.subscription, subscription)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(purchaseItem) ^
        const DeepCollectionEquality().hash(subscription) ^
        const DeepCollectionEquality().hash(user);
  }

  @override
  String toString() => 'AutoPilotCheckoutResponse(${toJson()})';
}
