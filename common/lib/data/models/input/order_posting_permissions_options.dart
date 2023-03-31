import 'package:iris_common/data/models/enums/order_posting_permissions.dart';
import 'package:collection/collection.dart';

class OrderPostingPermissionsOptions {
  final ORDER_POSTING_PERMISSIONS? orderPostingPermission;
  final bool? setDefault;
  const OrderPostingPermissionsOptions(
      {this.orderPostingPermission, this.setDefault});
  OrderPostingPermissionsOptions copyWith(
      {ORDER_POSTING_PERMISSIONS? orderPostingPermission, bool? setDefault}) {
    return OrderPostingPermissionsOptions(
      orderPostingPermission:
          orderPostingPermission ?? this.orderPostingPermission,
      setDefault: setDefault ?? this.setDefault,
    );
  }

  factory OrderPostingPermissionsOptions.fromJson(Map<String, dynamic> json) {
    return OrderPostingPermissionsOptions(
      orderPostingPermission: json['orderPostingPermission'] != null
          ? ORDER_POSTING_PERMISSIONS.values
              .byName(json['orderPostingPermission'])
          : null,
      setDefault: json['setDefault'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['orderPostingPermission'] = orderPostingPermission?.name;
    data['setDefault'] = setDefault;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OrderPostingPermissionsOptions &&
            (identical(other.orderPostingPermission, orderPostingPermission) ||
                const DeepCollectionEquality().equals(
                    other.orderPostingPermission, orderPostingPermission)) &&
            (identical(other.setDefault, setDefault) ||
                const DeepCollectionEquality()
                    .equals(other.setDefault, setDefault)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(orderPostingPermission) ^
        const DeepCollectionEquality().hash(setDefault);
  }

  @override
  String toString() => 'OrderPostingPermissionsOptions(${toJson()})';
}
