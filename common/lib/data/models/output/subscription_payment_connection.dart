import 'package:iris_common/data/models/enums/purchase_item_price_interval.dart';
import 'package:collection/collection.dart';

class SubscriptionPaymentConnection {
  final double? userPayingPrice;
  final PURCHASE_ITEM_PRICE_INTERVAL? interval;
  final int? intervalCount;
  const SubscriptionPaymentConnection(
      {this.userPayingPrice, this.interval, this.intervalCount});
  SubscriptionPaymentConnection copyWith(
      {double? userPayingPrice,
      PURCHASE_ITEM_PRICE_INTERVAL? interval,
      int? intervalCount}) {
    return SubscriptionPaymentConnection(
      userPayingPrice: userPayingPrice ?? this.userPayingPrice,
      interval: interval ?? this.interval,
      intervalCount: intervalCount ?? this.intervalCount,
    );
  }

  factory SubscriptionPaymentConnection.fromJson(Map<String, dynamic> json) {
    return SubscriptionPaymentConnection(
      userPayingPrice: json['userPayingPrice']?.toDouble(),
      interval: json['interval'] != null
          ? PURCHASE_ITEM_PRICE_INTERVAL.values.byName(json['interval'])
          : null,
      intervalCount: json['intervalCount'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userPayingPrice'] = userPayingPrice;
    data['interval'] = interval?.name;
    data['intervalCount'] = intervalCount;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SubscriptionPaymentConnection &&
            (identical(other.userPayingPrice, userPayingPrice) ||
                const DeepCollectionEquality()
                    .equals(other.userPayingPrice, userPayingPrice)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)) &&
            (identical(other.intervalCount, intervalCount) ||
                const DeepCollectionEquality()
                    .equals(other.intervalCount, intervalCount)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userPayingPrice) ^
        const DeepCollectionEquality().hash(interval) ^
        const DeepCollectionEquality().hash(intervalCount);
  }

  @override
  String toString() => 'SubscriptionPaymentConnection(${toJson()})';
}
