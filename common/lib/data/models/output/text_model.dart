import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/reaction.dart';
import 'package:iris_common/data/models/output/collection.dart';
import 'package:iris_common/data/models/enums/text_type.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:iris_common/data/models/output/due_diligence.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/article.dart';
import 'package:iris_common/data/models/output/text_tag.dart';
import 'package:iris_common/data/models/output/file_model.dart';
import 'package:iris_common/data/models/output/giff.dart';
import 'package:iris_common/data/models/output/hashtag.dart';
import 'package:iris_common/data/models/output/flag.dart';
import 'package:iris_common/data/models/output/user_relation.dart';
import 'package:iris_common/data/models/output/text_stat.dart';
import 'package:collection/collection.dart';

class TextModel {
  final int? textKey;
  final int? userKey;
  final int? orderKey;
  final int? portfolioKey;
  final User? user;
  final List<Reaction>? reactions;
  final Reaction? authUserReaction;
  final int? numberOfReactions;
  final String? value;
  final DateTime? orderedCreatedAt;
  final DateTime? createdAt;
  final DateTime? editedAt;
  final DateTime? deletedAt;
  final DateTime? featuredAt;
  final int? collectionKey;
  final Collection? collection;
  final int? receiverUserKey;
  final User? receiverUser;
  final int? parentKey;
  final TextModel? parent;
  final int? sharedTextKey;
  final TextModel? sharedText;
  final TEXT_TYPE? textType;
  final List<TextModel>? comments;
  final int? numberOfComments;
  final Asset? asset;
  final Order? order;
  final DueDiligence? dueDiligence;
  final Portfolio? portfolio;
  final Article? article;
  final List<TextTag>? taggedImages;
  final List<TextTag>? taggedVideos;
  final List<FileModel>? taggedFiles;
  final List<Giff>? taggedGiffs;
  final List<Asset>? taggedAssets;
  final List<User>? taggedUsers;
  final List<Hashtag>? taggedHashtags;
  final int? numberOfViews;
  final int? numberOfUniqueViews;
  final List<Flag>? flagsReportedAgainst;
  final DateTime? authUserSeenAt;
  final UserRelation? authUserRelation;
  final DateTime? authUserInteractedAt;
  final bool? isEncrypted;
  final TextStat? textStat;
  final List<Order>? ddOrders;
  final int? textCreateId;
  const TextModel(
      {this.textKey,
      this.userKey,
      this.orderKey,
      this.portfolioKey,
      this.user,
      this.reactions,
      this.authUserReaction,
      this.numberOfReactions,
      this.value,
      this.orderedCreatedAt,
      this.createdAt,
      this.editedAt,
      this.deletedAt,
      this.featuredAt,
      this.collectionKey,
      this.collection,
      this.receiverUserKey,
      this.receiverUser,
      this.parentKey,
      this.parent,
      this.sharedTextKey,
      this.sharedText,
      this.textType,
      this.comments,
      this.numberOfComments,
      this.asset,
      this.order,
      this.dueDiligence,
      this.portfolio,
      this.article,
      this.taggedImages,
      this.taggedVideos,
      this.taggedFiles,
      this.taggedGiffs,
      this.taggedAssets,
      this.taggedUsers,
      this.taggedHashtags,
      this.numberOfViews,
      this.numberOfUniqueViews,
      this.flagsReportedAgainst,
      this.authUserSeenAt,
      this.authUserRelation,
      this.authUserInteractedAt,
      this.isEncrypted,
      this.textStat,
      this.ddOrders,
      this.textCreateId});
  TextModel copyWith(
      {int? textKey,
      int? userKey,
      int? orderKey,
      int? portfolioKey,
      User? user,
      List<Reaction>? reactions,
      Reaction? authUserReaction,
      int? numberOfReactions,
      String? value,
      DateTime? orderedCreatedAt,
      DateTime? createdAt,
      DateTime? editedAt,
      DateTime? deletedAt,
      DateTime? featuredAt,
      int? collectionKey,
      Collection? collection,
      int? receiverUserKey,
      User? receiverUser,
      int? parentKey,
      TextModel? parent,
      int? sharedTextKey,
      TextModel? sharedText,
      TEXT_TYPE? textType,
      List<TextModel>? comments,
      int? numberOfComments,
      Asset? asset,
      Order? order,
      DueDiligence? dueDiligence,
      Portfolio? portfolio,
      Article? article,
      List<TextTag>? taggedImages,
      List<TextTag>? taggedVideos,
      List<FileModel>? taggedFiles,
      List<Giff>? taggedGiffs,
      List<Asset>? taggedAssets,
      List<User>? taggedUsers,
      List<Hashtag>? taggedHashtags,
      int? numberOfViews,
      int? numberOfUniqueViews,
      List<Flag>? flagsReportedAgainst,
      DateTime? authUserSeenAt,
      UserRelation? authUserRelation,
      DateTime? authUserInteractedAt,
      bool? isEncrypted,
      TextStat? textStat,
      List<Order>? ddOrders,
      int? textCreateId}) {
    return TextModel(
      textKey: textKey ?? this.textKey,
      userKey: userKey ?? this.userKey,
      orderKey: orderKey ?? this.orderKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      user: user ?? this.user,
      reactions: reactions ?? this.reactions,
      authUserReaction: authUserReaction ?? this.authUserReaction,
      numberOfReactions: numberOfReactions ?? this.numberOfReactions,
      value: value ?? this.value,
      orderedCreatedAt: orderedCreatedAt ?? this.orderedCreatedAt,
      createdAt: createdAt ?? this.createdAt,
      editedAt: editedAt ?? this.editedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      featuredAt: featuredAt ?? this.featuredAt,
      collectionKey: collectionKey ?? this.collectionKey,
      collection: collection ?? this.collection,
      receiverUserKey: receiverUserKey ?? this.receiverUserKey,
      receiverUser: receiverUser ?? this.receiverUser,
      parentKey: parentKey ?? this.parentKey,
      parent: parent ?? this.parent,
      sharedTextKey: sharedTextKey ?? this.sharedTextKey,
      sharedText: sharedText ?? this.sharedText,
      textType: textType ?? this.textType,
      comments: comments ?? this.comments,
      numberOfComments: numberOfComments ?? this.numberOfComments,
      asset: asset ?? this.asset,
      order: order ?? this.order,
      dueDiligence: dueDiligence ?? this.dueDiligence,
      portfolio: portfolio ?? this.portfolio,
      article: article ?? this.article,
      taggedImages: taggedImages ?? this.taggedImages,
      taggedVideos: taggedVideos ?? this.taggedVideos,
      taggedFiles: taggedFiles ?? this.taggedFiles,
      taggedGiffs: taggedGiffs ?? this.taggedGiffs,
      taggedAssets: taggedAssets ?? this.taggedAssets,
      taggedUsers: taggedUsers ?? this.taggedUsers,
      taggedHashtags: taggedHashtags ?? this.taggedHashtags,
      numberOfViews: numberOfViews ?? this.numberOfViews,
      numberOfUniqueViews: numberOfUniqueViews ?? this.numberOfUniqueViews,
      flagsReportedAgainst: flagsReportedAgainst ?? this.flagsReportedAgainst,
      authUserSeenAt: authUserSeenAt ?? this.authUserSeenAt,
      authUserRelation: authUserRelation ?? this.authUserRelation,
      authUserInteractedAt: authUserInteractedAt ?? this.authUserInteractedAt,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      textStat: textStat ?? this.textStat,
      ddOrders: ddOrders ?? this.ddOrders,
      textCreateId: textCreateId ?? this.textCreateId,
    );
  }

