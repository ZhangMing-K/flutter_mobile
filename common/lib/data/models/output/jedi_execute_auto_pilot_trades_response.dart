import 'package:iris_common/data/models/output/auto_pilot_order.dart';
import 'package:collection/collection.dart';

class JediExecuteAutoPilotTradesResponse {
  final bool? success;
  final List<AutoPilotOrder>? autoPilotOrders;
  final String? reason;
  const JediExecuteAutoPilotTradesResponse(
      {required this.success, required this.autoPilotOrders, this.reason});
  JediExecuteAutoPilotTradesResponse copyWith(
      {bool? success, List<AutoPilotOrder>? autoPilotOrders, String? reason}) {
    return JediExecuteAutoPilotTradesResponse(
      success: success ?? this.success,
      autoPilotOrders: autoPilotOrders ?? this.autoPilotOrders,
      reason: reason ?? this.reason,
    );
  }

  factory JediExecuteAutoPilotTradesResponse.fromJson(
      Map<String, dynamic> json) {
    return JediExecuteAutoPilotTradesResponse(
      success: json['success'],
      autoPilotOrders: json['autoPilotOrders']
          ?.map<AutoPilotOrder>((o) => AutoPilotOrder.fromJson(o))
          .toList(),
      reason: json['reason'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['autoPilotOrders'] =
        autoPilotOrders?.map((item) => item.toJson()).toList();
    data['reason'] = reason;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediExecuteAutoPilotTradesResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality()
                    .equals(other.success, success)) &&
            (identical(other.autoPilotOrders, autoPilotOrders) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotOrders, autoPilotOrders)) &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(success) ^
        const DeepCollectionEquality().hash(autoPilotOrders) ^
        const DeepCollectionEquality().hash(reason);
  }

  @override
  String toString() => 'JediExecuteAutoPilotTradesResponse(${toJson()})';
}
