import 'package:collection/collection.dart';

class InstitutionAddAccountsInput {
  final int? institutionKey;
  final List<String>? accountIds;
  const InstitutionAddAccountsInput(
      {required this.institutionKey, required this.accountIds});
  InstitutionAddAccountsInput copyWith(
      {int? institutionKey, List<String>? accountIds}) {
    return InstitutionAddAccountsInput(
      institutionKey: institutionKey ?? this.institutionKey,
      accountIds: accountIds ?? this.accountIds,
    );
  }

  factory InstitutionAddAccountsInput.fromJson(Map<String, dynamic> json) {
    return InstitutionAddAccountsInput(
      institutionKey: json['institutionKey'],
      accountIds: json['accountIds']?.map<String>((o) => o.toString()).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['institutionKey'] = institutionKey;
    data['accountIds'] = accountIds;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InstitutionAddAccountsInput &&
            (identical(other.institutionKey, institutionKey) ||
                const DeepCollectionEquality()
                    .equals(other.institutionKey, institutionKey)) &&
            (identical(other.accountIds, accountIds) ||
                const DeepCollectionEquality()
                    .equals(other.accountIds, accountIds)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(institutionKey) ^
        const DeepCollectionEquality().hash(accountIds);
  }

  @override
  String toString() => 'InstitutionAddAccountsInput(${toJson()})';
}
