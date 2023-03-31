import 'package:iris_common/data/models/enums/auto_pilot_order_status.dart';
import 'package:collection/collection.dart';

class SlaveAutoPilotOrdersGet {
  final int? userKey;
  final int? autoPilotSettingsKey;
  final List<AUTO_PILOT_ORDER_STATUS>? orderStatuses;
  final int? limit;
  final int? offset;
  const SlaveAutoPilotOrdersGet(
      {required this.userKey,
      this.autoPilotSettingsKey,
      required this.orderStatuses,
      required this.limit,
      required this.offset});
  SlaveAutoPilotOrdersGet copyWith(
      {int? userKey,
      int? autoPilotSettingsKey,
      List<AUTO_PILOT_ORDER_STATUS>? orderStatuses,
      int? limit,
      int? offset}) {
    return SlaveAutoPilotOrdersGet(
      userKey: userKey ?? this.userKey,
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      orderStatuses: orderStatuses ?? this.orderStatuses,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory SlaveAutoPilotOrdersGet.fromJson(Map<String, dynamic> json) {
    return SlaveAutoPilotOrdersGet(
      userKey: json['userKey'],
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      orderStatuses: json['orderStatuses']
          ?.map<AUTO_PILOT_ORDER_STATUS>(
              (o) => AUTO_PILOT_ORDER_STATUS.values.byName(o))
          .toList(),
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    Map _data = {};
    _data['userKey'] = userKey;
    _data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    _data['orderStatuses'] = orderStatuses?.map((item) => item.name).toList();
    _data['limit'] = limit;
    _data['offset'] = offset;
    return _data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SlaveAutoPilotOrdersGet &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.orderStatuses, orderStatuses) ||
                const DeepCollectionEquality()
                    .equals(other.orderStatuses, orderStatuses)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(orderStatuses) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'SlaveAutoPilotOrdersGet(${toJson()})';
}
