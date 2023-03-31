import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/enums/subscription_status.dart';
import 'package:iris_common/data/models/enums/subscription_state.dart';
import 'package:iris_common/data/models/output/payment_transaction.dart';
import 'package:iris_common/data/models/output/payment_method.dart';
import 'package:iris_common/data/models/output/subscription_payment_connection.dart';
import 'package:collection/collection.dart';

class UserSubscription {
  final int? subscriptionKey;
  final int? userKey;
  final User? user;
  final SUBSCRIPTION_STATUS? status;
  final SUBSCRIPTION_STATE? subscriptionState;
  final PaymentTransaction? latestPaymentTransaction;
  final int? paymentMethodKey;
  final PaymentMethod? paymentMethod;
  final bool? autoRenew;
  final String? remoteId;
  final DateTime? startAt;
  final DateTime? endAt;
  final DateTime? cancelledAt;
  final DateTime? createdAt;
  final DateTime? requiredPaymentAt;
  final DateTime? updatedAt;
  final SubscriptionPaymentConnection? subscriptionPaymentConnection;
  const UserSubscription(
      {this.subscriptionKey,
      this.userKey,
      this.user,
      this.status,
      this.subscriptionState,
      this.latestPaymentTransaction,
      this.paymentMethodKey,
      this.paymentMethod,
      this.autoRenew,
      this.remoteId,
      this.startAt,
      this.endAt,
      this.cancelledAt,
      this.createdAt,
      this.requiredPaymentAt,
      this.updatedAt,
      this.subscriptionPaymentConnection});
  UserSubscription copyWith(
      {int? subscriptionKey,
      int? userKey,
      User? user,
      SUBSCRIPTION_STATUS? status,
      SUBSCRIPTION_STATE? subscriptionState,
      PaymentTransaction? latestPaymentTransaction,
      int? paymentMethodKey,
      PaymentMethod? paymentMethod,
      bool? autoRenew,
      String? remoteId,
      DateTime? startAt,
      DateTime? endAt,
      DateTime? cancelledAt,
      DateTime? createdAt,
      DateTime? requiredPaymentAt,
      DateTime? updatedAt,
      SubscriptionPaymentConnection? subscriptionPaymentConnection}) {
    return UserSubscription(
      subscriptionKey: subscriptionKey ?? this.subscriptionKey,
      userKey: userKey ?? this.userKey,
      user: user ?? this.user,
      status: status ?? this.status,
      subscriptionState: subscriptionState ?? this.subscriptionState,
      latestPaymentTransaction:
          latestPaymentTransaction ?? this.latestPaymentTransaction,
      paymentMethodKey: paymentMethodKey ?? this.paymentMethodKey,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      autoRenew: autoRenew ?? this.autoRenew,
      remoteId: remoteId ?? this.remoteId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      createdAt: createdAt ?? this.createdAt,
      requiredPaymentAt: requiredPaymentAt ?? this.requiredPaymentAt,
      updatedAt: updatedAt ?? this.updatedAt,
      subscriptionPaymentConnection:
          subscriptionPaymentConnection ?? this.subscriptionPaymentConnection,
    );
  }

