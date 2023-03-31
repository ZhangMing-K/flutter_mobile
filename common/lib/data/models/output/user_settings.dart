import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/enums/messaging_notification_amount.dart';
import 'package:iris_common/data/models/enums/trade_notification_amount.dart';
import 'package:iris_common/data/models/enums/follow_notification_amount.dart';
import 'package:iris_common/data/models/enums/post_notification_amount.dart';
import 'package:collection/collection.dart';

class UserSettings {
  final int? userSettingsKey;
  final int? userKey;
  final User? user;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final MESSAGING_NOTIFICATION_AMOUNT? messagingNotificationAmount;
  final TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount;
  final FOLLOW_NOTIFICATION_AMOUNT? followNotificationAmount;
  final POST_NOTIFICATION_AMOUNT? postNotificationAmount;
  const UserSettings(
      {this.userSettingsKey,
      this.userKey,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.messagingNotificationAmount,
      this.tradeNotificationAmount,
      this.followNotificationAmount,
      this.postNotificationAmount});
  UserSettings copyWith(
      {int? userSettingsKey,
      int? userKey,
      User? user,
      DateTime? createdAt,
      DateTime? updatedAt,
      MESSAGING_NOTIFICATION_AMOUNT? messagingNotificationAmount,
      TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount,
      FOLLOW_NOTIFICATION_AMOUNT? followNotificationAmount,
      POST_NOTIFICATION_AMOUNT? postNotificationAmount}) {
    return UserSettings(
      userSettingsKey: userSettingsKey ?? this.userSettingsKey,
      userKey: userKey ?? this.userKey,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      userSettingsKey: json['userSettingsKey'],
      userKey: json['userKey'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
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
    data['userSettingsKey'] = userSettingsKey;
    data['userKey'] = userKey;
    data['user'] = user?.toJson();
    data['createdAt'] = createdAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    data['messagingNotificationAmount'] = messagingNotificationAmount?.name;
    data['tradeNotificationAmount'] = tradeNotificationAmount?.name;
    data['followNotificationAmount'] = followNotificationAmount?.name;
    data['postNotificationAmount'] = postNotificationAmount?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSettings &&
            (identical(other.userSettingsKey, userSettingsKey) ||
                const DeepCollectionEquality()
                    .equals(other.userSettingsKey, userSettingsKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
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
        const DeepCollectionEquality().hash(userSettingsKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(updatedAt) ^
        const DeepCollectionEquality().hash(messagingNotificationAmount) ^
        const DeepCollectionEquality().hash(tradeNotificationAmount) ^
        const DeepCollectionEquality().hash(followNotificationAmount) ^
        const DeepCollectionEquality().hash(postNotificationAmount);
  }

  @override
  String toString() => 'UserSettings(${toJson()})';
}
