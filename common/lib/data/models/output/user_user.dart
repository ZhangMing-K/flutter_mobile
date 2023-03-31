import 'package:iris_common/data/models/enums/user_post_notification_amount.dart';
import 'package:iris_common/data/models/enums/user_trade_notification_amount.dart';
import 'package:collection/collection.dart';

class UserUser {
  final int? profileUserKey;
  final int? accountUserKey;
  final USER_POST_NOTIFICATION_AMOUNT? postNotificationAmount;
  final USER_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount;
  const UserUser(
      {this.profileUserKey,
      this.accountUserKey,
      this.postNotificationAmount,
      this.tradeNotificationAmount});
  UserUser copyWith(
      {int? profileUserKey,
      int? accountUserKey,
      USER_POST_NOTIFICATION_AMOUNT? postNotificationAmount,
      USER_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount}) {
    return UserUser(
      profileUserKey: profileUserKey ?? this.profileUserKey,
      accountUserKey: accountUserKey ?? this.accountUserKey,
      postNotificationAmount:
          postNotificationAmount ?? this.postNotificationAmount,
      tradeNotificationAmount:
          tradeNotificationAmount ?? this.tradeNotificationAmount,
    );
  }

  factory UserUser.fromJson(Map<String, dynamic> json) {
    return UserUser(
      profileUserKey: json['profileUserKey'],
      accountUserKey: json['accountUserKey'],
      postNotificationAmount: json['postNotificationAmount'] != null
          ? USER_POST_NOTIFICATION_AMOUNT.values
              .byName(json['postNotificationAmount'])
          : null,
      tradeNotificationAmount: json['tradeNotificationAmount'] != null
          ? USER_TRADE_NOTIFICATION_AMOUNT.values
              .byName(json['tradeNotificationAmount'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['profileUserKey'] = profileUserKey;
    data['accountUserKey'] = accountUserKey;
    data['postNotificationAmount'] = postNotificationAmount?.name;
    data['tradeNotificationAmount'] = tradeNotificationAmount?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserUser &&
            (identical(other.profileUserKey, profileUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.profileUserKey, profileUserKey)) &&
            (identical(other.accountUserKey, accountUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.accountUserKey, accountUserKey)) &&
            (identical(other.postNotificationAmount, postNotificationAmount) ||
                const DeepCollectionEquality().equals(
                    other.postNotificationAmount, postNotificationAmount)) &&
            (identical(
                    other.tradeNotificationAmount, tradeNotificationAmount) ||
                const DeepCollectionEquality().equals(
                    other.tradeNotificationAmount, tradeNotificationAmount)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(profileUserKey) ^
        const DeepCollectionEquality().hash(accountUserKey) ^
        const DeepCollectionEquality().hash(postNotificationAmount) ^
        const DeepCollectionEquality().hash(tradeNotificationAmount);
  }

  @override
  String toString() => 'UserUser(${toJson()})';
}
