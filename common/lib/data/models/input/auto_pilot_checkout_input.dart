import 'package:collection/collection.dart';

class AutoPilotCheckoutInput {
  final int? purchaseItemPriceKey;
  final bool? autoRenew;
  final int? nbrTrialPeriodDays;
  final bool? useDefaultPaymentMethodIfAble;
  const AutoPilotCheckoutInput(
      {required this.purchaseItemPriceKey,
      this.autoRenew,
      this.nbrTrialPeriodDays,
      this.useDefaultPaymentMethodIfAble});
  AutoPilotCheckoutInput copyWith(
      {int? purchaseItemPriceKey,
      bool? autoRenew,
      int? nbrTrialPeriodDays,
      bool? useDefaultPaymentMethodIfAble}) {
    return AutoPilotCheckoutInput(
      purchaseItemPriceKey: purchaseItemPriceKey ?? this.purchaseItemPriceKey,
      autoRenew: autoRenew ?? this.autoRenew,
      nbrTrialPeriodDays: nbrTrialPeriodDays ?? this.nbrTrialPeriodDays,
      useDefaultPaymentMethodIfAble:
          useDefaultPaymentMethodIfAble ?? this.useDefaultPaymentMethodIfAble,
    );
  }

  factory AutoPilotCheckoutInput.fromJson(Map<String, dynamic> json) {
    return AutoPilotCheckoutInput(
      purchaseItemPriceKey: json['purchaseItemPriceKey'],
      autoRenew: json['autoRenew'],
      nbrTrialPeriodDays: json['nbrTrialPeriodDays'],
      useDefaultPaymentMethodIfAble: json['useDefaultPaymentMethodIfAble'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['purchaseItemPriceKey'] = purchaseItemPriceKey;
    data['autoRenew'] = autoRenew;
    data['nbrTrialPeriodDays'] = nbrTrialPeriodDays;
    data['useDefaultPaymentMethodIfAble'] = useDefaultPaymentMethodIfAble;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotCheckoutInput &&
            (identical(other.purchaseItemPriceKey, purchaseItemPriceKey) ||
                const DeepCollectionEquality().equals(
                    other.purchaseItemPriceKey, purchaseItemPriceKey)) &&
            (identical(other.autoRenew, autoRenew) ||
                const DeepCollectionEquality()
                    .equals(other.autoRenew, autoRenew)) &&
            (identical(other.nbrTrialPeriodDays, nbrTrialPeriodDays) ||
                const DeepCollectionEquality()
                    .equals(other.nbrTrialPeriodDays, nbrTrialPeriodDays)) &&
            (identical(other.useDefaultPaymentMethodIfAble,
                    useDefaultPaymentMethodIfAble) ||
                const DeepCollectionEquality().equals(
                    other.useDefaultPaymentMethodIfAble,
                    useDefaultPaymentMethodIfAble)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(purchaseItemPriceKey) ^
        const DeepCollectionEquality().hash(autoRenew) ^
        const DeepCollectionEquality().hash(nbrTrialPeriodDays) ^
        const DeepCollectionEquality().hash(useDefaultPaymentMethodIfAble);
  }

  @override
  String toString() => 'AutoPilotCheckoutInput(${toJson()})';
}
