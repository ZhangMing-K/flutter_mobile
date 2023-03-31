import 'package:iris_common/data/models/enums/subscription_type.dart';
import 'package:collection/collection.dart';

class PurchaseItemCreateInput {
  final int? profileUserKey;
  final SUBSCRIPTION_TYPE? subscriptionType;
  final String? name;
  final String? description;
  final double? applicationFeePercent;
  final double? cost;
  final double? dayCost;
  final double? threeMonthCost;
  final double? yearCost;
  const PurchaseItemCreateInput(
      {this.profileUserKey,
      this.subscriptionType,
      this.name,
      this.description,
      this.applicationFeePercent,
      this.cost,
      this.dayCost,
      this.threeMonthCost,
      this.yearCost});
  PurchaseItemCreateInput copyWith(
      {int? profileUserKey,
      SUBSCRIPTION_TYPE? subscriptionType,
      String? name,
      String? description,
      double? applicationFeePercent,
      double? cost,
      double? dayCost,
      double? threeMonthCost,
      double? yearCost}) {
    return PurchaseItemCreateInput(
      profileUserKey: profileUserKey ?? this.profileUserKey,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      name: name ?? this.name,
      description: description ?? this.description,
      applicationFeePercent:
          applicationFeePercent ?? this.applicationFeePercent,
      cost: cost ?? this.cost,
      dayCost: dayCost ?? this.dayCost,
      threeMonthCost: threeMonthCost ?? this.threeMonthCost,
      yearCost: yearCost ?? this.yearCost,
    );
  }

  factory PurchaseItemCreateInput.fromJson(Map<String, dynamic> json) {
    return PurchaseItemCreateInput(
      profileUserKey: json['profileUserKey'],
      subscriptionType: json['subscriptionType'] != null
          ? SUBSCRIPTION_TYPE.values.byName(json['subscriptionType'])
          : null,
      name: json['name'],
      description: json['description'],
      applicationFeePercent: json['applicationFeePercent']?.toDouble(),
      cost: json['cost']?.toDouble(),
      dayCost: json['dayCost']?.toDouble(),
      threeMonthCost: json['threeMonthCost']?.toDouble(),
      yearCost: json['yearCost']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['profileUserKey'] = profileUserKey;
    data['subscriptionType'] = subscriptionType?.name;
    data['name'] = name;
    data['description'] = description;
    data['applicationFeePercent'] = applicationFeePercent;
    data['cost'] = cost;
    data['dayCost'] = dayCost;
    data['threeMonthCost'] = threeMonthCost;
    data['yearCost'] = yearCost;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PurchaseItemCreateInput &&
            (identical(other.profileUserKey, profileUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.profileUserKey, profileUserKey)) &&
            (identical(other.subscriptionType, subscriptionType) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionType, subscriptionType)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.applicationFeePercent, applicationFeePercent) ||
                const DeepCollectionEquality().equals(
                    other.applicationFeePercent, applicationFeePercent)) &&
            (identical(other.cost, cost) ||
                const DeepCollectionEquality().equals(other.cost, cost)) &&
            (identical(other.dayCost, dayCost) ||
                const DeepCollectionEquality()
                    .equals(other.dayCost, dayCost)) &&
            (identical(other.threeMonthCost, threeMonthCost) ||
                const DeepCollectionEquality()
                    .equals(other.threeMonthCost, threeMonthCost)) &&
            (identical(other.yearCost, yearCost) ||
                const DeepCollectionEquality()
                    .equals(other.yearCost, yearCost)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(profileUserKey) ^
        const DeepCollectionEquality().hash(subscriptionType) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(applicationFeePercent) ^
        const DeepCollectionEquality().hash(cost) ^
        const DeepCollectionEquality().hash(dayCost) ^
        const DeepCollectionEquality().hash(threeMonthCost) ^
        const DeepCollectionEquality().hash(yearCost);
  }

  @override
  String toString() => 'PurchaseItemCreateInput(${toJson()})';
}
