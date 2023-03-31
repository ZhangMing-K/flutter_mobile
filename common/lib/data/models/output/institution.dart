import 'package:iris_common/data/models/enums/institution_name.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/institution_account.dart';
import 'package:collection/collection.dart';

class Institution {
  final int? institutionKey;
  final INSTITUTION_NAME? institutionName;
  final User? user;
  final int? userKey;
  final List<Portfolio>? portfolios;
  final DateTime? createdAt;
  final List<InstitutionAccount>? institutionAccounts;
  const Institution(
      {this.institutionKey,
      this.institutionName,
      this.user,
      this.userKey,
      this.portfolios,
      this.createdAt,
      this.institutionAccounts});
  Institution copyWith(
      {int? institutionKey,
      INSTITUTION_NAME? institutionName,
      User? user,
      int? userKey,
      List<Portfolio>? portfolios,
      DateTime? createdAt,
      List<InstitutionAccount>? institutionAccounts}) {
    return Institution(
      institutionKey: institutionKey ?? this.institutionKey,
      institutionName: institutionName ?? this.institutionName,
      user: user ?? this.user,
      userKey: userKey ?? this.userKey,
      portfolios: portfolios ?? this.portfolios,
      createdAt: createdAt ?? this.createdAt,
      institutionAccounts: institutionAccounts ?? this.institutionAccounts,
    );
  }

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      institutionKey: json['institutionKey'],
      institutionName: json['institutionName'] != null
          ? INSTITUTION_NAME.values.byName(json['institutionName'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      userKey: json['userKey'],
      portfolios: json['portfolios']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      institutionAccounts: json['institutionAccounts']
          ?.map<InstitutionAccount>((o) => InstitutionAccount.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['institutionKey'] = institutionKey;
    data['institutionName'] = institutionName?.name;
    data['user'] = user?.toJson();
    data['userKey'] = userKey;
    data['portfolios'] = portfolios?.map((item) => item.toJson()).toList();
    data['createdAt'] = createdAt?.toString();
    data['institutionAccounts'] =
        institutionAccounts?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Institution &&
            (identical(other.institutionKey, institutionKey) ||
                const DeepCollectionEquality()
                    .equals(other.institutionKey, institutionKey)) &&
            (identical(other.institutionName, institutionName) ||
                const DeepCollectionEquality()
                    .equals(other.institutionName, institutionName)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.portfolios, portfolios) ||
                const DeepCollectionEquality()
                    .equals(other.portfolios, portfolios)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.institutionAccounts, institutionAccounts) ||
                const DeepCollectionEquality()
                    .equals(other.institutionAccounts, institutionAccounts)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(institutionKey) ^
        const DeepCollectionEquality().hash(institutionName) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(portfolios) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(institutionAccounts);
  }

  @override
  String toString() => 'Institution(${toJson()})';
}