  factory UserSubscription.fromJson(Map<String, dynamic> json) {
    return UserSubscription(
      subscriptionKey: json['subscriptionKey'],
      userKey: json['userKey'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      status: json['status'] != null
          ? SUBSCRIPTION_STATUS.values.byName(json['status'])
          : null,
      subscriptionState: json['subscriptionState'] != null
          ? SUBSCRIPTION_STATE.values.byName(json['subscriptionState'])
          : null,
      latestPaymentTransaction: json['latestPaymentTransaction'] != null
          ? PaymentTransaction.fromJson(json['latestPaymentTransaction'])
          : null,
      paymentMethodKey: json['paymentMethodKey'],
      paymentMethod: json['paymentMethod'] != null
          ? PaymentMethod.fromJson(json['paymentMethod'])
          : null,
      autoRenew: json['autoRenew'],
      remoteId: json['remoteId'],
      startAt: json['startAt'] != null ? DateTime.parse(json['startAt']) : null,
      endAt: json['endAt'] != null ? DateTime.parse(json['endAt']) : null,
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      requiredPaymentAt: json['requiredPaymentAt'] != null
          ? DateTime.parse(json['requiredPaymentAt'])
          : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      subscriptionPaymentConnection:
          json['subscriptionPaymentConnection'] != null
              ? SubscriptionPaymentConnection.fromJson(
                  json['subscriptionPaymentConnection'])
              : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['subscriptionKey'] = subscriptionKey;
    data['userKey'] = userKey;
    data['user'] = user?.toJson();
    data['status'] = status?.name;
    data['subscriptionState'] = subscriptionState?.name;
    data['latestPaymentTransaction'] = latestPaymentTransaction?.toJson();
    data['paymentMethodKey'] = paymentMethodKey;
    data['paymentMethod'] = paymentMethod?.toJson();
    data['autoRenew'] = autoRenew;
    data['remoteId'] = remoteId;
    data['startAt'] = startAt?.toString();
    data['endAt'] = endAt?.toString();
    data['cancelledAt'] = cancelledAt?.toString();
    data['createdAt'] = createdAt?.toString();
    data['requiredPaymentAt'] = requiredPaymentAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    data['subscriptionPaymentConnection'] =
        subscriptionPaymentConnection?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSubscription &&
            (identical(other.subscriptionKey, subscriptionKey) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionKey, subscriptionKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.subscriptionState, subscriptionState) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionState, subscriptionState)) &&
            (identical(other.latestPaymentTransaction, latestPaymentTransaction) ||
                const DeepCollectionEquality().equals(
                    other.latestPaymentTransaction,
                    latestPaymentTransaction)) &&
            (identical(other.paymentMethodKey, paymentMethodKey) ||
                const DeepCollectionEquality()
                    .equals(other.paymentMethodKey, paymentMethodKey)) &&
            (identical(other.paymentMethod, paymentMethod) ||
                const DeepCollectionEquality()
                    .equals(other.paymentMethod, paymentMethod)) &&
            (identical(other.autoRenew, autoRenew) ||
                const DeepCollectionEquality()
                    .equals(other.autoRenew, autoRenew)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.startAt, startAt) ||
                const DeepCollectionEquality()
                    .equals(other.startAt, startAt)) &&
            (identical(other.endAt, endAt) ||
                const DeepCollectionEquality().equals(other.endAt, endAt)) &&
            (identical(other.cancelledAt, cancelledAt) ||
                const DeepCollectionEquality()
                    .equals(other.cancelledAt, cancelledAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.requiredPaymentAt, requiredPaymentAt) ||
                const DeepCollectionEquality()
                    .equals(other.requiredPaymentAt, requiredPaymentAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.subscriptionPaymentConnection, subscriptionPaymentConnection) ||
                const DeepCollectionEquality().equals(
                    other.subscriptionPaymentConnection,
                    subscriptionPaymentConnection)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(subscriptionKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(status) ^
        const DeepCollectionEquality().hash(subscriptionState) ^
        const DeepCollectionEquality().hash(latestPaymentTransaction) ^
        const DeepCollectionEquality().hash(paymentMethodKey) ^
        const DeepCollectionEquality().hash(paymentMethod) ^
        const DeepCollectionEquality().hash(autoRenew) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(startAt) ^
        const DeepCollectionEquality().hash(endAt) ^
        const DeepCollectionEquality().hash(cancelledAt) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(requiredPaymentAt) ^
        const DeepCollectionEquality().hash(updatedAt) ^
        const DeepCollectionEquality().hash(subscriptionPaymentConnection);
  }

  @override
  String toString() => 'UserSubscription(${toJson()})';
}