  factory TextModel.fromJson(Map<String, dynamic> json) {
    return TextModel(
      textKey: json['textKey'],
      userKey: json['userKey'],
      orderKey: json['orderKey'],
      portfolioKey: json['portfolioKey'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      reactions: json['reactions']
          ?.map<Reaction>((o) => Reaction.fromJson(o))
          .toList(),
      authUserReaction: json['authUserReaction'] != null
          ? Reaction.fromJson(json['authUserReaction'])
          : null,
      numberOfReactions: json['numberOfReactions'],
      value: json['value'],
      orderedCreatedAt: json['orderedCreatedAt'] != null
          ? DateTime.parse(json['orderedCreatedAt'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      editedAt:
          json['editedAt'] != null ? DateTime.parse(json['editedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      featuredAt: json['featuredAt'] != null
          ? DateTime.parse(json['featuredAt'])
          : null,
      collectionKey: json['collectionKey'],
      collection: json['collection'] != null
          ? Collection.fromJson(json['collection'])
          : null,
      receiverUserKey: json['receiverUserKey'],
      receiverUser: json['receiverUser'] != null
          ? User.fromJson(json['receiverUser'])
          : null,
      parentKey: json['parentKey'],
      parent:
          json['parent'] != null ? TextModel.fromJson(json['parent']) : null,
      sharedTextKey: json['sharedTextKey'],
      sharedText: json['sharedText'] != null
          ? TextModel.fromJson(json['sharedText'])
          : null,
      textType: json['textType'] != null
          ? TEXT_TYPE.values.byName(json['textType'])
          : null,
      comments: json['comments']
          ?.map<TextModel>((o) => TextModel.fromJson(o))
          .toList(),
      numberOfComments: json['numberOfComments'],
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      dueDiligence: json['dueDiligence'] != null
          ? DueDiligence.fromJson(json['dueDiligence'])
          : null,
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      article:
          json['article'] != null ? Article.fromJson(json['article']) : null,
      taggedImages: json['taggedImages']
          ?.map<TextTag>((o) => TextTag.fromJson(o))
          .toList(),
      taggedVideos: json['taggedVideos']
          ?.map<TextTag>((o) => TextTag.fromJson(o))
          .toList(),
      taggedFiles: json['taggedFiles']
          ?.map<FileModel>((o) => FileModel.fromJson(o))
          .toList(),
      taggedGiffs:
          json['taggedGiffs']?.map<Giff>((o) => Giff.fromJson(o)).toList(),
      taggedAssets:
          json['taggedAssets']?.map<Asset>((o) => Asset.fromJson(o)).toList(),
      taggedUsers:
          json['taggedUsers']?.map<User>((o) => User.fromJson(o)).toList(),
      taggedHashtags: json['taggedHashtags']
          ?.map<Hashtag>((o) => Hashtag.fromJson(o))
          .toList(),
      numberOfViews: json['numberOfViews'],
      numberOfUniqueViews: json['numberOfUniqueViews'],
      flagsReportedAgainst: json['flagsReportedAgainst']
          ?.map<Flag>((o) => Flag.fromJson(o))
          .toList(),
      authUserSeenAt: json['authUserSeenAt'] != null
          ? DateTime.parse(json['authUserSeenAt'])
          : null,
      authUserRelation: json['authUserRelation'] != null
          ? UserRelation.fromJson(json['authUserRelation'])
          : null,
      authUserInteractedAt: json['authUserInteractedAt'] != null
          ? DateTime.parse(json['authUserInteractedAt'])
          : null,
      isEncrypted: json['isEncrypted'],
      textStat:
          json['textStat'] != null ? TextStat.fromJson(json['textStat']) : null,
      ddOrders: json['ddOrders']?.map<Order>((o) => Order.fromJson(o)).toList(),
      textCreateId: json['textCreateId'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['textKey'] = textKey;
    data['userKey'] = userKey;
    data['orderKey'] = orderKey;
    data['portfolioKey'] = portfolioKey;
    data['user'] = user?.toJson();
    data['reactions'] = reactions?.map((item) => item.toJson()).toList();
    data['authUserReaction'] = authUserReaction?.toJson();
    data['numberOfReactions'] = numberOfReactions;
    data['value'] = value;
    data['orderedCreatedAt'] = orderedCreatedAt?.toString();
    data['createdAt'] = createdAt?.toString();
    data['editedAt'] = editedAt?.toString();
    data['deletedAt'] = deletedAt?.toString();
    data['featuredAt'] = featuredAt?.toString();
    data['collectionKey'] = collectionKey;
    data['collection'] = collection?.toJson();
    data['receiverUserKey'] = receiverUserKey;
    data['receiverUser'] = receiverUser?.toJson();
    data['parentKey'] = parentKey;
    data['parent'] = parent?.toJson();
    data['sharedTextKey'] = sharedTextKey;
    data['sharedText'] = sharedText?.toJson();
    data['textType'] = textType?.name;
    data['comments'] = comments?.map((item) => item.toJson()).toList();
    data['numberOfComments'] = numberOfComments;
    data['asset'] = asset?.toJson();
    data['order'] = order?.toJson();
    data['dueDiligence'] = dueDiligence?.toJson();
    data['portfolio'] = portfolio?.toJson();
    data['article'] = article?.toJson();
    data['taggedImages'] = taggedImages?.map((item) => item.toJson()).toList();
    data['taggedVideos'] = taggedVideos?.map((item) => item.toJson()).toList();
    data['taggedFiles'] = taggedFiles?.map((item) => item.toJson()).toList();
    data['taggedGiffs'] = taggedGiffs?.map((item) => item.toJson()).toList();
    data['taggedAssets'] = taggedAssets?.map((item) => item.toJson()).toList();
    data['taggedUsers'] = taggedUsers?.map((item) => item.toJson()).toList();
    data['taggedHashtags'] =
        taggedHashtags?.map((item) => item.toJson()).toList();
    data['numberOfViews'] = numberOfViews;
    data['numberOfUniqueViews'] = numberOfUniqueViews;
    data['flagsReportedAgainst'] =
        flagsReportedAgainst?.map((item) => item.toJson()).toList();
    data['authUserSeenAt'] = authUserSeenAt?.toString();
    data['authUserRelation'] = authUserRelation?.toJson();
    data['authUserInteractedAt'] = authUserInteractedAt?.toString();
    data['isEncrypted'] = isEncrypted;
    data['textStat'] = textStat?.toJson();
    data['ddOrders'] = ddOrders?.map((item) => item.toJson()).toList();
    data['textCreateId'] = textCreateId;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextModel &&
            (identical(other.textKey, textKey) ||
                const DeepCollectionEquality()
                    .equals(other.textKey, textKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.orderKey, orderKey) ||
                const DeepCollectionEquality()
                    .equals(other.orderKey, orderKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.reactions, reactions) ||
                const DeepCollectionEquality()
                    .equals(other.reactions, reactions)) &&
            (identical(other.authUserReaction, authUserReaction) ||
                const DeepCollectionEquality()
                    .equals(other.authUserReaction, authUserReaction)) &&
            (identical(other.numberOfReactions, numberOfReactions) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfReactions, numberOfReactions)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.orderedCreatedAt, orderedCreatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.orderedCreatedAt, orderedCreatedAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.editedAt, editedAt) ||
                const DeepCollectionEquality()
                    .equals(other.editedAt, editedAt)) &&
            (identical(other.deletedAt, deletedAt) ||
                const DeepCollectionEquality()
                    .equals(other.deletedAt, deletedAt)) &&
            (identical(other.featuredAt, featuredAt) ||
                const DeepCollectionEquality()
                    .equals(other.featuredAt, featuredAt)) &&
            (identical(other.collectionKey, collectionKey) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKey, collectionKey)) &&
            (identical(other.collection, collection) ||
                const DeepCollectionEquality()
                    .equals(other.collection, collection)) &&
            (identical(other.receiverUserKey, receiverUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.receiverUserKey, receiverUserKey)) &&
            (identical(other.receiverUser, receiverUser) ||
                const DeepCollectionEquality()
                    .equals(other.receiverUser, receiverUser)) &&
            (identical(other.parentKey, parentKey) ||
                const DeepCollectionEquality()
                    .equals(other.parentKey, parentKey)) &&
            (identical(other.parent, parent) ||
                const DeepCollectionEquality().equals(other.parent, parent)) &&
            (identical(other.sharedTextKey, sharedTextKey) ||
                const DeepCollectionEquality()
                    .equals(other.sharedTextKey, sharedTextKey)) &&
            (identical(other.sharedText, sharedText) ||
                const DeepCollectionEquality()
                    .equals(other.sharedText, sharedText)) &&
            (identical(other.textType, textType) ||
                const DeepCollectionEquality()
                    .equals(other.textType, textType)) &&
            (identical(other.comments, comments) || const DeepCollectionEquality().equals(other.comments, comments)) &&
            (identical(other.numberOfComments, numberOfComments) || const DeepCollectionEquality().equals(other.numberOfComments, numberOfComments)) &&
            (identical(other.asset, asset) || const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.order, order) || const DeepCollectionEquality().equals(other.order, order)) &&
            (identical(other.dueDiligence, dueDiligence) || const DeepCollectionEquality().equals(other.dueDiligence, dueDiligence)) &&
            (identical(other.portfolio, portfolio) || const DeepCollectionEquality().equals(other.portfolio, portfolio)) &&
            (identical(other.article, article) || const DeepCollectionEquality().equals(other.article, article)) &&
            (identical(other.taggedImages, taggedImages) || const DeepCollectionEquality().equals(other.taggedImages, taggedImages)) &&
            (identical(other.taggedVideos, taggedVideos) || const DeepCollectionEquality().equals(other.taggedVideos, taggedVideos)) &&
            (identical(other.taggedFiles, taggedFiles) || const DeepCollectionEquality().equals(other.taggedFiles, taggedFiles)) &&
            (identical(other.taggedGiffs, taggedGiffs) || const DeepCollectionEquality().equals(other.taggedGiffs, taggedGiffs)) &&
            (identical(other.taggedAssets, taggedAssets) || const DeepCollectionEquality().equals(other.taggedAssets, taggedAssets)) &&
            (identical(other.taggedUsers, taggedUsers) || const DeepCollectionEquality().equals(other.taggedUsers, taggedUsers)) &&
            (identical(other.taggedHashtags, taggedHashtags) || const DeepCollectionEquality().equals(other.taggedHashtags, taggedHashtags)) &&
            (identical(other.numberOfViews, numberOfViews) || const DeepCollectionEquality().equals(other.numberOfViews, numberOfViews)) &&
            (identical(other.numberOfUniqueViews, numberOfUniqueViews) || const DeepCollectionEquality().equals(other.numberOfUniqueViews, numberOfUniqueViews)) &&
            (identical(other.flagsReportedAgainst, flagsReportedAgainst) || const DeepCollectionEquality().equals(other.flagsReportedAgainst, flagsReportedAgainst)) &&
            (identical(other.authUserSeenAt, authUserSeenAt) || const DeepCollectionEquality().equals(other.authUserSeenAt, authUserSeenAt)) &&
            (identical(other.authUserRelation, authUserRelation) || const DeepCollectionEquality().equals(other.authUserRelation, authUserRelation)) &&
            (identical(other.authUserInteractedAt, authUserInteractedAt) || const DeepCollectionEquality().equals(other.authUserInteractedAt, authUserInteractedAt)) &&
            (identical(other.isEncrypted, isEncrypted) || const DeepCollectionEquality().equals(other.isEncrypted, isEncrypted)) &&
            (identical(other.textStat, textStat) || const DeepCollectionEquality().equals(other.textStat, textStat)) &&
            (identical(other.ddOrders, ddOrders) || const DeepCollectionEquality().equals(other.ddOrders, ddOrders)) &&
            (identical(other.textCreateId, textCreateId) || const DeepCollectionEquality().equals(other.textCreateId, textCreateId)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(textKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(orderKey) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(reactions) ^
        const DeepCollectionEquality().hash(authUserReaction) ^
        const DeepCollectionEquality().hash(numberOfReactions) ^
        const DeepCollectionEquality().hash(value) ^
        const DeepCollectionEquality().hash(orderedCreatedAt) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(editedAt) ^
        const DeepCollectionEquality().hash(deletedAt) ^
        const DeepCollectionEquality().hash(featuredAt) ^
        const DeepCollectionEquality().hash(collectionKey) ^
        const DeepCollectionEquality().hash(collection) ^
        const DeepCollectionEquality().hash(receiverUserKey) ^
        const DeepCollectionEquality().hash(receiverUser) ^
        const DeepCollectionEquality().hash(parentKey) ^
        const DeepCollectionEquality().hash(parent) ^
        const DeepCollectionEquality().hash(sharedTextKey) ^
        const DeepCollectionEquality().hash(sharedText) ^
        const DeepCollectionEquality().hash(textType) ^
        const DeepCollectionEquality().hash(comments) ^
        const DeepCollectionEquality().hash(numberOfComments) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(order) ^
        const DeepCollectionEquality().hash(dueDiligence) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(article) ^
        const DeepCollectionEquality().hash(taggedImages) ^
        const DeepCollectionEquality().hash(taggedVideos) ^
        const DeepCollectionEquality().hash(taggedFiles) ^
        const DeepCollectionEquality().hash(taggedGiffs) ^
        const DeepCollectionEquality().hash(taggedAssets) ^
        const DeepCollectionEquality().hash(taggedUsers) ^
        const DeepCollectionEquality().hash(taggedHashtags) ^
        const DeepCollectionEquality().hash(numberOfViews) ^
        const DeepCollectionEquality().hash(numberOfUniqueViews) ^
        const DeepCollectionEquality().hash(flagsReportedAgainst) ^
        const DeepCollectionEquality().hash(authUserSeenAt) ^
        const DeepCollectionEquality().hash(authUserRelation) ^
        const DeepCollectionEquality().hash(authUserInteractedAt) ^
        const DeepCollectionEquality().hash(isEncrypted) ^
        const DeepCollectionEquality().hash(textStat) ^
        const DeepCollectionEquality().hash(ddOrders) ^
        const DeepCollectionEquality().hash(textCreateId);
  }

  @override
  String toString() => 'TextModel(${toJson()})';
}
