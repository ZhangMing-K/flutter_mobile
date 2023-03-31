import 'package:iris_common/data/models/enums/follow_status.dart';
import 'package:iris_common/data/models/output/follow_request.dart';
import 'package:collection/collection.dart';

class AuthUserFollowInfo {
  final FOLLOW_STATUS? followStatus;
  final FollowRequest? followRequest;
  final DateTime? until;
  final bool? watching;
  final bool? notificationsOn;
  const AuthUserFollowInfo(
      {this.followStatus,
      this.followRequest,
      this.until,
      this.watching,
      this.notificationsOn});
  AuthUserFollowInfo copyWith(
      {FOLLOW_STATUS? followStatus,
      FollowRequest? followRequest,
      DateTime? until,
      bool? watching,
      bool? notificationsOn}) {
    return AuthUserFollowInfo(
      followStatus: followStatus ?? this.followStatus,
      followRequest: followRequest ?? this.followRequest,
      until: until ?? this.until,
      watching: watching ?? this.watching,
      notificationsOn: notificationsOn ?? this.notificationsOn,
    );
  }

  factory AuthUserFollowInfo.fromJson(Map<String, dynamic> json) {
    return AuthUserFollowInfo(
      followStatus: json['followStatus'] != null
          ? FOLLOW_STATUS.values.byName(json['followStatus'])
          : null,
      followRequest: json['followRequest'] != null
          ? FollowRequest.fromJson(json['followRequest'])
          : null,
      until: json['until'] != null ? DateTime.parse(json['until']) : null,
      watching: json['watching'],
      notificationsOn: json['notificationsOn'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['followStatus'] = followStatus?.name;
    data['followRequest'] = followRequest?.toJson();
    data['until'] = until?.toString();
    data['watching'] = watching;
    data['notificationsOn'] = notificationsOn;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AuthUserFollowInfo &&
            (identical(other.followStatus, followStatus) ||
                const DeepCollectionEquality()
                    .equals(other.followStatus, followStatus)) &&
            (identical(other.followRequest, followRequest) ||
                const DeepCollectionEquality()
                    .equals(other.followRequest, followRequest)) &&
            (identical(other.until, until) ||
                const DeepCollectionEquality().equals(other.until, until)) &&
            (identical(other.watching, watching) ||
                const DeepCollectionEquality()
                    .equals(other.watching, watching)) &&
            (identical(other.notificationsOn, notificationsOn) ||
                const DeepCollectionEquality()
                    .equals(other.notificationsOn, notificationsOn)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(followStatus) ^
        const DeepCollectionEquality().hash(followRequest) ^
        const DeepCollectionEquality().hash(until) ^
        const DeepCollectionEquality().hash(watching) ^
        const DeepCollectionEquality().hash(notificationsOn);
  }

  @override
  String toString() => 'AuthUserFollowInfo(${toJson()})';
}
