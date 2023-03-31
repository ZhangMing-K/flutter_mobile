import 'package:iris_common/data/models/enums/term.dart';
import 'package:collection/collection.dart';

class UserDueDiligencesInput {
  final List<int>? assetKeys;
  final bool? active;
  final bool? lastUpdatedDDOnly;
  final List<TERM>? terms;
  final int? limit;
  final int? offset;
  const UserDueDiligencesInput(
      {this.assetKeys,
      this.active,
      this.lastUpdatedDDOnly,
      this.terms,
      required this.limit,
      required this.offset});
  UserDueDiligencesInput copyWith(
      {List<int>? assetKeys,
      bool? active,
      bool? lastUpdatedDDOnly,
      List<TERM>? terms,
      int? limit,
      int? offset}) {
    return UserDueDiligencesInput(
      assetKeys: assetKeys ?? this.assetKeys,
      active: active ?? this.active,
      lastUpdatedDDOnly: lastUpdatedDDOnly ?? this.lastUpdatedDDOnly,
      terms: terms ?? this.terms,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory UserDueDiligencesInput.fromJson(Map<String, dynamic> json) {
    return UserDueDiligencesInput(
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      active: json['active'],
      lastUpdatedDDOnly: json['lastUpdatedDDOnly'],
      terms: json['terms']?.map<TERM>((o) => TERM.values.byName(o)).toList(),
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['assetKeys'] = assetKeys;
    data['active'] = active;
    data['lastUpdatedDDOnly'] = lastUpdatedDDOnly;
    data['terms'] = terms?.map((item) => item.name).toList();
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserDueDiligencesInput &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)) &&
            (identical(other.lastUpdatedDDOnly, lastUpdatedDDOnly) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdatedDDOnly, lastUpdatedDDOnly)) &&
            (identical(other.terms, terms) ||
                const DeepCollectionEquality().equals(other.terms, terms)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(active) ^
        const DeepCollectionEquality().hash(lastUpdatedDDOnly) ^
        const DeepCollectionEquality().hash(terms) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'UserDueDiligencesInput(${toJson()})';
}
