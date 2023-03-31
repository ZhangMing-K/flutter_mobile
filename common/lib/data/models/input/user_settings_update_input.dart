import 'package:iris_common/data/models/enums/messaging_notification_amount.dart';
import 'package:iris_common/data/models/enums/trade_notification_amount.dart';
import 'package:iris_common/data/models/enums/follow_notification_amount.dart';
import 'package:iris_common/data/models/enums/post_notification_amount.dart';
import 'package:collection/collection.dart';

class UserSettingsUpdateInput {
  final MESSAGING_NOTIFICATION_AMOUNT? messagingNotificationAmount;
  final TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount;
  final FOLLOW_NOTIFICATION_AMOUNT? followNotificationAmount;
  final POST_NOTIFICATION_AMOUNT? postNotificationAmount;
  const UserSettingsUpdateInput(
      {this.messagingNotificationAmount,
      this.tradeNotificationAmount,
      this.followNotificationAmount,
      this.postNotificationAmount});
  UserSettingsUpdateInput copyWith(
      {MESSAGING_NOTIFICATION_AMOUNT? messagingNotificationAmount,
      TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount,
      FOLLOW_NOTIFICATION_AMOUNT? followNotificationAmount,
      POST_NOTIFICATION_AMOUNT? postNotificationAmount}) {
    return UserSettingsUpdateInput(
      messagingNotificationAmount:
          messagingNotificationAmount ?? this.messagingNotificationAmount,
      tradeNotificationAmount:
          tradeNotificationAmount ?? this.tradeNotificationAmount,
      followNotificationAmount:
          followNotificationAmount ?? this.followNotificationAmount,
      postNotificationAmount:
          postNotificationAmount ?? this.postNotificationAmount,
    );
  }

  factory UserSettingsUpdateInput.fromJson(Map<String, dynamic> json) {
    return UserSettingsUpdateInput(
      messagingNotificationAmount: json['messagingNotificationAmount'] != null
          ? MESSAGING_NOTIFICATION_AMOUNT.values
              .byName(json['messagingNotificationAmount'])
          : null,
      tradeNotificationAmount: json['tradeNotificationAmount'] != null
          ? TRADE_NOTIFICATION_AMOUNT.values
              .byName(json['tradeNotificationAmount'])
          : null,
      followNotificationAmount: json['followNotificationAmount'] != null
          ? FOLLOW_NOTIFICATION_AMOUNT.values
              .byName(json['followNotificationAmount'])
          : null,
      postNotificationAmount: json['postNotificationAmount'] != null
          ? POST_NOTIFICATION_AMOUNT.values
              .byName(json['postNotificationAmount'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['messagingNotificationAmount'] = messagingNotificationAmount?.name;
    data['tradeNotificationAmount'] = tradeNotificationAmount?.name;
    data['followNotificationAmount'] = followNotificationAmount?.name;
    data['postNotificationAmount'] = postNotificationAmount?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSettingsUpdateInput &&
            (identical(other.messagingNotificationAmount,
                    messagingNotificationAmount) ||
                const DeepCollectionEquality().equals(
                    other.messagingNotificationAmount,
                    messagingNotificationAmount)) &&
            (identical(
                    other.tradeNotificationAmount, tradeNotificationAmount) ||
                const DeepCollectionEquality().equals(
                    other.tradeNotificationAmount, tradeNotificationAmount)) &&
            (identical(
                    other.followNotificationAmount, followNotificationAmount) ||
                const DeepCollectionEquality().equals(
                    other.followNotificationAmount,
                    followNotificationAmount)) &&
            (identical(other.postNotificationAmount, postNotificationAmount) ||
                const DeepCollectionEquality().equals(
                    other.postNotificationAmount, postNotificationAmount)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(messagingNotificationAmount) ^
        const DeepCollectionEquality().hash(tradeNotificationAmount) ^
        const DeepCollectionEquality().hash(followNotificationAmount) ^
        const DeepCollectionEquality().hash(postNotificationAmount);
  }

  @override
  String toString() => 'UserSettingsUpdateInput(${toJson()})';
}
