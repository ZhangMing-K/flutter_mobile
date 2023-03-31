import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class TagAnalysis {
  final String? symbol;
  final Asset? asset;
  final int? totalTags;
  final int? distinctUsers;
  final List<int>? userKeys;
  const TagAnalysis(
      {this.symbol,
      this.asset,
      this.totalTags,
      this.distinctUsers,
      this.userKeys});
  TagAnalysis copyWith(
      {String? symbol,
      Asset? asset,
      int? totalTags,
      int? distinctUsers,
      List<int>? userKeys}) {
    return TagAnalysis(
      symbol: symbol ?? this.symbol,
      asset: asset ?? this.asset,
      totalTags: totalTags ?? this.totalTags,
      distinctUsers: distinctUsers ?? this.distinctUsers,
      userKeys: userKeys ?? this.userKeys,
    );
  }

  factory TagAnalysis.fromJson(Map<String, dynamic> json) {
    return TagAnalysis(
      symbol: json['symbol'],
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      totalTags: json['totalTags'],
      distinctUsers: json['distinctUsers'],
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['asset'] = asset?.toJson();
    data['totalTags'] = totalTags;
    data['distinctUsers'] = distinctUsers;
    data['userKeys'] = userKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TagAnalysis &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.totalTags, totalTags) ||
                const DeepCollectionEquality()
                    .equals(other.totalTags, totalTags)) &&
            (identical(other.distinctUsers, distinctUsers) ||
                const DeepCollectionEquality()
                    .equals(other.distinctUsers, distinctUsers)) &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(totalTags) ^
        const DeepCollectionEquality().hash(distinctUsers) ^
        const DeepCollectionEquality().hash(userKeys);
  }

  @override
  String toString() => 'TagAnalysis(${toJson()})';
}
