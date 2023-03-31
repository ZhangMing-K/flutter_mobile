import 'package:iris_common/data/models/enums/subscription_type.dart';
import 'package:collection/collection.dart';

class PurchaseItemsGetInput {
  final List<SUBSCRIPTION_TYPE>? subscriptionTypes;
  final bool? excludeCurrentSubscriptions;
  final bool? excludeSubscriptions;
  final int? limit;
  final int? offset;
  const PurchaseItemsGetInput(
      {this.subscriptionTypes,
      this.excludeCurrentSubscriptions,
      this.excludeSubscriptions,
      this.limit,
      this.offset});
  PurchaseItemsGetInput copyWith(
      {List<SUBSCRIPTION_TYPE>? subscriptionTypes,
      bool? excludeCurrentSubscriptions,
      bool? excludeSubscriptions,
      int? limit,
      int? offset}) {
    return PurchaseItemsGetInput(
      subscriptionTypes: subscriptionTypes ?? this.subscriptionTypes,
      excludeCurrentSubscriptions:
          excludeCurrentSubscriptions ?? this.excludeCurrentSubscriptions,
      excludeSubscriptions: excludeSubscriptions ?? this.excludeSubscriptions,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory PurchaseItemsGetInput.fromJson(Map<String, dynamic> json) {
    return PurchaseItemsGetInput(
      subscriptionTypes: json['subscriptionTypes']
          ?.map<SUBSCRIPTION_TYPE>((o) => SUBSCRIPTION_TYPE.values.byName(o))
          .toList(),
      excludeCurrentSubscriptions: json['excludeCurrentSubscriptions'],
      excludeSubscriptions: json['excludeSubscriptions'],
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['subscriptionTypes'] =
        subscriptionTypes?.map((item) => item.name).toList();
    data['excludeCurrentSubscriptions'] = excludeCurrentSubscriptions;
    data['excludeSubscriptions'] = excludeSubscriptions;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PurchaseItemsGetInput &&
            (identical(other.subscriptionTypes, subscriptionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionTypes, subscriptionTypes)) &&
            (identical(other.excludeCurrentSubscriptions,
                    excludeCurrentSubscriptions) ||
                const DeepCollectionEquality().equals(
                    other.excludeCurrentSubscriptions,
                    excludeCurrentSubscriptions)) &&
            (identical(other.excludeSubscriptions, excludeSubscriptions) ||
                const DeepCollectionEquality().equals(
                    other.excludeSubscriptions, excludeSubscriptions)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(subscriptionTypes) ^
        const DeepCollectionEquality().hash(excludeCurrentSubscriptions) ^
        const DeepCollectionEquality().hash(excludeSubscriptions) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'PurchaseItemsGetInput(${toJson()})';
}
