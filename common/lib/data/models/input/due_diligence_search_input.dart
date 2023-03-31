import 'package:iris_common/data/models/enums/term.dart';
import 'package:collection/collection.dart';

class DueDiligenceSearchInput {
  final List<int>? assetKeys;
  final List<int>? userKeys;
  final List<int>? dueDiligenceKeys;
  final List<TERM>? terms;
  final List<int>? riskRatings;
  final bool? heldByUser;
  final bool? active;
  final bool? lastUpdatedDDOnly;
  final int? limit;
  final int? offset;
  const DueDiligenceSearchInput(
      {this.assetKeys,
      this.userKeys,
      this.dueDiligenceKeys,
      this.terms,
      this.riskRatings,
      this.heldByUser,
      this.active,
      this.lastUpdatedDDOnly,
      required this.limit,
      required this.offset});
  DueDiligenceSearchInput copyWith(
      {List<int>? assetKeys,
      List<int>? userKeys,
      List<int>? dueDiligenceKeys,
      List<TERM>? terms,
      List<int>? riskRatings,
      bool? heldByUser,
      bool? active,
      bool? lastUpdatedDDOnly,
      int? limit,
      int? offset}) {
    return DueDiligenceSearchInput(
      assetKeys: assetKeys ?? this.assetKeys,
      userKeys: userKeys ?? this.userKeys,
      dueDiligenceKeys: dueDiligenceKeys ?? this.dueDiligenceKeys,
      terms: terms ?? this.terms,
      riskRatings: riskRatings ?? this.riskRatings,
      heldByUser: heldByUser ?? this.heldByUser,
      active: active ?? this.active,
      lastUpdatedDDOnly: lastUpdatedDDOnly ?? this.lastUpdatedDDOnly,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory DueDiligenceSearchInput.fromJson(Map<String, dynamic> json) {
    return DueDiligenceSearchInput(
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      dueDiligenceKeys:
          json['dueDiligenceKeys']?.map<int>((o) => (o as int)).toList(),
      terms: json['terms']?.map<TERM>((o) => TERM.values.byName(o)).toList(),
      riskRatings: json['riskRatings']?.map<int>((o) => (o as int)).toList(),
      heldByUser: json['heldByUser'],
      active: json['active'],
      lastUpdatedDDOnly: json['lastUpdatedDDOnly'],
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['assetKeys'] = assetKeys;
    data['userKeys'] = userKeys;
    data['dueDiligenceKeys'] = dueDiligenceKeys;
    data['terms'] = terms?.map((item) => item.name).toList();
    data['riskRatings'] = riskRatings;
    data['heldByUser'] = heldByUser;
    data['active'] = active;
    data['lastUpdatedDDOnly'] = lastUpdatedDDOnly;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligenceSearchInput &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.dueDiligenceKeys, dueDiligenceKeys) ||
                const DeepCollectionEquality()
                    .equals(other.dueDiligenceKeys, dueDiligenceKeys)) &&
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
                    .equals(other.lastUpdatedDDOnly, lastUpdatedDDOnly)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(dueDiligenceKeys) ^
        const DeepCollectionEquality().hash(terms) ^
        const DeepCollectionEquality().hash(riskRatings) ^
        const DeepCollectionEquality().hash(heldByUser) ^
        const DeepCollectionEquality().hash(active) ^
        const DeepCollectionEquality().hash(lastUpdatedDDOnly) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'DueDiligenceSearchInput(${toJson()})';
}
