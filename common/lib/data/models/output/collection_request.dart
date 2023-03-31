import 'package:iris_common/data/models/output/collection.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class CollectionRequest {
  final int? collectionRequestKey;
  final int? collectionKey;
  final Collection? collection;
  final int? userKey;
  final User? user;
  final int? portfolioKey;
  final Portfolio? portfolio;
  final int? assetKey;
  final Asset? asset;
  final DateTime? invitedAt;
  final User? invitedByUser;
  final DateTime? approvedAt;
  final User? approvedByUser;
  final DateTime? deniedAt;
  final User? deniedByUser;
  final DateTime? addedAt;
  final User? addedByUser;
  final DateTime? removedAt;
  final User? removedByUser;
  final DateTime? createdAt;
  const CollectionRequest(
      {this.collectionRequestKey,
      this.collectionKey,
      this.collection,
      this.userKey,
      this.user,
      this.portfolioKey,
      this.portfolio,
      this.assetKey,
      this.asset,
      this.invitedAt,
      this.invitedByUser,
      this.approvedAt,
      this.approvedByUser,
      this.deniedAt,
      this.deniedByUser,
      this.addedAt,
      this.addedByUser,
      this.removedAt,
      this.removedByUser,
      this.createdAt});
  CollectionRequest copyWith(
      {int? collectionRequestKey,
      int? collectionKey,
      Collection? collection,
      int? userKey,
      User? user,
      int? portfolioKey,
      Portfolio? portfolio,
      int? assetKey,
      Asset? asset,
      DateTime? invitedAt,
      User? invitedByUser,
      DateTime? approvedAt,
      User? approvedByUser,
      DateTime? deniedAt,
      User? deniedByUser,
      DateTime? addedAt,
      User? addedByUser,
      DateTime? removedAt,
      User? removedByUser,
      DateTime? createdAt}) {
    return CollectionRequest(
      collectionRequestKey: collectionRequestKey ?? this.collectionRequestKey,
      collectionKey: collectionKey ?? this.collectionKey,
      collection: collection ?? this.collection,
      userKey: userKey ?? this.userKey,
      user: user ?? this.user,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      portfolio: portfolio ?? this.portfolio,
      assetKey: assetKey ?? this.assetKey,
      asset: asset ?? this.asset,
      invitedAt: invitedAt ?? this.invitedAt,
      invitedByUser: invitedByUser ?? this.invitedByUser,
      approvedAt: approvedAt ?? this.approvedAt,
      approvedByUser: approvedByUser ?? this.approvedByUser,
      deniedAt: deniedAt ?? this.deniedAt,
      deniedByUser: deniedByUser ?? this.deniedByUser,
      addedAt: addedAt ?? this.addedAt,
      addedByUser: addedByUser ?? this.addedByUser,
      removedAt: removedAt ?? this.removedAt,
      removedByUser: removedByUser ?? this.removedByUser,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory CollectionRequest.fromJson(Map<String, dynamic> json) {
    return CollectionRequest(
      collectionRequestKey: json['collectionRequestKey'],
      collectionKey: json['collectionKey'],
      collection: json['collection'] != null
          ? Collection.fromJson(json['collection'])
          : null,
      userKey: json['userKey'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      portfolioKey: json['portfolioKey'],
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      assetKey: json['assetKey'],
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      invitedAt:
          json['invitedAt'] != null ? DateTime.parse(json['invitedAt']) : null,
      invitedByUser: json['invitedByUser'] != null
          ? User.fromJson(json['invitedByUser'])
          : null,
      approvedAt: json['approvedAt'] != null
          ? DateTime.parse(json['approvedAt'])
          : null,
      approvedByUser: json['approvedByUser'] != null
          ? User.fromJson(json['approvedByUser'])
          : null,
      deniedAt:
          json['deniedAt'] != null ? DateTime.parse(json['deniedAt']) : null,
      deniedByUser: json['deniedByUser'] != null
          ? User.fromJson(json['deniedByUser'])
          : null,
      addedAt: json['addedAt'] != null ? DateTime.parse(json['addedAt']) : null,
      addedByUser: json['addedByUser'] != null
          ? User.fromJson(json['addedByUser'])
          : null,
      removedAt:
          json['removedAt'] != null ? DateTime.parse(json['removedAt']) : null,
      removedByUser: json['removedByUser'] != null
          ? User.fromJson(json['removedByUser'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collectionRequestKey'] = collectionRequestKey;
    data['collectionKey'] = collectionKey;
    data['collection'] = collection?.toJson();
    data['userKey'] = userKey;
    data['user'] = user?.toJson();
    data['portfolioKey'] = portfolioKey;
    data['portfolio'] = portfolio?.toJson();
    data['assetKey'] = assetKey;
    data['asset'] = asset?.toJson();
    data['invitedAt'] = invitedAt?.toString();
    data['invitedByUser'] = invitedByUser?.toJson();
    data['approvedAt'] = approvedAt?.toString();
    data['approvedByUser'] = approvedByUser?.toJson();
    data['deniedAt'] = deniedAt?.toString();
    data['deniedByUser'] = deniedByUser?.toJson();
    data['addedAt'] = addedAt?.toString();
    data['addedByUser'] = addedByUser?.toJson();
    data['removedAt'] = removedAt?.toString();
    data['removedByUser'] = removedByUser?.toJson();
    data['createdAt'] = createdAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionRequest &&
            (identical(other.collectionRequestKey, collectionRequestKey) ||
                const DeepCollectionEquality().equals(
                    other.collectionRequestKey, collectionRequestKey)) &&
            (identical(other.collectionKey, collectionKey) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKey, collectionKey)) &&
            (identical(other.collection, collection) ||
                const DeepCollectionEquality()
                    .equals(other.collection, collection)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.invitedAt, invitedAt) ||
                const DeepCollectionEquality()
                    .equals(other.invitedAt, invitedAt)) &&
            (identical(other.invitedByUser, invitedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.invitedByUser, invitedByUser)) &&
            (identical(other.approvedAt, approvedAt) ||
                const DeepCollectionEquality()
                    .equals(other.approvedAt, approvedAt)) &&
            (identical(other.approvedByUser, approvedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.approvedByUser, approvedByUser)) &&
            (identical(other.deniedAt, deniedAt) ||
                const DeepCollectionEquality()
                    .equals(other.deniedAt, deniedAt)) &&
            (identical(other.deniedByUser, deniedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.deniedByUser, deniedByUser)) &&
            (identical(other.addedAt, addedAt) ||
                const DeepCollectionEquality()
                    .equals(other.addedAt, addedAt)) &&
            (identical(other.addedByUser, addedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.addedByUser, addedByUser)) &&
            (identical(other.removedAt, removedAt) ||
                const DeepCollectionEquality()
                    .equals(other.removedAt, removedAt)) &&
            (identical(other.removedByUser, removedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.removedByUser, removedByUser)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collectionRequestKey) ^
        const DeepCollectionEquality().hash(collectionKey) ^
        const DeepCollectionEquality().hash(collection) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(invitedAt) ^
        const DeepCollectionEquality().hash(invitedByUser) ^
        const DeepCollectionEquality().hash(approvedAt) ^
        const DeepCollectionEquality().hash(approvedByUser) ^
        const DeepCollectionEquality().hash(deniedAt) ^
        const DeepCollectionEquality().hash(deniedByUser) ^
        const DeepCollectionEquality().hash(addedAt) ^
        const DeepCollectionEquality().hash(addedByUser) ^
        const DeepCollectionEquality().hash(removedAt) ^
        const DeepCollectionEquality().hash(removedByUser) ^
        const DeepCollectionEquality().hash(createdAt);
  }

  @override
  String toString() => 'CollectionRequest(${toJson()})';
}
