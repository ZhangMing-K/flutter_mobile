import 'package:iris_common/data/models/output/follow_request.dart';
import 'package:collection/collection.dart';

class RespondToFollowRequestResponse {
  final FollowRequest? followRequest;
  const RespondToFollowRequestResponse({this.followRequest});
  RespondToFollowRequestResponse copyWith({FollowRequest? followRequest}) {
    return RespondToFollowRequestResponse(
      followRequest: followRequest ?? this.followRequest,
    );
  }

  factory RespondToFollowRequestResponse.fromJson(Map<String, dynamic> json) {
    return RespondToFollowRequestResponse(
      followRequest: json['followRequest'] != null
          ? FollowRequest.fromJson(json['followRequest'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['followRequest'] = followRequest?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RespondToFollowRequestResponse &&
            (identical(other.followRequest, followRequest) ||
                const DeepCollectionEquality()
                    .equals(other.followRequest, followRequest)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(followRequest);
  }

  @override
  String toString() => 'RespondToFollowRequestResponse(${toJson()})';
}
