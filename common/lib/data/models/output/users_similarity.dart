import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/common_assets.dart';
import 'package:collection/collection.dart';

class UsersSimilarity {
  final List<int>? userKeys;
  final List<User>? users;
  final List<CommonAssets>? commonAssets;
  final double? assetSimilarityPercent;
  const UsersSimilarity(
      {this.userKeys,
      this.users,
      this.commonAssets,
      this.assetSimilarityPercent});
  UsersSimilarity copyWith(
      {List<int>? userKeys,
      List<User>? users,
      List<CommonAssets>? commonAssets,
      double? assetSimilarityPercent}) {
    return UsersSimilarity(
      userKeys: userKeys ?? this.userKeys,
      users: users ?? this.users,
      commonAssets: commonAssets ?? this.commonAssets,
      assetSimilarityPercent:
          assetSimilarityPercent ?? this.assetSimilarityPercent,
    );
  }

  factory UsersSimilarity.fromJson(Map<String, dynamic> json) {
    return UsersSimilarity(
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      users: json['users']?.map<User>((o) => User.fromJson(o)).toList(),
      commonAssets: json['commonAssets']
          ?.map<CommonAssets>((o) => CommonAssets.fromJson(o))
          .toList(),
      assetSimilarityPercent: json['assetSimilarityPercent']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKeys'] = userKeys;
    data['users'] = users?.map((item) => item.toJson()).toList();
    data['commonAssets'] = commonAssets?.map((item) => item.toJson()).toList();
    data['assetSimilarityPercent'] = assetSimilarityPercent;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UsersSimilarity &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)) &&
            (identical(other.commonAssets, commonAssets) ||
                const DeepCollectionEquality()
                    .equals(other.commonAssets, commonAssets)) &&
            (identical(other.assetSimilarityPercent, assetSimilarityPercent) ||
                const DeepCollectionEquality().equals(
                    other.assetSimilarityPercent, assetSimilarityPercent)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(users) ^
        const DeepCollectionEquality().hash(commonAssets) ^
        const DeepCollectionEquality().hash(assetSimilarityPercent);
  }

  @override
  String toString() => 'UsersSimilarity(${toJson()})';
}
