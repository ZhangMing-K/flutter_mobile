import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/user_subscription.dart';
import 'package:iris_common/data/models/output/purchase_item.dart';
import 'package:iris_common/data/models/enums/payment_transaction_status.dart';
import 'package:collection/collection.dart';

class PaymentTransaction {
  final int? paymentTransactionKey;
  final int? userKey;
  final User? user;
  final int? subscriptionKey;
  final UserSubscription? subscription;
  final String? remoteId;
  final String? paymentSecret;
  final int? purchaseItemKey;
  final PurchaseItem? purchaseItem;
  final int? paymentMethodKey;
  final PAYMENT_TRANSACTION_STATUS? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? submittedAt;
  final DateTime? cancelledAt;
  final DateTime? failedAt;
  const PaymentTransaction(
      {this.paymentTransactionKey,
      this.userKey,
      this.user,
      this.subscriptionKey,
      this.subscription,
      this.remoteId,
      this.paymentSecret,
      this.purchaseItemKey,
      this.purchaseItem,
      this.paymentMethodKey,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.submittedAt,
      this.cancelledAt,
      this.failedAt});
  PaymentTransaction copyWith(
      {int? paymentTransactionKey,
      int? userKey,
      User? user,
      int? subscriptionKey,
      UserSubscription? subscription,
      String? remoteId,
      String? paymentSecret,
      int? purchaseItemKey,
      PurchaseItem? purchaseItem,
      int? paymentMethodKey,
      PAYMENT_TRANSACTION_STATUS? status,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? submittedAt,
      DateTime? cancelledAt,
      DateTime? failedAt}) {
    return PaymentTransaction(
      paymentTransactionKey:
          paymentTransactionKey ?? this.paymentTransactionKey,
      userKey: userKey ?? this.userKey,
      user: user ?? this.user,
      subscriptionKey: subscriptionKey ?? this.subscriptionKey,
      subscription: subscription ?? this.subscription,
      remoteId: remoteId ?? this.remoteId,
      paymentSecret: paymentSecret ?? this.paymentSecret,
      purchaseItemKey: purchaseItemKey ?? this.purchaseItemKey,
      purchaseItem: purchaseItem ?? this.purchaseItem,
      paymentMethodKey: paymentMethodKey ?? this.paymentMethodKey,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      submittedAt: submittedAt ?? this.submittedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      failedAt: failedAt ?? this.failedAt,
    );
  }

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) {
    return PaymentTransaction(
      paymentTransactionKey: json['paymentTransactionKey'],
      userKey: json['userKey'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      subscriptionKey: json['subscriptionKey'],
      subscription: json['subscription'] != null
          ? UserSubscription.fromJson(json['subscription'])
          : null,
      remoteId: json['remoteId'],
      paymentSecret: json['paymentSecret'],
      purchaseItemKey: json['purchaseItemKey'],
      purchaseItem: json['purchaseItem'] != null
          ? PurchaseItem.fromJson(json['purchaseItem'])
          : null,
      paymentMethodKey: json['paymentMethodKey'],
      status: json['status'] != null
          ? PAYMENT_TRANSACTION_STATUS.values.byName(json['status'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      submittedAt: json['submittedAt'] != null
          ? DateTime.parse(json['submittedAt'])
          : null,
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'])
          : null,
      failedAt:
          json['failedAt'] != null ? DateTime.parse(json['failedAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['paymentTransactionKey'] = paymentTransactionKey;
    data['userKey'] = userKey;
    data['user'] = user?.toJson();
    data['subscriptionKey'] = subscriptionKey;
    data['subscription'] = subscription?.toJson();
    data['remoteId'] = remoteId;
    data['paymentSecret'] = paymentSecret;
    data['purchaseItemKey'] = purchaseItemKey;
    data['purchaseItem'] = purchaseItem?.toJson();
    data['paymentMethodKey'] = paymentMethodKey;
    data['status'] = status?.name;
    data['createdAt'] = createdAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    data['submittedAt'] = submittedAt?.toString();
    data['cancelledAt'] = cancelledAt?.toString();
    data['failedAt'] = failedAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaymentTransaction &&
            (identical(other.paymentTransactionKey, paymentTransactionKey) ||
                const DeepCollectionEquality().equals(
                    other.paymentTransactionKey, paymentTransactionKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.subscriptionKey, subscriptionKey) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionKey, subscriptionKey)) &&
            (identical(other.subscription, subscription) ||
                const DeepCollectionEquality()
                    .equals(other.subscription, subscription)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.paymentSecret, paymentSecret) ||
                const DeepCollectionEquality()
                    .equals(other.paymentSecret, paymentSecret)) &&
            (identical(other.purchaseItemKey, purchaseItemKey) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItemKey, purchaseItemKey)) &&
            (identical(other.purchaseItem, purchaseItem) ||
                const DeepCollectionEquality()
                    .equals(other.purchaseItem, purchaseItem)) &&
            (identical(other.paymentMethodKey, paymentMethodKey) ||
                const DeepCollectionEquality()
                    .equals(other.paymentMethodKey, paymentMethodKey)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.submittedAt, submittedAt) ||
                const DeepCollectionEquality()
                    .equals(other.submittedAt, submittedAt)) &&
            (identical(other.cancelledAt, cancelledAt) ||
                const DeepCollectionEquality()
                    .equals(other.cancelledAt, cancelledAt)) &&
            (identical(other.failedAt, failedAt) ||
                const DeepCollectionEquality()
                    .equals(other.failedAt, failedAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(paymentTransactionKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(subscriptionKey) ^
        const DeepCollectionEquality().hash(subscription) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(paymentSecret) ^
        const DeepCollectionEquality().hash(purchaseItemKey) ^
        const DeepCollectionEquality().hash(purchaseItem) ^
        const DeepCollectionEquality().hash(paymentMethodKey) ^
        const DeepCollectionEquality().hash(status) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(updatedAt) ^
        const DeepCollectionEquality().hash(submittedAt) ^
        const DeepCollectionEquality().hash(cancelledAt) ^
        const DeepCollectionEquality().hash(failedAt);
  }

  @override
  String toString() => 'PaymentTransaction(${toJson()})';
}
