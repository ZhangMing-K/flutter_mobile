import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class UserAsset {
  final int? userAssetKey;
  final int? userKey;
  final int? assetKey;
  final DateTime? watchedAt;
  final DateTime? blacklistedAt;
  final DateTime? createdAt;
  final User? user;
  final Asset? asset;
  const UserAsset(
      {this.userAssetKey,
      this.userKey,
      this.assetKey,
      this.watchedAt,
      this.blacklistedAt,
      this.createdAt,
      this.user,
      this.asset});
  UserAsset copyWith(
      {int? userAssetKey,
      int? userKey,
      int? assetKey,
      DateTime? watchedAt,
      DateTime? blacklistedAt,
      DateTime? createdAt,
      User? user,
      Asset? asset}) {
    return UserAsset(
      userAssetKey: userAssetKey ?? this.userAssetKey,
      userKey: userKey ?? this.userKey,
      assetKey: assetKey ?? this.assetKey,
      watchedAt: watchedAt ?? this.watchedAt,
      blacklistedAt: blacklistedAt ?? this.blacklistedAt,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
      asset: asset ?? this.asset,
    );
  }

  factory UserAsset.fromJson(Map<String, dynamic> json) {
    return UserAsset(
      userAssetKey: json['userAssetKey'],
      userKey: json['userKey'],
      assetKey: json['assetKey'],
      watchedAt:
          json['watchedAt'] != null ? DateTime.parse(json['watchedAt']) : null,
      blacklistedAt: json['blacklistedAt'] != null
          ? DateTime.parse(json['blacklistedAt'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userAssetKey'] = userAssetKey;
    data['userKey'] = userKey;
    data['assetKey'] = assetKey;
    data['watchedAt'] = watchedAt?.toString();
    data['blacklistedAt'] = blacklistedAt?.toString();
    data['createdAt'] = createdAt?.toString();
    data['user'] = user?.toJson();
    data['asset'] = asset?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserAsset &&
            (identical(other.userAssetKey, userAssetKey) ||
                const DeepCollectionEquality()
                    .equals(other.userAssetKey, userAssetKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.watchedAt, watchedAt) ||
                const DeepCollectionEquality()
                    .equals(other.watchedAt, watchedAt)) &&
            (identical(other.blacklistedAt, blacklistedAt) ||
                const DeepCollectionEquality()
                    .equals(other.blacklistedAt, blacklistedAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userAssetKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(watchedAt) ^
        const DeepCollectionEquality().hash(blacklistedAt) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(asset);
  }

  @override
  String toString() => 'UserAsset(${toJson()})';
}
