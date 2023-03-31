import 'package:collection/collection.dart';

class CouponConnection {
  final double? price;
  final bool? isAuthUserCouponEligible;
  const CouponConnection({this.price, this.isAuthUserCouponEligible});
  CouponConnection copyWith({double? price, bool? isAuthUserCouponEligible}) {
    return CouponConnection(
      price: price ?? this.price,
      isAuthUserCouponEligible:
          isAuthUserCouponEligible ?? this.isAuthUserCouponEligible,
    );
  }

  factory CouponConnection.fromJson(Map<String, dynamic> json) {
    return CouponConnection(
      price: json['price']?.toDouble(),
      isAuthUserCouponEligible: json['isAuthUserCouponEligible'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['price'] = price;
    data['isAuthUserCouponEligible'] = isAuthUserCouponEligible;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CouponConnection &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(
                    other.isAuthUserCouponEligible, isAuthUserCouponEligible) ||
                const DeepCollectionEquality().equals(
                    other.isAuthUserCouponEligible, isAuthUserCouponEligible)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(price) ^
        const DeepCollectionEquality().hash(isAuthUserCouponEligible);
  }

  @override
  String toString() => 'CouponConnection(${toJson()})';
}
