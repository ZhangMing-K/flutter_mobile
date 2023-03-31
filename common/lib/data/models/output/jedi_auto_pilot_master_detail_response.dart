import 'package:iris_common/data/models/output/jedi_auto_pilot_master_details.dart';
import 'package:iris_common/data/models/output/jedi_auto_pilot_slave_summary.dart';
import 'package:collection/collection.dart';

class JediAutoPilotMasterDetailResponse {
  final JediAutoPilotMasterDetails? masterDetails;
  final List<JediAutoPilotSlaveSummary>? slaves;
  const JediAutoPilotMasterDetailResponse(
      {this.masterDetails, required this.slaves});
  JediAutoPilotMasterDetailResponse copyWith(
      {JediAutoPilotMasterDetails? masterDetails,
      List<JediAutoPilotSlaveSummary>? slaves}) {
    return JediAutoPilotMasterDetailResponse(
      masterDetails: masterDetails ?? this.masterDetails,
      slaves: slaves ?? this.slaves,
    );
  }

  factory JediAutoPilotMasterDetailResponse.fromJson(
      Map<String, dynamic> json) {
    return JediAutoPilotMasterDetailResponse(
      masterDetails: json['masterDetails'] != null
          ? JediAutoPilotMasterDetails.fromJson(json['masterDetails'])
          : null,
      slaves: json['slaves']
          ?.map<JediAutoPilotSlaveSummary>(
              (o) => JediAutoPilotSlaveSummary.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['masterDetails'] = masterDetails?.toJson();
    data['slaves'] = slaves?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotMasterDetailResponse &&
            (identical(other.masterDetails, masterDetails) ||
                const DeepCollectionEquality()
                    .equals(other.masterDetails, masterDetails)) &&
            (identical(other.slaves, slaves) ||
                const DeepCollectionEquality().equals(other.slaves, slaves)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(masterDetails) ^
        const DeepCollectionEquality().hash(slaves);
  }

  @override
  String toString() => 'JediAutoPilotMasterDetailResponse(${toJson()})';
}
