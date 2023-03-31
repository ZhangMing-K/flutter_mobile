import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/notification_action.dart';
import 'package:iris_common/data/models/output/follow_request.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:iris_common/data/models/output/reaction.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class NotificationModel {
  final int? notificationKey;
  final int? userKey;
  final String? message;
  final String? displayMessage;
  final int? followRequestKey;
  final bool? device;
  final bool? push;
  final bool? sms;
  final bool? email;
  final DateTime? sentAt;
  final DateTime? ignoredAt;
  final DateTime? seenAt;
  final Portfolio? portfolio;
  final DateTime? eventHappenedAt;
  final DateTime? hideActionsAt;
  final DateTime? lastActionAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final NotificationAction? action;
  final FollowRequest? followRequest;
  final List<FollowRequest>? followRequests;
  final TextModel? text;
  final TextModel? commentText;
  final Reaction? reaction;
  final User? actionUser;
  final List<Order>? orders;
  final List<Asset>? assets;
  final List<String>? assetSymbols;
  const NotificationModel(
      {this.notificationKey,
      this.userKey,
      this.message,
      this.displayMessage,
      this.followRequestKey,
      this.device,
      this.push,
      this.sms,
      this.email,
      this.sentAt,
      this.ignoredAt,
      this.seenAt,
      this.portfolio,
      this.eventHappenedAt,
      this.hideActionsAt,
      this.lastActionAt,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.action,
      this.followRequest,
      this.followRequests,
      this.text,
      this.commentText,
      this.reaction,
      this.actionUser,
      this.orders,
      this.assets,
      this.assetSymbols});
  NotificationModel copyWith(
      {int? notificationKey,
      int? userKey,
      String? message,
      String? displayMessage,
      int? followRequestKey,
      bool? device,
      bool? push,
      bool? sms,
      bool? email,
      DateTime? sentAt,
      DateTime? ignoredAt,
      DateTime? seenAt,
      Portfolio? portfolio,
      DateTime? eventHappenedAt,
      DateTime? hideActionsAt,
      DateTime? lastActionAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      User? user,
      NotificationAction? action,
      FollowRequest? followRequest,
      List<FollowRequest>? followRequests,
      TextModel? text,
      TextModel? commentText,
      Reaction? reaction,
      User? actionUser,
      List<Order>? orders,
      List<Asset>? assets,
      List<String>? assetSymbols}) {
    return NotificationModel(
      notificationKey: notificationKey ?? this.notificationKey,
      userKey: userKey ?? this.userKey,
      message: message ?? this.message,
      displayMessage: displayMessage ?? this.displayMessage,
      followRequestKey: followRequestKey ?? this.followRequestKey,
      device: device ?? this.device,
      push: push ?? this.push,
      sms: sms ?? this.sms,
      email: email ?? this.email,
      sentAt: sentAt ?? this.sentAt,
      ignoredAt: ignoredAt ?? this.ignoredAt,
      seenAt: seenAt ?? this.seenAt,
      portfolio: portfolio ?? this.portfolio,
      eventHappenedAt: eventHappenedAt ?? this.eventHappenedAt,
      hideActionsAt: hideActionsAt ?? this.hideActionsAt,
      lastActionAt: lastActionAt ?? this.lastActionAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      action: action ?? this.action,
      followRequest: followRequest ?? this.followRequest,
      followRequests: followRequests ?? this.followRequests,
      text: text ?? this.text,
      commentText: commentText ?? this.commentText,
      reaction: reaction ?? this.reaction,
      actionUser: actionUser ?? this.actionUser,
      orders: orders ?? this.orders,
      assets: assets ?? this.assets,
      assetSymbols: assetSymbols ?? this.assetSymbols,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationKey: json['notificationKey'],
      userKey: json['userKey'],
      message: json['message'],
      displayMessage: json['displayMessage'],
      followRequestKey: json['followRequestKey'],
      device: json['device'],
      push: json['push'],
      sms: json['sms'],
      email: json['email'],
      sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt']) : null,
      ignoredAt:
          json['ignoredAt'] != null ? DateTime.parse(json['ignoredAt']) : null,
      seenAt: json['seenAt'] != null ? DateTime.parse(json['seenAt']) : null,
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      eventHappenedAt: json['eventHappenedAt'] != null
          ? DateTime.parse(json['eventHappenedAt'])
          : null,
      hideActionsAt: json['hideActionsAt'] != null
          ? DateTime.parse(json['hideActionsAt'])
          : null,
      lastActionAt: json['lastActionAt'] != null
          ? DateTime.parse(json['lastActionAt'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      action: json['action'] != null
          ? NotificationAction.fromJson(json['action'])
          : null,
      followRequest: json['followRequest'] != null
          ? FollowRequest.fromJson(json['followRequest'])
          : null,
      followRequests: json['followRequests']
          ?.map<FollowRequest>((o) => FollowRequest.fromJson(o))
          .toList(),
      text: json['text'] != null ? TextModel.fromJson(json['text']) : null,
      commentText: json['commentText'] != null
          ? TextModel.fromJson(json['commentText'])
          : null,
      reaction:
          json['reaction'] != null ? Reaction.fromJson(json['reaction']) : null,
      actionUser:
          json['actionUser'] != null ? User.fromJson(json['actionUser']) : null,
      orders: json['orders']?.map<Order>((o) => Order.fromJson(o)).toList(),
      assets: json['assets']?.map<Asset>((o) => Asset.fromJson(o)).toList(),
      assetSymbols:
          json['assetSymbols']?.map<String>((o) => o.toString()).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['notificationKey'] = notificationKey;
    data['userKey'] = userKey;
    data['message'] = message;
    data['displayMessage'] = displayMessage;
    data['followRequestKey'] = followRequestKey;
    data['device'] = device;
    data['push'] = push;
    data['sms'] = sms;
    data['email'] = email;
    data['sentAt'] = sentAt?.toString();
    data['ignoredAt'] = ignoredAt?.toString();
    data['seenAt'] = seenAt?.toString();
    data['portfolio'] = portfolio?.toJson();
    data['eventHappenedAt'] = eventHappenedAt?.toString();
    data['hideActionsAt'] = hideActionsAt?.toString();
    data['lastActionAt'] = lastActionAt?.toString();
    data['createdAt'] = createdAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    data['user'] = user?.toJson();
    data['action'] = action?.toJson();
    data['followRequest'] = followRequest?.toJson();
    data['followRequests'] =
        followRequests?.map((item) => item.toJson()).toList();
    data['text'] = text?.toJson();
    data['commentText'] = commentText?.toJson();
    data['reaction'] = reaction?.toJson();
    data['actionUser'] = actionUser?.toJson();
    data['orders'] = orders?.map((item) => item.toJson()).toList();
    data['assets'] = assets?.map((item) => item.toJson()).toList();
    data['assetSymbols'] = assetSymbols;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotificationModel &&
            (identical(other.notificationKey, notificationKey) ||
                const DeepCollectionEquality()
                    .equals(other.notificationKey, notificationKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.displayMessage, displayMessage) ||
                const DeepCollectionEquality()
                    .equals(other.displayMessage, displayMessage)) &&
            (identical(other.followRequestKey, followRequestKey) ||
                const DeepCollectionEquality()
                    .equals(other.followRequestKey, followRequestKey)) &&
            (identical(other.device, device) ||
                const DeepCollectionEquality().equals(other.device, device)) &&
            (identical(other.push, push) ||
                const DeepCollectionEquality().equals(other.push, push)) &&
            (identical(other.sms, sms) ||
                const DeepCollectionEquality().equals(other.sms, sms)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.sentAt, sentAt) ||
                const DeepCollectionEquality().equals(other.sentAt, sentAt)) &&
            (identical(other.ignoredAt, ignoredAt) ||
                const DeepCollectionEquality()
                    .equals(other.ignoredAt, ignoredAt)) &&
            (identical(other.seenAt, seenAt) ||
                const DeepCollectionEquality().equals(other.seenAt, seenAt)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.eventHappenedAt, eventHappenedAt) ||
                const DeepCollectionEquality()
                    .equals(other.eventHappenedAt, eventHappenedAt)) &&
            (identical(other.hideActionsAt, hideActionsAt) ||
                const DeepCollectionEquality()
                    .equals(other.hideActionsAt, hideActionsAt)) &&
            (identical(other.lastActionAt, lastActionAt) ||
                const DeepCollectionEquality()
                    .equals(other.lastActionAt, lastActionAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.action, action) ||
                const DeepCollectionEquality().equals(other.action, action)) &&
            (identical(other.followRequest, followRequest) ||
                const DeepCollectionEquality()
                    .equals(other.followRequest, followRequest)) &&
            (identical(other.followRequests, followRequests) ||
                const DeepCollectionEquality()
                    .equals(other.followRequests, followRequests)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.commentText, commentText) ||
                const DeepCollectionEquality()
                    .equals(other.commentText, commentText)) &&
            (identical(other.reaction, reaction) ||
                const DeepCollectionEquality()
                    .equals(other.reaction, reaction)) &&
            (identical(other.actionUser, actionUser) ||
                const DeepCollectionEquality()
                    .equals(other.actionUser, actionUser)) &&
            (identical(other.orders, orders) || const DeepCollectionEquality().equals(other.orders, orders)) &&
            (identical(other.assets, assets) || const DeepCollectionEquality().equals(other.assets, assets)) &&
            (identical(other.assetSymbols, assetSymbols) || const DeepCollectionEquality().equals(other.assetSymbols, assetSymbols)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(notificationKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(message) ^
        const DeepCollectionEquality().hash(displayMessage) ^
        const DeepCollectionEquality().hash(followRequestKey) ^
        const DeepCollectionEquality().hash(device) ^
        const DeepCollectionEquality().hash(push) ^
        const DeepCollectionEquality().hash(sms) ^
        const DeepCollectionEquality().hash(email) ^
        const DeepCollectionEquality().hash(sentAt) ^
        const DeepCollectionEquality().hash(ignoredAt) ^
        const DeepCollectionEquality().hash(seenAt) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(eventHappenedAt) ^
        const DeepCollectionEquality().hash(hideActionsAt) ^
        const DeepCollectionEquality().hash(lastActionAt) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(updatedAt) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(action) ^
        const DeepCollectionEquality().hash(followRequest) ^
        const DeepCollectionEquality().hash(followRequests) ^
        const DeepCollectionEquality().hash(text) ^
        const DeepCollectionEquality().hash(commentText) ^
        const DeepCollectionEquality().hash(reaction) ^
        const DeepCollectionEquality().hash(actionUser) ^
        const DeepCollectionEquality().hash(orders) ^
        const DeepCollectionEquality().hash(assets) ^
        const DeepCollectionEquality().hash(assetSymbols);
  }

  @override
  String toString() => 'NotificationModel(${toJson()})';
}
