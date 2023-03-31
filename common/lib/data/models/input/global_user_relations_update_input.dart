import 'package:iris_common/data/models/enums/user_relation_entity_type.dart';
import 'package:iris_common/data/models/enums/relation_location.dart';
import 'package:iris_common/data/models/enums/user_relation_trade_notification_amount.dart';
import 'package:iris_common/data/models/enums/user_relation_notification_amount.dart';
import 'package:collection/collection.dart';

class GlobalUserRelationsUpdateInput {
  final USER_RELATION_ENTITY_TYPE? entityType;
  final bool? mute;
  final bool? watch;
  final bool? block;
  final bool? hide;
  final bool? seen;
  final bool? save;
  final RELATION_LOCATION? relationLocation;
  final USER_RELATION_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount;
  final USER_RELATION_NOTIFICATION_AMOUNT? notificationAmount;
  const GlobalUserRelationsUpdateInput(
      {required this.entityType,
      this.mute,
      this.watch,
      this.block,
      this.hide,
      this.seen,
      this.save,
      this.relationLocation,
      this.tradeNotificationAmount,
      this.notificationAmount});
  GlobalUserRelationsUpdateInput copyWith(
      {USER_RELATION_ENTITY_TYPE? entityType,
      bool? mute,
      bool? watch,
      bool? block,
      bool? hide,
      bool? seen,
      bool? save,
      RELATION_LOCATION? relationLocation,
      USER_RELATION_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount,
      USER_RELATION_NOTIFICATION_AMOUNT? notificationAmount}) {
    return GlobalUserRelationsUpdateInput(
      entityType: entityType ?? this.entityType,
      mute: mute ?? this.mute,
      watch: watch ?? this.watch,
      block: block ?? this.block,
      hide: hide ?? this.hide,
      seen: seen ?? this.seen,
      save: save ?? this.save,
      relationLocation: relationLocation ?? this.relationLocation,
      tradeNotificationAmount:
          tradeNotificationAmount ?? this.tradeNotificationAmount,
      notificationAmount: notificationAmount ?? this.notificationAmount,
    );
  }

  factory GlobalUserRelationsUpdateInput.fromJson(Map<String, dynamic> json) {
    return GlobalUserRelationsUpdateInput(
      entityType: json['entityType'] != null
          ? USER_RELATION_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      mute: json['mute'],
      watch: json['watch'],
      block: json['block'],
      hide: json['hide'],
      seen: json['seen'],
      save: json['save'],
      relationLocation: json['relationLocation'] != null
          ? RELATION_LOCATION.values.byName(json['relationLocation'])
          : null,
      tradeNotificationAmount: json['tradeNotificationAmount'] != null
          ? USER_RELATION_TRADE_NOTIFICATION_AMOUNT.values
              .byName(json['tradeNotificationAmount'])
          : null,
      notificationAmount: json['notificationAmount'] != null
          ? USER_RELATION_NOTIFICATION_AMOUNT.values
              .byName(json['notificationAmount'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['entityType'] = entityType?.name;
    data['mute'] = mute;
    data['watch'] = watch;
    data['block'] = block;
    data['hide'] = hide;
    data['seen'] = seen;
    data['save'] = save;
    data['relationLocation'] = relationLocation?.name;
    data['tradeNotificationAmount'] = tradeNotificationAmount?.name;
    data['notificationAmount'] = notificationAmount?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GlobalUserRelationsUpdateInput &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.mute, mute) ||
                const DeepCollectionEquality().equals(other.mute, mute)) &&
            (identical(other.watch, watch) ||
                const DeepCollectionEquality().equals(other.watch, watch)) &&
            (identical(other.block, block) ||
                const DeepCollectionEquality().equals(other.block, block)) &&
            (identical(other.hide, hide) ||
                const DeepCollectionEquality().equals(other.hide, hide)) &&
            (identical(other.seen, seen) ||
                const DeepCollectionEquality().equals(other.seen, seen)) &&
            (identical(other.save, save) ||
                const DeepCollectionEquality().equals(other.save, save)) &&
            (identical(other.relationLocation, relationLocation) ||
                const DeepCollectionEquality()
                    .equals(other.relationLocation, relationLocation)) &&
            (identical(
                    other.tradeNotificationAmount, tradeNotificationAmount) ||
                const DeepCollectionEquality().equals(
                    other.tradeNotificationAmount, tradeNotificationAmount)) &&
            (identical(other.notificationAmount, notificationAmount) ||
                const DeepCollectionEquality()
                    .equals(other.notificationAmount, notificationAmount)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(mute) ^
        const DeepCollectionEquality().hash(watch) ^
        const DeepCollectionEquality().hash(block) ^
        const DeepCollectionEquality().hash(hide) ^
        const DeepCollectionEquality().hash(seen) ^
        const DeepCollectionEquality().hash(save) ^
        const DeepCollectionEquality().hash(relationLocation) ^
        const DeepCollectionEquality().hash(tradeNotificationAmount) ^
        const DeepCollectionEquality().hash(notificationAmount);
  }

  @override
  String toString() => 'GlobalUserRelationsUpdateInput(${toJson()})';
}
