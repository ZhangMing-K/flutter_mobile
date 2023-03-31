import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/collection.dart';
import 'package:iris_common/data/models/output/share.dart';
import 'package:collection/collection.dart';

class InviteLink {
  final int? inviteLinkKey;
  final DateTime? createdAt;
  final String? url;
  final int? userKey;
  final int? portfolioKey;
  final int? collectionKey;
  final User? user;
  final Portfolio? portfolio;
  final Collection? collection;
  final List<User>? usersInvited;
  final List<Share>? shares;
  const InviteLink(
      {this.inviteLinkKey,
      this.createdAt,
      this.url,
      this.userKey,
      this.portfolioKey,
      this.collectionKey,
      this.user,
      this.portfolio,
      this.collection,
      this.usersInvited,
      this.shares});
  InviteLink copyWith(
      {int? inviteLinkKey,
      DateTime? createdAt,
      String? url,
      int? userKey,
      int? portfolioKey,
      int? collectionKey,
      User? user,
      Portfolio? portfolio,
      Collection? collection,
      List<User>? usersInvited,
      List<Share>? shares}) {
    return InviteLink(
      inviteLinkKey: inviteLinkKey ?? this.inviteLinkKey,
      createdAt: createdAt ?? this.createdAt,
      url: url ?? this.url,
      userKey: userKey ?? this.userKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      collectionKey: collectionKey ?? this.collectionKey,
      user: user ?? this.user,
      portfolio: portfolio ?? this.portfolio,
      collection: collection ?? this.collection,
      usersInvited: usersInvited ?? this.usersInvited,
      shares: shares ?? this.shares,
    );
  }

  factory InviteLink.fromJson(Map<String, dynamic> json) {
    return InviteLink(
      inviteLinkKey: json['inviteLinkKey'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      url: json['url'],
      userKey: json['userKey'],
      portfolioKey: json['portfolioKey'],
      collectionKey: json['collectionKey'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      collection: json['collection'] != null
          ? Collection.fromJson(json['collection'])
          : null,
      usersInvited:
          json['usersInvited']?.map<User>((o) => User.fromJson(o)).toList(),
      shares: json['shares']?.map<Share>((o) => Share.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['inviteLinkKey'] = inviteLinkKey;
    data['createdAt'] = createdAt?.toString();
    data['url'] = url;
    data['userKey'] = userKey;
    data['portfolioKey'] = portfolioKey;
    data['collectionKey'] = collectionKey;
    data['user'] = user?.toJson();
    data['portfolio'] = portfolio?.toJson();
    data['collection'] = collection?.toJson();
    data['usersInvited'] = usersInvited?.map((item) => item.toJson()).toList();
    data['shares'] = shares?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InviteLink &&
            (identical(other.inviteLinkKey, inviteLinkKey) ||
                const DeepCollectionEquality()
                    .equals(other.inviteLinkKey, inviteLinkKey)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.collectionKey, collectionKey) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKey, collectionKey)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.collection, collection) ||
                const DeepCollectionEquality()
                    .equals(other.collection, collection)) &&
            (identical(other.usersInvited, usersInvited) ||
                const DeepCollectionEquality()
                    .equals(other.usersInvited, usersInvited)) &&
            (identical(other.shares, shares) ||
                const DeepCollectionEquality().equals(other.shares, shares)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(inviteLinkKey) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(url) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(collectionKey) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(collection) ^
        const DeepCollectionEquality().hash(usersInvited) ^
        const DeepCollectionEquality().hash(shares);
  }

  @override
  String toString() => 'InviteLink(${toJson()})';
}
