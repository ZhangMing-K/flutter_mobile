import 'package:collection/collection.dart';

class PurchaseItemCheckoutInput {
  final List<int>? purchaseItemPriceKeys;
  final bool? autoRenew;
  final int? nbrTrialPeriodDays;
  const PurchaseItemCheckoutInput(
      {required this.purchaseItemPriceKeys,
      this.autoRenew,
      this.nbrTrialPeriodDays});
  PurchaseItemCheckoutInput copyWith(
      {List<int>? purchaseItemPriceKeys,
      bool? autoRenew,
      int? nbrTrialPeriodDays}) {
    return PurchaseItemCheckoutInput(
      purchaseItemPriceKeys:
          purchaseItemPriceKeys ?? this.purchaseItemPriceKeys,
      autoRenew: autoRenew ?? this.autoRenew,
      nbrTrialPeriodDays: nbrTrialPeriodDays ?? this.nbrTrialPeriodDays,
    );
  }

  factory PurchaseItemCheckoutInput.fromJson(Map<String, dynamic> json) {
    return PurchaseItemCheckoutInput(
      purchaseItemPriceKeys:
          json['purchaseItemPriceKeys']?.map<int>((o) => (o as int)).toList(),
      autoRenew: json['autoRenew'],
      nbrTrialPeriodDays: json['nbrTrialPeriodDays'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['purchaseItemPriceKeys'] = purchaseItemPriceKeys;
    data['autoRenew'] = autoRenew;
    data['nbrTrialPeriodDays'] = nbrTrialPeriodDays;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PurchaseItemCheckoutInput &&
            (identical(other.purchaseItemPriceKeys, purchaseItemPriceKeys) ||
                const DeepCollectionEquality().equals(
                    other.purchaseItemPriceKeys, purchaseItemPriceKeys)) &&
            (identical(other.autoRenew, autoRenew) ||
                const DeepCollectionEquality()
                    .equals(other.autoRenew, autoRenew)) &&
            (identical(other.nbrTrialPeriodDays, nbrTrialPeriodDays) ||
                const DeepCollectionEquality()
                    .equals(other.nbrTrialPeriodDays, nbrTrialPeriodDays)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(purchaseItemPriceKeys) ^
        const DeepCollectionEquality().hash(autoRenew) ^
        const DeepCollectionEquality().hash(nbrTrialPeriodDays);
  }

  @override
  String toString() => 'PurchaseItemCheckoutInput(${toJson()})';
}
