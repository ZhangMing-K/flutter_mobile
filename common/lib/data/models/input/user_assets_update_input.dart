import 'package:collection/collection.dart';

class UserAssetsUpdateInput {
  final List<int>? assetKeys;
  final bool? watch;
  final bool? blacklist;
  const UserAssetsUpdateInput({this.assetKeys, this.watch, this.blacklist});
  UserAssetsUpdateInput copyWith(
      {List<int>? assetKeys, bool? watch, bool? blacklist}) {
    return UserAssetsUpdateInput(
      assetKeys: assetKeys ?? this.assetKeys,
      watch: watch ?? this.watch,
      blacklist: blacklist ?? this.blacklist,
    );
  }

  factory UserAssetsUpdateInput.fromJson(Map<String, dynamic> json) {
    return UserAssetsUpdateInput(
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      watch: json['watch'],
      blacklist: json['blacklist'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['assetKeys'] = assetKeys;
    data['watch'] = watch;
    data['blacklist'] = blacklist;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserAssetsUpdateInput &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.watch, watch) ||
                const DeepCollectionEquality().equals(other.watch, watch)) &&
            (identical(other.blacklist, blacklist) ||
                const DeepCollectionEquality()
                    .equals(other.blacklist, blacklist)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(watch) ^
        const DeepCollectionEquality().hash(blacklist);
  }

  @override
  String toString() => 'UserAssetsUpdateInput(${toJson()})';
}
