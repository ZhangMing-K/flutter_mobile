import 'package:iris_common/data/models/enums/user_post_notification_amount.dart';
import 'package:iris_common/data/models/enums/user_trade_notification_amount.dart';
import 'package:collection/collection.dart';

class GlobalUserUserUpdateInput {
  final USER_POST_NOTIFICATION_AMOUNT? postNotificationAmount;
  final USER_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount;
  const GlobalUserUserUpdateInput(
      {this.postNotificationAmount, this.tradeNotificationAmount});
  GlobalUserUserUpdateInput copyWith(
      {USER_POST_NOTIFICATION_AMOUNT? postNotificationAmount,
      USER_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount}) {
    return GlobalUserUserUpdateInput(
      postNotificationAmount:
          postNotificationAmount ?? this.postNotificationAmount,
      tradeNotificationAmount:
          tradeNotificationAmount ?? this.tradeNotificationAmount,
    );
  }

  factory GlobalUserUserUpdateInput.fromJson(Map<String, dynamic> json) {
    return GlobalUserUserUpdateInput(
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
    data['postNotificationAmount'] = postNotificationAmount?.name;
    data['tradeNotificationAmount'] = tradeNotificationAmount?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GlobalUserUserUpdateInput &&
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
        const DeepCollectionEquality().hash(postNotificationAmount) ^
        const DeepCollectionEquality().hash(tradeNotificationAmount);
  }

  @override
  String toString() => 'GlobalUserUserUpdateInput(${toJson()})';
}
