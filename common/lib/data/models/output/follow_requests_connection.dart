import 'package:iris_common/data/models/output/follow_request.dart';
import 'package:collection/collection.dart';

class FollowRequestsConnection {
  final List<FollowRequest>? followRequests;
  final String? nextCursor;
  const FollowRequestsConnection({this.followRequests, this.nextCursor});
  FollowRequestsConnection copyWith(
      {List<FollowRequest>? followRequests, String? nextCursor}) {
    return FollowRequestsConnection(
      followRequests: followRequests ?? this.followRequests,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory FollowRequestsConnection.fromJson(Map<String, dynamic> json) {
    return FollowRequestsConnection(
      followRequests: json['followRequests']
          ?.map<FollowRequest>((o) => FollowRequest.fromJson(o))
          .toList(),
      nextCursor: json['nextCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['followRequests'] =
        followRequests?.map((item) => item.toJson()).toList();
    data['nextCursor'] = nextCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FollowRequestsConnection &&
            (identical(other.followRequests, followRequests) ||
                const DeepCollectionEquality()
                    .equals(other.followRequests, followRequests)) &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(followRequests) ^
        const DeepCollectionEquality().hash(nextCursor);
  }

  @override
  String toString() => 'FollowRequestsConnection(${toJson()})';
}
