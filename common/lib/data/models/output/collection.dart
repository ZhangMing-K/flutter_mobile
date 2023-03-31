import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/enums/collection_type.dart';
import 'package:iris_common/data/models/enums/privacy_type.dart';
import 'package:iris_common/data/models/enums/approval_type.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/collection_guarded_info.dart';
import 'package:iris_common/data/models/output/users_similarity.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:iris_common/data/models/enums/relation_location.dart';
import 'package:iris_common/data/models/output/user_relation.dart';
import 'package:collection/collection.dart';

class Collection {
  final int? collectionKey;
  final String? name;
  final User? createdByUser;
  final int? createdByUserKey;
  final COLLECTION_TYPE? collectionType;
  final PRIVACY_TYPE? privacyType;
  final APPROVAL_TYPE? approvalType;
  final DateTime? createdAt;
  final String? description;
  final String? pictureUrl;
  final int? nbrTradesToday;
  final List<User>? currentUsers;
  final List<User>? pendingUsers;
  final List<Portfolio>? currentPortfolios;
  final List<Portfolio>? pendingPortfolios;
  final int? numberOfCurrentUsers;
  final int? numberOfPendingUsers;
  final int? numberOfCurrentPortfolios;
  final int? numberOfPendingPortfolios;
  final CollectionGuardedInfo? collectionGuardedInfo;
  final UsersSimilarity? authUserSimilarity;
  final List<TextModel>? messages;
  final RELATION_LOCATION? authUserRelationLocation;
  final UserRelation? authUserRelation;
  final bool? isTyping;
  const Collection(
      {this.collectionKey,
      this.name,
      this.createdByUser,
      this.createdByUserKey,
      this.collectionType,
      this.privacyType,
      this.approvalType,
      this.createdAt,
      this.description,
      this.pictureUrl,
      this.nbrTradesToday,
      this.currentUsers,
      this.pendingUsers,
      this.currentPortfolios,
      this.pendingPortfolios,
      this.numberOfCurrentUsers,
      this.numberOfPendingUsers,
      this.numberOfCurrentPortfolios,
      this.numberOfPendingPortfolios,
      this.collectionGuardedInfo,
      this.authUserSimilarity,
      this.messages,
      this.authUserRelationLocation,
      this.authUserRelation,
      this.isTyping});
  Collection copyWith(
      {int? collectionKey,
      String? name,
      User? createdByUser,
      int? createdByUserKey,
      COLLECTION_TYPE? collectionType,
      PRIVACY_TYPE? privacyType,
      APPROVAL_TYPE? approvalType,
      DateTime? createdAt,
      String? description,
      String? pictureUrl,
      int? nbrTradesToday,
      List<User>? currentUsers,
      List<User>? pendingUsers,
      List<Portfolio>? currentPortfolios,
      List<Portfolio>? pendingPortfolios,
      int? numberOfCurrentUsers,
      int? numberOfPendingUsers,
      int? numberOfCurrentPortfolios,
      int? numberOfPendingPortfolios,
      CollectionGuardedInfo? collectionGuardedInfo,
      UsersSimilarity? authUserSimilarity,
      List<TextModel>? messages,
      RELATION_LOCATION? authUserRelationLocation,
      UserRelation? authUserRelation,
      bool? isTyping}) {
    return Collection(
      collectionKey: collectionKey ?? this.collectionKey,
      name: name ?? this.name,
      createdByUser: createdByUser ?? this.createdByUser,
      createdByUserKey: createdByUserKey ?? this.createdByUserKey,
      collectionType: collectionType ?? this.collectionType,
      privacyType: privacyType ?? this.privacyType,
      approvalType: approvalType ?? this.approvalType,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      nbrTradesToday: nbrTradesToday ?? this.nbrTradesToday,
      currentUsers: currentUsers ?? this.currentUsers,
      pendingUsers: pendingUsers ?? this.pendingUsers,
      currentPortfolios: currentPortfolios ?? this.currentPortfolios,
      pendingPortfolios: pendingPortfolios ?? this.pendingPortfolios,
      numberOfCurrentUsers: numberOfCurrentUsers ?? this.numberOfCurrentUsers,
      numberOfPendingUsers: numberOfPendingUsers ?? this.numberOfPendingUsers,
      numberOfCurrentPortfolios:
          numberOfCurrentPortfolios ?? this.numberOfCurrentPortfolios,
      numberOfPendingPortfolios:
          numberOfPendingPortfolios ?? this.numberOfPendingPortfolios,
      collectionGuardedInfo:
          collectionGuardedInfo ?? this.collectionGuardedInfo,
      authUserSimilarity: authUserSimilarity ?? this.authUserSimilarity,
      messages: messages ?? this.messages,
      authUserRelationLocation:
          authUserRelationLocation ?? this.authUserRelationLocation,
      authUserRelation: authUserRelation ?? this.authUserRelation,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      collectionKey: json['collectionKey'],
      name: json['name'],
      createdByUser: json['createdByUser'] != null
          ? User.fromJson(json['createdByUser'])
          : null,
      createdByUserKey: json['createdByUserKey'],
      collectionType: json['collectionType'] != null
          ? COLLECTION_TYPE.values.byName(json['collectionType'])
          : null,
      privacyType: json['privacyType'] != null
          ? PRIVACY_TYPE.values.byName(json['privacyType'])
          : null,
      approvalType: json['approvalType'] != null
          ? APPROVAL_TYPE.values.byName(json['approvalType'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      description: json['description'],
      pictureUrl: json['pictureUrl'],
      nbrTradesToday: json['nbrTradesToday'],
      currentUsers:
          json['currentUsers']?.map<User>((o) => User.fromJson(o)).toList(),
      pendingUsers:
          json['pendingUsers']?.map<User>((o) => User.fromJson(o)).toList(),
      currentPortfolios: json['currentPortfolios']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
      pendingPortfolios: json['pendingPortfolios']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
      numberOfCurrentUsers: json['numberOfCurrentUsers'],
      numberOfPendingUsers: json['numberOfPendingUsers'],
      numberOfCurrentPortfolios: json['numberOfCurrentPortfolios'],
      numberOfPendingPortfolios: json['numberOfPendingPortfolios'],
      collectionGuardedInfo: json['collectionGuardedInfo'] != null
          ? CollectionGuardedInfo.fromJson(json['collectionGuardedInfo'])
          : null,
      authUserSimilarity: json['authUserSimilarity'] != null
          ? UsersSimilarity.fromJson(json['authUserSimilarity'])
          : null,
      messages: json['messages']
          ?.map<TextModel>((o) => TextModel.fromJson(o))
          .toList(),
      authUserRelationLocation: json['authUserRelationLocation'] != null
          ? RELATION_LOCATION.values.byName(json['authUserRelationLocation'])
          : null,
      authUserRelation: json['authUserRelation'] != null
          ? UserRelation.fromJson(json['authUserRelation'])
          : null,
      isTyping: json['isTyping'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collectionKey'] = collectionKey;
    data['name'] = name;
    data['createdByUser'] = createdByUser?.toJson();
    data['createdByUserKey'] = createdByUserKey;
    data['collectionType'] = collectionType?.name;
    data['privacyType'] = privacyType?.name;
    data['approvalType'] = approvalType?.name;
    data['createdAt'] = createdAt?.toString();
    data['description'] = description;
    data['pictureUrl'] = pictureUrl;
    data['nbrTradesToday'] = nbrTradesToday;
    data['currentUsers'] = currentUsers?.map((item) => item.toJson()).toList();
    data['pendingUsers'] = pendingUsers?.map((item) => item.toJson()).toList();
    data['currentPortfolios'] =
        currentPortfolios?.map((item) => item.toJson()).toList();
    data['pendingPortfolios'] =
        pendingPortfolios?.map((item) => item.toJson()).toList();
    data['numberOfCurrentUsers'] = numberOfCurrentUsers;
    data['numberOfPendingUsers'] = numberOfPendingUsers;
    data['numberOfCurrentPortfolios'] = numberOfCurrentPortfolios;
    data['numberOfPendingPortfolios'] = numberOfPendingPortfolios;
    data['collectionGuardedInfo'] = collectionGuardedInfo?.toJson();
    data['authUserSimilarity'] = authUserSimilarity?.toJson();
    data['messages'] = messages?.map((item) => item.toJson()).toList();
    data['authUserRelationLocation'] = authUserRelationLocation?.name;
    data['authUserRelation'] = authUserRelation?.toJson();
    data['isTyping'] = isTyping;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Collection &&
            (identical(other.collectionKey, collectionKey) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKey, collectionKey)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.createdByUser, createdByUser) ||
                const DeepCollectionEquality()
                    .equals(other.createdByUser, createdByUser)) &&
            (identical(other.createdByUserKey, createdByUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.createdByUserKey, createdByUserKey)) &&
            (identical(other.collectionType, collectionType) ||
                const DeepCollectionEquality()
                    .equals(other.collectionType, collectionType)) &&
            (identical(other.privacyType, privacyType) ||
                const DeepCollectionEquality()
                    .equals(other.privacyType, privacyType)) &&
            (identical(other.approvalType, approvalType) ||
                const DeepCollectionEquality()
                    .equals(other.approvalType, approvalType)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.pictureUrl, pictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.pictureUrl, pictureUrl)) &&
            (identical(other.nbrTradesToday, nbrTradesToday) ||
                const DeepCollectionEquality()
                    .equals(other.nbrTradesToday, nbrTradesToday)) &&
            (identical(other.currentUsers, currentUsers) ||
                const DeepCollectionEquality()
                    .equals(other.currentUsers, currentUsers)) &&
            (identical(other.pendingUsers, pendingUsers) ||
                const DeepCollectionEquality()
                    .equals(other.pendingUsers, pendingUsers)) &&
            (identical(other.currentPortfolios, currentPortfolios) ||
                const DeepCollectionEquality()
                    .equals(other.currentPortfolios, currentPortfolios)) &&
            (identical(other.pendingPortfolios, pendingPortfolios) ||
                const DeepCollectionEquality()
                    .equals(other.pendingPortfolios, pendingPortfolios)) &&
            (identical(other.numberOfCurrentUsers, numberOfCurrentUsers) ||
                const DeepCollectionEquality().equals(
                    other.numberOfCurrentUsers, numberOfCurrentUsers)) &&
            (identical(other.numberOfPendingUsers, numberOfPendingUsers) ||
                const DeepCollectionEquality().equals(
                    other.numberOfPendingUsers, numberOfPendingUsers)) &&
            (identical(other.numberOfCurrentPortfolios, numberOfCurrentPortfolios) ||
                const DeepCollectionEquality().equals(
                    other.numberOfCurrentPortfolios,
                    numberOfCurrentPortfolios)) &&
            (identical(other.numberOfPendingPortfolios, numberOfPendingPortfolios) ||
                const DeepCollectionEquality().equals(
                    other.numberOfPendingPortfolios,
                    numberOfPendingPortfolios)) &&
            (identical(other.collectionGuardedInfo, collectionGuardedInfo) ||
                const DeepCollectionEquality().equals(
                    other.collectionGuardedInfo, collectionGuardedInfo)) &&
            (identical(other.authUserSimilarity, authUserSimilarity) || const DeepCollectionEquality().equals(other.authUserSimilarity, authUserSimilarity)) &&
            (identical(other.messages, messages) || const DeepCollectionEquality().equals(other.messages, messages)) &&
            (identical(other.authUserRelationLocation, authUserRelationLocation) || const DeepCollectionEquality().equals(other.authUserRelationLocation, authUserRelationLocation)) &&
            (identical(other.authUserRelation, authUserRelation) || const DeepCollectionEquality().equals(other.authUserRelation, authUserRelation)) &&
            (identical(other.isTyping, isTyping) || const DeepCollectionEquality().equals(other.isTyping, isTyping)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collectionKey) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(createdByUser) ^
        const DeepCollectionEquality().hash(createdByUserKey) ^
        const DeepCollectionEquality().hash(collectionType) ^
        const DeepCollectionEquality().hash(privacyType) ^
        const DeepCollectionEquality().hash(approvalType) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(pictureUrl) ^
        const DeepCollectionEquality().hash(nbrTradesToday) ^
        const DeepCollectionEquality().hash(currentUsers) ^
        const DeepCollectionEquality().hash(pendingUsers) ^
        const DeepCollectionEquality().hash(currentPortfolios) ^
        const DeepCollectionEquality().hash(pendingPortfolios) ^
        const DeepCollectionEquality().hash(numberOfCurrentUsers) ^
        const DeepCollectionEquality().hash(numberOfPendingUsers) ^
        const DeepCollectionEquality().hash(numberOfCurrentPortfolios) ^
        const DeepCollectionEquality().hash(numberOfPendingPortfolios) ^
        const DeepCollectionEquality().hash(collectionGuardedInfo) ^
        const DeepCollectionEquality().hash(authUserSimilarity) ^
        const DeepCollectionEquality().hash(messages) ^
        const DeepCollectionEquality().hash(authUserRelationLocation) ^
        const DeepCollectionEquality().hash(authUserRelation) ^
        const DeepCollectionEquality().hash(isTyping);
  }

  @override
  String toString() => 'Collection(${toJson()})';
}
