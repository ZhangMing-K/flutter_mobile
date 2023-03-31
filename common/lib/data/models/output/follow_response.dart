import 'package:iris_common/data/models/output/follow_request.dart';
import 'package:collection/collection.dart';

class FollowResponse {
  final FollowRequest? followRequest;
  const FollowResponse({this.followRequest});
  FollowResponse copyWith({FollowRequest? followRequest}) {
    return FollowResponse(
      followRequest: followRequest ?? this.followRequest,
    );
  }

  factory FollowResponse.fromJson(Map<String, dynamic> json) {
    return FollowResponse(
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
        (other is FollowResponse &&
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
  String toString() => 'FollowResponse(${toJson()})';
}
