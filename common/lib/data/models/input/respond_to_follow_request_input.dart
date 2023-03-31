import 'package:iris_common/data/models/enums/follow_request_action.dart';
import 'package:collection/collection.dart';

class RespondToFollowRequestInput {
  final int? followRequestKey;
  final FOLLOW_REQUEST_ACTION? action;
  const RespondToFollowRequestInput(
      {required this.followRequestKey, required this.action});
  RespondToFollowRequestInput copyWith(
      {int? followRequestKey, FOLLOW_REQUEST_ACTION? action}) {
    return RespondToFollowRequestInput(
      followRequestKey: followRequestKey ?? this.followRequestKey,
      action: action ?? this.action,
    );
  }

  factory RespondToFollowRequestInput.fromJson(Map<String, dynamic> json) {
    return RespondToFollowRequestInput(
      followRequestKey: json['followRequestKey'],
      action: json['action'] != null
          ? FOLLOW_REQUEST_ACTION.values.byName(json['action'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['followRequestKey'] = followRequestKey;
    data['action'] = action?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RespondToFollowRequestInput &&
            (identical(other.followRequestKey, followRequestKey) ||
                const DeepCollectionEquality()
                    .equals(other.followRequestKey, followRequestKey)) &&
            (identical(other.action, action) ||
                const DeepCollectionEquality().equals(other.action, action)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(followRequestKey) ^
        const DeepCollectionEquality().hash(action);
  }

  @override
  String toString() => 'RespondToFollowRequestInput(${toJson()})';
}
