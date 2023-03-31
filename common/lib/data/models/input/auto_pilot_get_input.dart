import 'package:iris_common/data/models/enums/purchase_item_price_interval.dart';
import 'package:collection/collection.dart';

class AutoPilotGetInput {
  final double? amount;
  final int? intervalCount;
  final PURCHASE_ITEM_PRICE_INTERVAL? interval;
  const AutoPilotGetInput({this.amount, this.intervalCount, this.interval});
  AutoPilotGetInput copyWith(
      {double? amount,
      int? intervalCount,
      PURCHASE_ITEM_PRICE_INTERVAL? interval}) {
    return AutoPilotGetInput(
      amount: amount ?? this.amount,
      intervalCount: intervalCount ?? this.intervalCount,
      interval: interval ?? this.interval,
    );
  }

  factory AutoPilotGetInput.fromJson(Map<String, dynamic> json) {
    return AutoPilotGetInput(
      amount: json['amount']?.toDouble(),
      intervalCount: json['intervalCount'],
      interval: json['interval'] != null
          ? PURCHASE_ITEM_PRICE_INTERVAL.values.byName(json['interval'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['amount'] = amount;
    data['intervalCount'] = intervalCount;
    data['interval'] = interval?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotGetInput &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.intervalCount, intervalCount) ||
                const DeepCollectionEquality()
                    .equals(other.intervalCount, intervalCount)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(amount) ^
        const DeepCollectionEquality().hash(intervalCount) ^
        const DeepCollectionEquality().hash(interval);
  }

  @override
  String toString() => 'AutoPilotGetInput(${toJson()})';
}
