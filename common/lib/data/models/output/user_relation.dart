import 'package:iris_common/data/models/enums/user_relation_entity_type.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:iris_common/data/models/output/collection.dart';
import 'package:iris_common/data/models/enums/relation_location.dart';
import 'package:iris_common/data/models/enums/user_relation_trade_notification_amount.dart';
import 'package:iris_common/data/models/enums/user_relation_notification_amount.dart';
import 'package:collection/collection.dart';

class UserRelation {
  final int? userRelationKey;
  final int? entityKey;
  final int? userKey;
  final USER_RELATION_ENTITY_TYPE? entityType;
  final DateTime? mutedAt;
  final DateTime? watchedAt;
  final DateTime? blockedAt;
  final DateTime? hideAt;
  final DateTime? savedAt;
  final DateTime? seenAt;
  final User? user;
  final User? relatedUser;
  final Portfolio? portfolio;
  final Asset? asset;
  final TextModel? text;
  final Collection? collection;
  final RELATION_LOCATION? relationLocation;
  final USER_RELATION_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount;
  final USER_RELATION_NOTIFICATION_AMOUNT? notificationAmount;
  const UserRelation(
      {this.userRelationKey,
      this.entityKey,
      this.userKey,
      this.entityType,
      this.mutedAt,
      this.watchedAt,
      this.blockedAt,
      this.hideAt,
      this.savedAt,
      this.seenAt,
      this.user,
      this.relatedUser,
      this.portfolio,
      this.asset,
      this.text,
      this.collection,
      this.relationLocation,
      this.tradeNotificationAmount,
      this.notificationAmount});
  UserRelation copyWith(
      {int? userRelationKey,
      int? entityKey,
      int? userKey,
      USER_RELATION_ENTITY_TYPE? entityType,
      DateTime? mutedAt,
      DateTime? watchedAt,
      DateTime? blockedAt,
      DateTime? hideAt,
      DateTime? savedAt,
      DateTime? seenAt,
      User? user,
      User? relatedUser,
      Portfolio? portfolio,
      Asset? asset,
      TextModel? text,
      Collection? collection,
      RELATION_LOCATION? relationLocation,
      USER_RELATION_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount,
      USER_RELATION_NOTIFICATION_AMOUNT? notificationAmount}) {
    return UserRelation(
      userRelationKey: userRelationKey ?? this.userRelationKey,
      entityKey: entityKey ?? this.entityKey,
      userKey: userKey ?? this.userKey,
      entityType: entityType ?? this.entityType,
      mutedAt: mutedAt ?? this.mutedAt,
      watchedAt: watchedAt ?? this.watchedAt,
      blockedAt: blockedAt ?? this.blockedAt,
      hideAt: hideAt ?? this.hideAt,
      savedAt: savedAt ?? this.savedAt,
      seenAt: seenAt ?? this.seenAt,
      user: user ?? this.user,
      relatedUser: relatedUser ?? this.relatedUser,
      portfolio: portfolio ?? this.portfolio,
      asset: asset ?? this.asset,
      text: text ?? this.text,
      collection: collection ?? this.collection,
      relationLocation: relationLocation ?? this.relationLocation,
      tradeNotificationAmount:
          tradeNotificationAmount ?? this.tradeNotificationAmount,
      notificationAmount: notificationAmount ?? this.notificationAmount,
    );
  }

