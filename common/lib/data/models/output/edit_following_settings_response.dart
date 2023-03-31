import 'package:iris_common/data/models/enums/follow_request_entity_type.dart';
import 'package:iris_common/data/models/output/follow_request.dart';
import 'package:collection/collection.dart';

class EditFollowingSettingsResponse {
  final FOLLOW_REQUEST_ENTITY_TYPE? entityType;
  final int? entityKey;
  final FollowRequest? followRequest;
  const EditFollowingSettingsResponse(
      {this.entityType, this.entityKey, this.followRequest});
  EditFollowingSettingsResponse copyWith(
      {FOLLOW_REQUEST_ENTITY_TYPE? entityType,
      int? entityKey,
      FollowRequest? followRequest}) {
    return EditFollowingSettingsResponse(
      entityType: entityType ?? this.entityType,
      entityKey: entityKey ?? this.entityKey,
      followRequest: followRequest ?? this.followRequest,
    );
  }

  factory EditFollowingSettingsResponse.fromJson(Map<String, dynamic> json) {
    return EditFollowingSettingsResponse(
      entityType: json['entityType'] != null
          ? FOLLOW_REQUEST_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      entityKey: json['entityKey'],
      followRequest: json['followRequest'] != null
          ? FollowRequest.fromJson(json['followRequest'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['entityType'] = entityType?.name;
    data['entityKey'] = entityKey;
    data['followRequest'] = followRequest?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EditFollowingSettingsResponse &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.entityKey, entityKey) ||
                const DeepCollectionEquality()
                    .equals(other.entityKey, entityKey)) &&
            (identical(other.followRequest, followRequest) ||
                const DeepCollectionEquality()
                    .equals(other.followRequest, followRequest)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(entityKey) ^
        const DeepCollectionEquality().hash(followRequest);
  }

  @override
  String toString() => 'EditFollowingSettingsResponse(${toJson()})';
}
