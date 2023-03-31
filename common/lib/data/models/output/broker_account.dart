import 'package:collection/collection.dart';

class BrokerAccount {
  final String? accountId;
  final String? cash;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const BrokerAccount(
      {this.accountId, this.cash, this.createdAt, this.updatedAt});
  BrokerAccount copyWith(
      {String? accountId,
      String? cash,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return BrokerAccount(
      accountId: accountId ?? this.accountId,
      cash: cash ?? this.cash,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory BrokerAccount.fromJson(Map<String, dynamic> json) {
    return BrokerAccount(
      accountId: json['accountId'],
      cash: json['cash'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['cash'] = cash;
    data['createdAt'] = createdAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BrokerAccount &&
            (identical(other.accountId, accountId) ||
                const DeepCollectionEquality()
                    .equals(other.accountId, accountId)) &&
            (identical(other.cash, cash) ||
                const DeepCollectionEquality().equals(other.cash, cash)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(accountId) ^
        const DeepCollectionEquality().hash(cash) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(updatedAt);
  }

  @override
  String toString() => 'BrokerAccount(${toJson()})';
}
