import 'package:iris_common/data/models/output/jedi_auto_pilot_slave_summary.dart';
import 'package:collection/collection.dart';

class JediAutoPilotSlaveListResponse {
  final List<JediAutoPilotSlaveSummary>? slaves;
  const JediAutoPilotSlaveListResponse({required this.slaves});
  JediAutoPilotSlaveListResponse copyWith(
      {List<JediAutoPilotSlaveSummary>? slaves}) {
    return JediAutoPilotSlaveListResponse(
      slaves: slaves ?? this.slaves,
    );
  }

  factory JediAutoPilotSlaveListResponse.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotSlaveListResponse(
      slaves: json['slaves']
          ?.map<JediAutoPilotSlaveSummary>(
              (o) => JediAutoPilotSlaveSummary.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['slaves'] = slaves?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotSlaveListResponse &&
            (identical(other.slaves, slaves) ||
                const DeepCollectionEquality().equals(other.slaves, slaves)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(slaves);
  }

  @override
  String toString() => 'JediAutoPilotSlaveListResponse(${toJson()})';
}
