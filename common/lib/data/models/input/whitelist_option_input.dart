import 'package:collection/collection.dart';

class WhitelistOptionInput {
  final List<int>? whitelistedAssetKeys;
  final bool? addToList;
  final bool? setToDefault;
  const WhitelistOptionInput(
      {this.whitelistedAssetKeys, this.addToList, this.setToDefault});
  WhitelistOptionInput copyWith(
      {List<int>? whitelistedAssetKeys, bool? addToList, bool? setToDefault}) {
    return WhitelistOptionInput(
      whitelistedAssetKeys: whitelistedAssetKeys ?? this.whitelistedAssetKeys,
      addToList: addToList ?? this.addToList,
      setToDefault: setToDefault ?? this.setToDefault,
    );
  }

  factory WhitelistOptionInput.fromJson(Map<String, dynamic> json) {
    return WhitelistOptionInput(
      whitelistedAssetKeys:
          json['whitelistedAssetKeys']?.map<int>((o) => (o as int)).toList(),
      addToList: json['addToList'],
      setToDefault: json['setToDefault'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['whitelistedAssetKeys'] = whitelistedAssetKeys;
    data['addToList'] = addToList;
    data['setToDefault'] = setToDefault;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WhitelistOptionInput &&
            (identical(other.whitelistedAssetKeys, whitelistedAssetKeys) ||
                const DeepCollectionEquality().equals(
                    other.whitelistedAssetKeys, whitelistedAssetKeys)) &&
            (identical(other.addToList, addToList) ||
                const DeepCollectionEquality()
                    .equals(other.addToList, addToList)) &&
            (identical(other.setToDefault, setToDefault) ||
                const DeepCollectionEquality()
                    .equals(other.setToDefault, setToDefault)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(whitelistedAssetKeys) ^
        const DeepCollectionEquality().hash(addToList) ^
        const DeepCollectionEquality().hash(setToDefault);
  }

  @override
  String toString() => 'WhitelistOptionInput(${toJson()})';
}
