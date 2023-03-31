import 'package:iris_common/data/models/enums/user_post_notification_amount.dart';
import 'package:iris_common/data/models/enums/user_trade_notification_amount.dart';
import 'package:collection/collection.dart';

class UserUserInput {
  final USER_POST_NOTIFICATION_AMOUNT? postNotificationAmount;
  final USER_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount;
  final int? userKey;
  const UserUserInput(
      {this.postNotificationAmount,
      this.tradeNotificationAmount,
      required this.userKey});
  UserUserInput copyWith(
      {USER_POST_NOTIFICATION_AMOUNT? postNotificationAmount,
      USER_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount,
      int? userKey}) {
    return UserUserInput(
      postNotificationAmount:
          postNotificationAmount ?? this.postNotificationAmount,
      tradeNotificationAmount:
          tradeNotificationAmount ?? this.tradeNotificationAmount,
      userKey: userKey ?? this.userKey,
    );
  }

  factory UserUserInput.fromJson(Map<String, dynamic> json) {
    return UserUserInput(
      postNotificationAmount: json['postNotificationAmount'] != null
          ? USER_POST_NOTIFICATION_AMOUNT.values
              .byName(json['postNotificationAmount'])
          : null,
      tradeNotificationAmount: json['tradeNotificationAmount'] != null
          ? USER_TRADE_NOTIFICATION_AMOUNT.values
              .byName(json['tradeNotificationAmount'])
          : null,
      userKey: json['userKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['postNotificationAmount'] = postNotificationAmount?.name;
    data['tradeNotificationAmount'] = tradeNotificationAmount?.name;
    data['userKey'] = userKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserUserInput &&
            (identical(other.postNotificationAmount, postNotificationAmount) ||
                const DeepCollectionEquality().equals(
                    other.postNotificationAmount, postNotificationAmount)) &&
            (identical(
                    other.tradeNotificationAmount, tradeNotificationAmount) ||
                const DeepCollectionEquality().equals(
                    other.tradeNotificationAmount, tradeNotificationAmount)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality().equals(other.userKey, userKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(postNotificationAmount) ^
        const DeepCollectionEquality().hash(tradeNotificationAmount) ^
        const DeepCollectionEquality().hash(userKey);
  }

  @override
  String toString() => 'UserUserInput(${toJson()})';
}
