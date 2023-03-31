import 'package:iris_common/data/models/enums/institution_name.dart';
import 'package:iris_common/data/models/enums/institution_connected_from.dart';
import 'package:collection/collection.dart';

class InstitutionConnectInput {
  final INSTITUTION_NAME? institutionName;
  final String? username;
  final String? password;
  final String? oauthKey;
  final int? institutionKey;
  final int? portfolioKey;
  final INSTITUTION_CONNECTED_FROM? connectedFrom;
  final bool? autoAddAllAccounts;
  const InstitutionConnectInput(
      {required this.institutionName,
      required this.username,
      required this.password,
      this.oauthKey,
      this.institutionKey,
      this.portfolioKey,
      this.connectedFrom,
      this.autoAddAllAccounts});
  InstitutionConnectInput copyWith(
      {INSTITUTION_NAME? institutionName,
      String? username,
      String? password,
      String? oauthKey,
      int? institutionKey,
      int? portfolioKey,
      INSTITUTION_CONNECTED_FROM? connectedFrom,
      bool? autoAddAllAccounts}) {
    return InstitutionConnectInput(
      institutionName: institutionName ?? this.institutionName,
      username: username ?? this.username,
      password: password ?? this.password,
      oauthKey: oauthKey ?? this.oauthKey,
      institutionKey: institutionKey ?? this.institutionKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      connectedFrom: connectedFrom ?? this.connectedFrom,
      autoAddAllAccounts: autoAddAllAccounts ?? this.autoAddAllAccounts,
    );
  }

  factory InstitutionConnectInput.fromJson(Map<String, dynamic> json) {
    return InstitutionConnectInput(
      institutionName: json['institutionName'] != null
          ? INSTITUTION_NAME.values.byName(json['institutionName'])
          : null,
      username: json['username'],
      password: json['password'],
      oauthKey: json['oauthKey'],
      institutionKey: json['institutionKey'],
      portfolioKey: json['portfolioKey'],
      connectedFrom: json['connectedFrom'] != null
          ? INSTITUTION_CONNECTED_FROM.values.byName(json['connectedFrom'])
          : null,
      autoAddAllAccounts: json['autoAddAllAccounts'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['institutionName'] = institutionName?.name;
    data['username'] = username;
    data['password'] = password;
    data['oauthKey'] = oauthKey;
    data['institutionKey'] = institutionKey;
    data['portfolioKey'] = portfolioKey;
    data['connectedFrom'] = connectedFrom?.name;
    data['autoAddAllAccounts'] = autoAddAllAccounts;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InstitutionConnectInput &&
            (identical(other.institutionName, institutionName) ||
                const DeepCollectionEquality()
                    .equals(other.institutionName, institutionName)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.oauthKey, oauthKey) ||
                const DeepCollectionEquality()
                    .equals(other.oauthKey, oauthKey)) &&
            (identical(other.institutionKey, institutionKey) ||
                const DeepCollectionEquality()
                    .equals(other.institutionKey, institutionKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.connectedFrom, connectedFrom) ||
                const DeepCollectionEquality()
                    .equals(other.connectedFrom, connectedFrom)) &&
            (identical(other.autoAddAllAccounts, autoAddAllAccounts) ||
                const DeepCollectionEquality()
                    .equals(other.autoAddAllAccounts, autoAddAllAccounts)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(institutionName) ^
        const DeepCollectionEquality().hash(username) ^
        const DeepCollectionEquality().hash(password) ^
        const DeepCollectionEquality().hash(oauthKey) ^
        const DeepCollectionEquality().hash(institutionKey) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(connectedFrom) ^
        const DeepCollectionEquality().hash(autoAddAllAccounts);
  }

  @override
  String toString() => 'InstitutionConnectInput(${toJson()})';
}
