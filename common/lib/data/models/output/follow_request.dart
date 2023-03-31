import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/enums/follow_request_status.dart';
import 'package:collection/collection.dart';

class FollowRequest {
  final int? followRequestKey;
  final int? accountUserKey;
  final int? followerUserKey;
  final int? portfolioKey;
  final User? accountUser;
  final User? followerUser;
  final Portfolio? portfolio;
  final DateTime? requestedAt;
  final DateTime? approvedAt;
  final DateTime? deniedAt;
  final DateTime? followUntil;
  final FOLLOW_REQUEST_STATUS? status;
  final DateTime? favoritedAt;
  final DateTime? mutedAt;
  final double? notificationPercentage;
  const FollowRequest(
      {this.followRequestKey,
      this.accountUserKey,
      this.followerUserKey,
      this.portfolioKey,
      this.accountUser,
      this.followerUser,
      this.portfolio,
      this.requestedAt,
      this.approvedAt,
      this.deniedAt,
      this.followUntil,
      this.status,
      this.favoritedAt,
      this.mutedAt,
      this.notificationPercentage});
  FollowRequest copyWith(
      {int? followRequestKey,
      int? accountUserKey,
      int? followerUserKey,
      int? portfolioKey,
      User? accountUser,
      User? followerUser,
      Portfolio? portfolio,
      DateTime? requestedAt,
      DateTime? approvedAt,
      DateTime? deniedAt,
      DateTime? followUntil,
      FOLLOW_REQUEST_STATUS? status,
      DateTime? favoritedAt,
      DateTime? mutedAt,
      double? notificationPercentage}) {
    return FollowRequest(
      followRequestKey: followRequestKey ?? this.followRequestKey,
      accountUserKey: accountUserKey ?? this.accountUserKey,
      followerUserKey: followerUserKey ?? this.followerUserKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      accountUser: accountUser ?? this.accountUser,
      followerUser: followerUser ?? this.followerUser,
      portfolio: portfolio ?? this.portfolio,
      requestedAt: requestedAt ?? this.requestedAt,
      approvedAt: approvedAt ?? this.approvedAt,
      deniedAt: deniedAt ?? this.deniedAt,
      followUntil: followUntil ?? this.followUntil,
      status: status ?? this.status,
      favoritedAt: favoritedAt ?? this.favoritedAt,
      mutedAt: mutedAt ?? this.mutedAt,
      notificationPercentage:
          notificationPercentage ?? this.notificationPercentage,
    );
  }

  factory FollowRequest.fromJson(Map<String, dynamic> json) {
    return FollowRequest(
      followRequestKey: json['followRequestKey'],
      accountUserKey: json['accountUserKey'],
      followerUserKey: json['followerUserKey'],
      portfolioKey: json['portfolioKey'],
      accountUser: json['accountUser'] != null
          ? User.fromJson(json['accountUser'])
          : null,
      followerUser: json['followerUser'] != null
          ? User.fromJson(json['followerUser'])
          : null,
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      requestedAt: json['requestedAt'] != null
          ? DateTime.parse(json['requestedAt'])
          : null,
      approvedAt: json['approvedAt'] != null
          ? DateTime.parse(json['approvedAt'])
          : null,
      deniedAt:
          json['deniedAt'] != null ? DateTime.parse(json['deniedAt']) : null,
      followUntil: json['followUntil'] != null
          ? DateTime.parse(json['followUntil'])
          : null,
      status: json['status'] != null
          ? FOLLOW_REQUEST_STATUS.values.byName(json['status'])
          : null,
      favoritedAt: json['favoritedAt'] != null
          ? DateTime.parse(json['favoritedAt'])
          : null,
      mutedAt: json['mutedAt'] != null ? DateTime.parse(json['mutedAt']) : null,
      notificationPercentage: json['notificationPercentage']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['followRequestKey'] = followRequestKey;
    data['accountUserKey'] = accountUserKey;
    data['followerUserKey'] = followerUserKey;
    data['portfolioKey'] = portfolioKey;
    data['accountUser'] = accountUser?.toJson();
    data['followerUser'] = followerUser?.toJson();
    data['portfolio'] = portfolio?.toJson();
    data['requestedAt'] = requestedAt?.toString();
    data['approvedAt'] = approvedAt?.toString();
    data['deniedAt'] = deniedAt?.toString();
    data['followUntil'] = followUntil?.toString();
    data['status'] = status?.name;
    data['favoritedAt'] = favoritedAt?.toString();
    data['mutedAt'] = mutedAt?.toString();
    data['notificationPercentage'] = notificationPercentage;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FollowRequest &&
            (identical(other.followRequestKey, followRequestKey) ||
                const DeepCollectionEquality()
                    .equals(other.followRequestKey, followRequestKey)) &&
            (identical(other.accountUserKey, accountUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.accountUserKey, accountUserKey)) &&
            (identical(other.followerUserKey, followerUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.followerUserKey, followerUserKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.accountUser, accountUser) ||
                const DeepCollectionEquality()
                    .equals(other.accountUser, accountUser)) &&
            (identical(other.followerUser, followerUser) ||
                const DeepCollectionEquality()
                    .equals(other.followerUser, followerUser)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.requestedAt, requestedAt) ||
                const DeepCollectionEquality()
                    .equals(other.requestedAt, requestedAt)) &&
            (identical(other.approvedAt, approvedAt) ||
                const DeepCollectionEquality()
                    .equals(other.approvedAt, approvedAt)) &&
            (identical(other.deniedAt, deniedAt) ||
                const DeepCollectionEquality()
                    .equals(other.deniedAt, deniedAt)) &&
            (identical(other.followUntil, followUntil) ||
                const DeepCollectionEquality()
                    .equals(other.followUntil, followUntil)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.favoritedAt, favoritedAt) ||
                const DeepCollectionEquality()
                    .equals(other.favoritedAt, favoritedAt)) &&
            (identical(other.mutedAt, mutedAt) ||
                const DeepCollectionEquality()
                    .equals(other.mutedAt, mutedAt)) &&
            (identical(other.notificationPercentage, notificationPercentage) ||
                const DeepCollectionEquality().equals(
                    other.notificationPercentage, notificationPercentage)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(followRequestKey) ^
        const DeepCollectionEquality().hash(accountUserKey) ^
        const DeepCollectionEquality().hash(followerUserKey) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(accountUser) ^
        const DeepCollectionEquality().hash(followerUser) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(requestedAt) ^
        const DeepCollectionEquality().hash(approvedAt) ^
        const DeepCollectionEquality().hash(deniedAt) ^
        const DeepCollectionEquality().hash(followUntil) ^
        const DeepCollectionEquality().hash(status) ^
        const DeepCollectionEquality().hash(favoritedAt) ^
        const DeepCollectionEquality().hash(mutedAt) ^
        const DeepCollectionEquality().hash(notificationPercentage);
  }

  @override
  String toString() => 'FollowRequest(${toJson()})';
}
