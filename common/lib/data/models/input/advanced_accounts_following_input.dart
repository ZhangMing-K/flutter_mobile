import 'package:iris_common/data/models/enums/advanced_accounts_following_order_by.dart';
import 'package:collection/collection.dart';

class AdvancedAccountsFollowingInput {
  final String? name;
  final int? limit;
  final int? offset;
  final ADVANCED_ACCOUNTS_FOLLOWING_ORDER_BY? orderBy;
  const AdvancedAccountsFollowingInput(
      {this.name, this.limit, this.offset, this.orderBy});
  AdvancedAccountsFollowingInput copyWith(
      {String? name,
      int? limit,
      int? offset,
      ADVANCED_ACCOUNTS_FOLLOWING_ORDER_BY? orderBy}) {
    return AdvancedAccountsFollowingInput(
      name: name ?? this.name,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      orderBy: orderBy ?? this.orderBy,
    );
  }

  factory AdvancedAccountsFollowingInput.fromJson(Map<String, dynamic> json) {
    return AdvancedAccountsFollowingInput(
      name: json['name'],
      limit: json['limit'],
      offset: json['offset'],
      orderBy: json['orderBy'] != null
          ? ADVANCED_ACCOUNTS_FOLLOWING_ORDER_BY.values.byName(json['orderBy'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['limit'] = limit;
    data['offset'] = offset;
    data['orderBy'] = orderBy?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdvancedAccountsFollowingInput &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality().equals(other.orderBy, orderBy)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(orderBy);
  }

  @override
  String toString() => 'AdvancedAccountsFollowingInput(${toJson()})';
}
