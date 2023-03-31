import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class InstitutionAccount {
  final Portfolio? portfolio;
  final String? accountId;
  final bool? isBrokerage;
  final String? name;
  const InstitutionAccount(
      {this.portfolio, this.accountId, this.isBrokerage, this.name});
  InstitutionAccount copyWith(
      {Portfolio? portfolio,
      String? accountId,
      bool? isBrokerage,
      String? name}) {
    return InstitutionAccount(
      portfolio: portfolio ?? this.portfolio,
      accountId: accountId ?? this.accountId,
      isBrokerage: isBrokerage ?? this.isBrokerage,
      name: name ?? this.name,
    );
  }

  factory InstitutionAccount.fromJson(Map<String, dynamic> json) {
    return InstitutionAccount(
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      accountId: json['accountId'],
      isBrokerage: json['isBrokerage'],
      name: json['name'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolio'] = portfolio?.toJson();
    data['accountId'] = accountId;
    data['isBrokerage'] = isBrokerage;
    data['name'] = name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InstitutionAccount &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.accountId, accountId) ||
                const DeepCollectionEquality()
                    .equals(other.accountId, accountId)) &&
            (identical(other.isBrokerage, isBrokerage) ||
                const DeepCollectionEquality()
                    .equals(other.isBrokerage, isBrokerage)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(accountId) ^
        const DeepCollectionEquality().hash(isBrokerage) ^
        const DeepCollectionEquality().hash(name);
  }

  @override
  String toString() => 'InstitutionAccount(${toJson()})';
}
