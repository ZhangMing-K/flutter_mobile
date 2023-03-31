import 'package:iris_common/data/models/enums/follow_request_entity_type.dart';
import 'package:collection/collection.dart';

class EditFollowingSettings {
  final FOLLOW_REQUEST_ENTITY_TYPE? entityType;
  final int? entityKey;
  final bool? mute;
  final bool? watch;
  final double? notificationPercentage;
  const EditFollowingSettings(
      {required this.entityType,
      required this.entityKey,
      this.mute,
      this.watch,
      this.notificationPercentage});
  EditFollowingSettings copyWith(
      {FOLLOW_REQUEST_ENTITY_TYPE? entityType,
      int? entityKey,
      bool? mute,
      bool? watch,
      double? notificationPercentage}) {
    return EditFollowingSettings(
      entityType: entityType ?? this.entityType,
      entityKey: entityKey ?? this.entityKey,
      mute: mute ?? this.mute,
      watch: watch ?? this.watch,
      notificationPercentage:
          notificationPercentage ?? this.notificationPercentage,
    );
  }

  factory EditFollowingSettings.fromJson(Map<String, dynamic> json) {
    return EditFollowingSettings(
      entityType: json['entityType'] != null
          ? FOLLOW_REQUEST_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      entityKey: json['entityKey'],
      mute: json['mute'],
      watch: json['watch'],
      notificationPercentage: json['notificationPercentage']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['entityType'] = entityType?.name;
    data['entityKey'] = entityKey;
    data['mute'] = mute;
    data['watch'] = watch;
    data['notificationPercentage'] = notificationPercentage;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EditFollowingSettings &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.entityKey, entityKey) ||
                const DeepCollectionEquality()
                    .equals(other.entityKey, entityKey)) &&
            (identical(other.mute, mute) ||
                const DeepCollectionEquality().equals(other.mute, mute)) &&
            (identical(other.watch, watch) ||
                const DeepCollectionEquality().equals(other.watch, watch)) &&
            (identical(other.notificationPercentage, notificationPercentage) ||
                const DeepCollectionEquality().equals(
                    other.notificationPercentage, notificationPercentage)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(entityKey) ^
        const DeepCollectionEquality().hash(mute) ^
        const DeepCollectionEquality().hash(watch) ^
        const DeepCollectionEquality().hash(notificationPercentage);
  }

  @override
  String toString() => 'EditFollowingSettings(${toJson()})';
}
