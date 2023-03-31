import 'package:iris_common/data/models/output/institution_account.dart';
import 'package:collection/collection.dart';

class InstitutionAddAccountsResponse {
  final List<InstitutionAccount>? institutionAccounts;
  const InstitutionAddAccountsResponse({this.institutionAccounts});
  InstitutionAddAccountsResponse copyWith(
      {List<InstitutionAccount>? institutionAccounts}) {
    return InstitutionAddAccountsResponse(
      institutionAccounts: institutionAccounts ?? this.institutionAccounts,
    );
  }

  factory InstitutionAddAccountsResponse.fromJson(Map<String, dynamic> json) {
    return InstitutionAddAccountsResponse(
      institutionAccounts: json['institutionAccounts']
          ?.map<InstitutionAccount>((o) => InstitutionAccount.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['institutionAccounts'] =
        institutionAccounts?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InstitutionAddAccountsResponse &&
            (identical(other.institutionAccounts, institutionAccounts) ||
                const DeepCollectionEquality()
                    .equals(other.institutionAccounts, institutionAccounts)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(institutionAccounts);
  }

  @override
  String toString() => 'InstitutionAddAccountsResponse(${toJson()})';
}
