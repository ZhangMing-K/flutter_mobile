import 'package:iris_common/data/models/output/follow_request.dart';
import 'package:collection/collection.dart';

class RespondToManyFollowRequestsResponse {
  final List<FollowRequest>? followRequests;
  const RespondToManyFollowRequestsResponse({this.followRequests});
  RespondToManyFollowRequestsResponse copyWith(
      {List<FollowRequest>? followRequests}) {
    return RespondToManyFollowRequestsResponse(
      followRequests: followRequests ?? this.followRequests,
    );
  }

  factory RespondToManyFollowRequestsResponse.fromJson(
      Map<String, dynamic> json) {
    return RespondToManyFollowRequestsResponse(
      followRequests: json['followRequests']
          ?.map<FollowRequest>((o) => FollowRequest.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['followRequests'] =
        followRequests?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RespondToManyFollowRequestsResponse &&
            (identical(other.followRequests, followRequests) ||
                const DeepCollectionEquality()
                    .equals(other.followRequests, followRequests)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(followRequests);
  }

  @override
  String toString() => 'RespondToManyFollowRequestsResponse(${toJson()})';
}
