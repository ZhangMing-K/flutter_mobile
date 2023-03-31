import 'package:iris_common/data/models/enums/auto_pilot_order_status.dart';
import 'package:collection/collection.dart';

class SlaveAutoPilotOrdersGetInput {
  final int? userKey;
  final int? autoPilotSettingsKey;
  final List<AUTO_PILOT_ORDER_STATUS>? orderStatuses;
  final int? limit;
  final int? offset;
  const SlaveAutoPilotOrdersGetInput(
      {required this.userKey,
      this.autoPilotSettingsKey,
      required this.orderStatuses,
      required this.limit,
      required this.offset});
  SlaveAutoPilotOrdersGetInput copyWith(
      {int? userKey,
      int? autoPilotSettingsKey,
      List<AUTO_PILOT_ORDER_STATUS>? orderStatuses,
      int? limit,
      int? offset}) {
    return SlaveAutoPilotOrdersGetInput(
      userKey: userKey ?? this.userKey,
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      orderStatuses: orderStatuses ?? this.orderStatuses,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory SlaveAutoPilotOrdersGetInput.fromJson(Map<String, dynamic> json) {
    return SlaveAutoPilotOrdersGetInput(
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
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['orderStatuses'] = orderStatuses?.map((item) => item.name).toList();
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SlaveAutoPilotOrdersGetInput &&
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
  String toString() => 'SlaveAutoPilotOrdersGetInput(${toJson()})';
}
