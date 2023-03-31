import 'package:iris_common/data/models/enums/follow_request_action.dart';
import 'package:collection/collection.dart';

class RespondToManyFollowRequestInput {
  final List<int>? followRequestKeys;
  final FOLLOW_REQUEST_ACTION? action;
  const RespondToManyFollowRequestInput(
      {required this.followRequestKeys, required this.action});
  RespondToManyFollowRequestInput copyWith(
      {List<int>? followRequestKeys, FOLLOW_REQUEST_ACTION? action}) {
    return RespondToManyFollowRequestInput(
      followRequestKeys: followRequestKeys ?? this.followRequestKeys,
      action: action ?? this.action,
    );
  }

  factory RespondToManyFollowRequestInput.fromJson(Map<String, dynamic> json) {
    return RespondToManyFollowRequestInput(
      followRequestKeys:
          json['followRequestKeys']?.map<int>((o) => (o as int)).toList(),
      action: json['action'] != null
          ? FOLLOW_REQUEST_ACTION.values.byName(json['action'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['followRequestKeys'] = followRequestKeys;
    data['action'] = action?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RespondToManyFollowRequestInput &&
            (identical(other.followRequestKeys, followRequestKeys) ||
                const DeepCollectionEquality()
                    .equals(other.followRequestKeys, followRequestKeys)) &&
            (identical(other.action, action) ||
                const DeepCollectionEquality().equals(other.action, action)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(followRequestKeys) ^
        const DeepCollectionEquality().hash(action);
  }

  @override
  String toString() => 'RespondToManyFollowRequestInput(${toJson()})';
}
