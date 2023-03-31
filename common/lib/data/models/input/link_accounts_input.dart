import 'package:collection/collection.dart';

class LinkAccountsInput {
  final int? portfolioKey;
  final List<String>? accountIds;
  const LinkAccountsInput(
      {required this.portfolioKey, required this.accountIds});
  LinkAccountsInput copyWith({int? portfolioKey, List<String>? accountIds}) {
    return LinkAccountsInput(
      portfolioKey: portfolioKey ?? this.portfolioKey,
      accountIds: accountIds ?? this.accountIds,
    );
  }

  factory LinkAccountsInput.fromJson(Map<String, dynamic> json) {
    return LinkAccountsInput(
      portfolioKey: json['portfolioKey'],
      accountIds: json['accountIds']?.map<String>((o) => o.toString()).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioKey'] = portfolioKey;
    data['accountIds'] = accountIds;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LinkAccountsInput &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.accountIds, accountIds) ||
                const DeepCollectionEquality()
                    .equals(other.accountIds, accountIds)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(accountIds);
  }

  @override
  String toString() => 'LinkAccountsInput(${toJson()})';
}
