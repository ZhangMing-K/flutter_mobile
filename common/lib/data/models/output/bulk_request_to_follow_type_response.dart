import 'package:iris_common/data/models/output/follow_request.dart';
import 'package:collection/collection.dart';

class BulkRequestToFollowTypeResponse {
  final List<FollowRequest>? followRequests;
  const BulkRequestToFollowTypeResponse({this.followRequests});
  BulkRequestToFollowTypeResponse copyWith(
      {List<FollowRequest>? followRequests}) {
    return BulkRequestToFollowTypeResponse(
      followRequests: followRequests ?? this.followRequests,
    );
  }

  factory BulkRequestToFollowTypeResponse.fromJson(Map<String, dynamic> json) {
    return BulkRequestToFollowTypeResponse(
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
        (other is BulkRequestToFollowTypeResponse &&
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
  String toString() => 'BulkRequestToFollowTypeResponse(${toJson()})';
}