  factory UserRelation.fromJson(Map<String, dynamic> json) {
    return UserRelation(
      userRelationKey: json['userRelationKey'],
      entityKey: json['entityKey'],
      userKey: json['userKey'],
      entityType: json['entityType'] != null
          ? USER_RELATION_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      mutedAt: json['mutedAt'] != null ? DateTime.parse(json['mutedAt']) : null,
      watchedAt:
          json['watchedAt'] != null ? DateTime.parse(json['watchedAt']) : null,
      blockedAt:
          json['blockedAt'] != null ? DateTime.parse(json['blockedAt']) : null,
      hideAt: json['hideAt'] != null ? DateTime.parse(json['hideAt']) : null,
      savedAt: json['savedAt'] != null ? DateTime.parse(json['savedAt']) : null,
      seenAt: json['seenAt'] != null ? DateTime.parse(json['seenAt']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      relatedUser: json['relatedUser'] != null
          ? User.fromJson(json['relatedUser'])
          : null,
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      text: json['text'] != null ? TextModel.fromJson(json['text']) : null,
      collection: json['collection'] != null
          ? Collection.fromJson(json['collection'])
          : null,
      relationLocation: json['relationLocation'] != null
          ? RELATION_LOCATION.values.byName(json['relationLocation'])
          : null,
      tradeNotificationAmount: json['tradeNotificationAmount'] != null
          ? USER_RELATION_TRADE_NOTIFICATION_AMOUNT.values
              .byName(json['tradeNotificationAmount'])
          : null,
      notificationAmount: json['notificationAmount'] != null
          ? USER_RELATION_NOTIFICATION_AMOUNT.values
              .byName(json['notificationAmount'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userRelationKey'] = userRelationKey;
    data['entityKey'] = entityKey;
    data['userKey'] = userKey;
    data['entityType'] = entityType?.name;
    data['mutedAt'] = mutedAt?.toString();
    data['watchedAt'] = watchedAt?.toString();
    data['blockedAt'] = blockedAt?.toString();
    data['hideAt'] = hideAt?.toString();
    data['savedAt'] = savedAt?.toString();
    data['seenAt'] = seenAt?.toString();
    data['user'] = user?.toJson();
    data['relatedUser'] = relatedUser?.toJson();
    data['portfolio'] = portfolio?.toJson();
    data['asset'] = asset?.toJson();
    data['text'] = text?.toJson();
    data['collection'] = collection?.toJson();
    data['relationLocation'] = relationLocation?.name;
    data['tradeNotificationAmount'] = tradeNotificationAmount?.name;
    data['notificationAmount'] = notificationAmount?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserRelation &&
            (identical(other.userRelationKey, userRelationKey) ||
                const DeepCollectionEquality()
                    .equals(other.userRelationKey, userRelationKey)) &&
            (identical(other.entityKey, entityKey) ||
                const DeepCollectionEquality()
                    .equals(other.entityKey, entityKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.mutedAt, mutedAt) ||
                const DeepCollectionEquality()
                    .equals(other.mutedAt, mutedAt)) &&
            (identical(other.watchedAt, watchedAt) ||
                const DeepCollectionEquality()
                    .equals(other.watchedAt, watchedAt)) &&
            (identical(other.blockedAt, blockedAt) ||
                const DeepCollectionEquality()
                    .equals(other.blockedAt, blockedAt)) &&
            (identical(other.hideAt, hideAt) ||
                const DeepCollectionEquality().equals(other.hideAt, hideAt)) &&
            (identical(other.savedAt, savedAt) ||
                const DeepCollectionEquality()
                    .equals(other.savedAt, savedAt)) &&
            (identical(other.seenAt, seenAt) ||
                const DeepCollectionEquality().equals(other.seenAt, seenAt)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.relatedUser, relatedUser) ||
                const DeepCollectionEquality()
                    .equals(other.relatedUser, relatedUser)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.collection, collection) ||
                const DeepCollectionEquality()
                    .equals(other.collection, collection)) &&
            (identical(other.relationLocation, relationLocation) ||
                const DeepCollectionEquality()
                    .equals(other.relationLocation, relationLocation)) &&
            (identical(
                    other.tradeNotificationAmount, tradeNotificationAmount) ||
                const DeepCollectionEquality().equals(
                    other.tradeNotificationAmount, tradeNotificationAmount)) &&
            (identical(other.notificationAmount, notificationAmount) ||
                const DeepCollectionEquality()
                    .equals(other.notificationAmount, notificationAmount)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userRelationKey) ^
        const DeepCollectionEquality().hash(entityKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(mutedAt) ^
        const DeepCollectionEquality().hash(watchedAt) ^
        const DeepCollectionEquality().hash(blockedAt) ^
        const DeepCollectionEquality().hash(hideAt) ^
        const DeepCollectionEquality().hash(savedAt) ^
        const DeepCollectionEquality().hash(seenAt) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(relatedUser) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(text) ^
        const DeepCollectionEquality().hash(collection) ^
        const DeepCollectionEquality().hash(relationLocation) ^
        const DeepCollectionEquality().hash(tradeNotificationAmount) ^
        const DeepCollectionEquality().hash(notificationAmount);
  }

  @override
  String toString() => 'UserRelation(${toJson()})';
}
