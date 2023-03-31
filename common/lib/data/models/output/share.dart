import 'package:iris_common/data/models/enums/share_type.dart';
import 'package:iris_common/data/models/output/invite_link.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/article.dart';
import 'package:iris_common/data/models/output/collection.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:iris_common/data/models/output/position_model.dart';
import 'package:iris_common/data/models/output/leaderboard.dart';
import 'package:collection/collection.dart';

class Share {
  final int? shareKey;
  final int? linkKey;
  final SHARE_TYPE? shareType;
  final int? entityKey;
  final int? sharedByUserKey;
  final bool? showAmounts;
  final bool? preview;
  final int? views;
  final String? uri;
  final DateTime? createdAt;
  final DateTime? expiresAt;
  final InviteLink? link;
  final User? sharedByUser;
  final User? user;
  final TextModel? post;
  final Portfolio? portfolio;
  final Article? article;
  final Collection? chat;
  final Collection? channel;
  final Order? order;
  final PositionModel? position;
  final Leaderboard? leaderboard;
  const Share(
      {this.shareKey,
      this.linkKey,
      this.shareType,
      this.entityKey,
      this.sharedByUserKey,
      this.showAmounts,
      this.preview,
      this.views,
      this.uri,
      this.createdAt,
      this.expiresAt,
      this.link,
      this.sharedByUser,
      this.user,
      this.post,
      this.portfolio,
      this.article,
      this.chat,
      this.channel,
      this.order,
      this.position,
      this.leaderboard});
  Share copyWith(
      {int? shareKey,
      int? linkKey,
      SHARE_TYPE? shareType,
      int? entityKey,
      int? sharedByUserKey,
      bool? showAmounts,
      bool? preview,
      int? views,
      String? uri,
      DateTime? createdAt,
      DateTime? expiresAt,
      InviteLink? link,
      User? sharedByUser,
      User? user,
      TextModel? post,
      Portfolio? portfolio,
      Article? article,
      Collection? chat,
      Collection? channel,
      Order? order,
      PositionModel? position,
      Leaderboard? leaderboard}) {
    return Share(
      shareKey: shareKey ?? this.shareKey,
      linkKey: linkKey ?? this.linkKey,
      shareType: shareType ?? this.shareType,
      entityKey: entityKey ?? this.entityKey,
      sharedByUserKey: sharedByUserKey ?? this.sharedByUserKey,
      showAmounts: showAmounts ?? this.showAmounts,
      preview: preview ?? this.preview,
      views: views ?? this.views,
      uri: uri ?? this.uri,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      link: link ?? this.link,
      sharedByUser: sharedByUser ?? this.sharedByUser,
      user: user ?? this.user,
      post: post ?? this.post,
      portfolio: portfolio ?? this.portfolio,
      article: article ?? this.article,
      chat: chat ?? this.chat,
      channel: channel ?? this.channel,
      order: order ?? this.order,
      position: position ?? this.position,
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }

  factory Share.fromJson(Map<String, dynamic> json) {
    return Share(
      shareKey: json['shareKey'],
      linkKey: json['linkKey'],
      shareType: json['shareType'] != null
          ? SHARE_TYPE.values.byName(json['shareType'])
          : null,
      entityKey: json['entityKey'],
      sharedByUserKey: json['sharedByUserKey'],
      showAmounts: json['showAmounts'],
      preview: json['preview'],
      views: json['views'],
      uri: json['uri'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      expiresAt:
          json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      link: json['link'] != null ? InviteLink.fromJson(json['link']) : null,
      sharedByUser: json['sharedByUser'] != null
          ? User.fromJson(json['sharedByUser'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      post: json['post'] != null ? TextModel.fromJson(json['post']) : null,
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      article:
          json['article'] != null ? Article.fromJson(json['article']) : null,
      chat: json['chat'] != null ? Collection.fromJson(json['chat']) : null,
      channel:
          json['channel'] != null ? Collection.fromJson(json['channel']) : null,
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      position: json['position'] != null
          ? PositionModel.fromJson(json['position'])
          : null,
      leaderboard: json['leaderboard'] != null
          ? Leaderboard.fromJson(json['leaderboard'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['shareKey'] = shareKey;
    data['linkKey'] = linkKey;
    data['shareType'] = shareType?.name;
    data['entityKey'] = entityKey;
    data['sharedByUserKey'] = sharedByUserKey;
    data['showAmounts'] = showAmounts;
    data['preview'] = preview;
    data['views'] = views;
    data['uri'] = uri;
    data['createdAt'] = createdAt?.toString();
    data['expiresAt'] = expiresAt?.toString();
    data['link'] = link?.toJson();
    data['sharedByUser'] = sharedByUser?.toJson();
    data['user'] = user?.toJson();
    data['post'] = post?.toJson();
    data['portfolio'] = portfolio?.toJson();
    data['article'] = article?.toJson();
    data['chat'] = chat?.toJson();
    data['channel'] = channel?.toJson();
    data['order'] = order?.toJson();
    data['position'] = position?.toJson();
    data['leaderboard'] = leaderboard?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Share &&
            (identical(other.shareKey, shareKey) ||
                const DeepCollectionEquality()
                    .equals(other.shareKey, shareKey)) &&
            (identical(other.linkKey, linkKey) ||
                const DeepCollectionEquality()
                    .equals(other.linkKey, linkKey)) &&
            (identical(other.shareType, shareType) ||
                const DeepCollectionEquality()
                    .equals(other.shareType, shareType)) &&
            (identical(other.entityKey, entityKey) ||
                const DeepCollectionEquality()
                    .equals(other.entityKey, entityKey)) &&
            (identical(other.sharedByUserKey, sharedByUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.sharedByUserKey, sharedByUserKey)) &&
            (identical(other.showAmounts, showAmounts) ||
                const DeepCollectionEquality()
                    .equals(other.showAmounts, showAmounts)) &&
            (identical(other.preview, preview) ||
                const DeepCollectionEquality()
                    .equals(other.preview, preview)) &&
            (identical(other.views, views) ||
                const DeepCollectionEquality().equals(other.views, views)) &&
            (identical(other.uri, uri) ||
                const DeepCollectionEquality().equals(other.uri, uri)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.expiresAt, expiresAt) ||
                const DeepCollectionEquality()
                    .equals(other.expiresAt, expiresAt)) &&
            (identical(other.link, link) ||
                const DeepCollectionEquality().equals(other.link, link)) &&
            (identical(other.sharedByUser, sharedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.sharedByUser, sharedByUser)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.post, post) ||
                const DeepCollectionEquality().equals(other.post, post)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.article, article) ||
                const DeepCollectionEquality()
                    .equals(other.article, article)) &&
            (identical(other.chat, chat) ||
                const DeepCollectionEquality().equals(other.chat, chat)) &&
            (identical(other.channel, channel) ||
                const DeepCollectionEquality()
                    .equals(other.channel, channel)) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)) &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)) &&
            (identical(other.leaderboard, leaderboard) ||
                const DeepCollectionEquality()
                    .equals(other.leaderboard, leaderboard)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(shareKey) ^
        const DeepCollectionEquality().hash(linkKey) ^
        const DeepCollectionEquality().hash(shareType) ^
        const DeepCollectionEquality().hash(entityKey) ^
        const DeepCollectionEquality().hash(sharedByUserKey) ^
        const DeepCollectionEquality().hash(showAmounts) ^
        const DeepCollectionEquality().hash(preview) ^
        const DeepCollectionEquality().hash(views) ^
        const DeepCollectionEquality().hash(uri) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(expiresAt) ^
        const DeepCollectionEquality().hash(link) ^
        const DeepCollectionEquality().hash(sharedByUser) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(post) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(article) ^
        const DeepCollectionEquality().hash(chat) ^
        const DeepCollectionEquality().hash(channel) ^
        const DeepCollectionEquality().hash(order) ^
        const DeepCollectionEquality().hash(position) ^
        const DeepCollectionEquality().hash(leaderboard);
  }

  @override
  String toString() => 'Share(${toJson()})';
}
