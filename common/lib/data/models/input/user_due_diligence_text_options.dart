import 'package:iris_common/data/models/enums/term.dart';
import 'package:collection/collection.dart';

class UserDueDiligenceTextOptions {
  final List<int>? assetKeys;
  final List<int>? userKeys;
  final List<TERM>? terms;
  final List<int>? riskRatings;
  final bool? heldByUser;
  final bool? active;
  final bool? lastUpdatedDDOnly;
  const UserDueDiligenceTextOptions(
      {this.assetKeys,
      this.userKeys,
      this.terms,
      this.riskRatings,
      this.heldByUser,
      this.active,
      this.lastUpdatedDDOnly});
  UserDueDiligenceTextOptions copyWith(
      {List<int>? assetKeys,
      List<int>? userKeys,
      List<TERM>? terms,
      List<int>? riskRatings,
      bool? heldByUser,
      bool? active,
      bool? lastUpdatedDDOnly}) {
    return UserDueDiligenceTextOptions(
      assetKeys: assetKeys ?? this.assetKeys,
      userKeys: userKeys ?? this.userKeys,
      terms: terms ?? this.terms,
      riskRatings: riskRatings ?? this.riskRatings,
      heldByUser: heldByUser ?? this.heldByUser,
      active: active ?? this.active,
      lastUpdatedDDOnly: lastUpdatedDDOnly ?? this.lastUpdatedDDOnly,
    );
  }

  factory UserDueDiligenceTextOptions.fromJson(Map<String, dynamic> json) {
    return UserDueDiligenceTextOptions(
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      terms: json['terms']?.map<TERM>((o) => TERM.values.byName(o)).toList(),
      riskRatings: json['riskRatings']?.map<int>((o) => (o as int)).toList(),
      heldByUser: json['heldByUser'],
      active: json['active'],
      lastUpdatedDDOnly: json['lastUpdatedDDOnly'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['assetKeys'] = assetKeys;
    data['userKeys'] = userKeys;
    data['terms'] = terms?.map((item) => item.name).toList();
    data['riskRatings'] = riskRatings;
    data['heldByUser'] = heldByUser;
    data['active'] = active;
    data['lastUpdatedDDOnly'] = lastUpdatedDDOnly;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserDueDiligenceTextOptions &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.terms, terms) ||
                const DeepCollectionEquality().equals(other.terms, terms)) &&
            (identical(other.riskRatings, riskRatings) ||
                const DeepCollectionEquality()
                    .equals(other.riskRatings, riskRatings)) &&
            (identical(other.heldByUser, heldByUser) ||
                const DeepCollectionEquality()
                    .equals(other.heldByUser, heldByUser)) &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)) &&
            (identical(other.lastUpdatedDDOnly, lastUpdatedDDOnly) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdatedDDOnly, lastUpdatedDDOnly)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(terms) ^
        const DeepCollectionEquality().hash(riskRatings) ^
        const DeepCollectionEquality().hash(heldByUser) ^
        const DeepCollectionEquality().hash(active) ^
        const DeepCollectionEquality().hash(lastUpdatedDDOnly);
  }

  @override
  String toString() => 'UserDueDiligenceTextOptions(${toJson()})';
}
