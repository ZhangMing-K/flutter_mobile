import 'package:iris_common/data/models/output/follow_request.dart';
import 'package:collection/collection.dart';

class RequestToFollowTypeResponse {
  final FollowRequest? followRequest;
  const RequestToFollowTypeResponse({this.followRequest});
  RequestToFollowTypeResponse copyWith({FollowRequest? followRequest}) {
    return RequestToFollowTypeResponse(
      followRequest: followRequest ?? this.followRequest,
    );
  }

  factory RequestToFollowTypeResponse.fromJson(Map<String, dynamic> json) {
    return RequestToFollowTypeResponse(
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
        (other is RequestToFollowTypeResponse &&
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
  String toString() => 'RequestToFollowTypeResponse(${toJson()})';
}
