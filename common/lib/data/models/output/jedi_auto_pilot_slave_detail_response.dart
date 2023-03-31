import 'package:iris_common/data/models/output/jedi_auto_pilot_master_details.dart';
import 'package:iris_common/data/models/output/jedi_auto_pilot_slave_details.dart';
import 'package:iris_common/data/models/output/jedi_auto_pilot_position.dart';
import 'package:collection/collection.dart';

class JediAutoPilotSlaveDetailResponse {
  final JediAutoPilotMasterDetails? masterDetails;
  final JediAutoPilotSlaveDetails? slaveDetails;
  final List<JediAutoPilotPosition>? targetPositions;
  const JediAutoPilotSlaveDetailResponse(
      {required this.masterDetails,
      required this.slaveDetails,
      required this.targetPositions});
  JediAutoPilotSlaveDetailResponse copyWith(
      {JediAutoPilotMasterDetails? masterDetails,
      JediAutoPilotSlaveDetails? slaveDetails,
      List<JediAutoPilotPosition>? targetPositions}) {
    return JediAutoPilotSlaveDetailResponse(
      masterDetails: masterDetails ?? this.masterDetails,
      slaveDetails: slaveDetails ?? this.slaveDetails,
      targetPositions: targetPositions ?? this.targetPositions,
    );
  }

  factory JediAutoPilotSlaveDetailResponse.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotSlaveDetailResponse(
      masterDetails: json['masterDetails'] != null
          ? JediAutoPilotMasterDetails.fromJson(json['masterDetails'])
          : null,
      slaveDetails: json['slaveDetails'] != null
          ? JediAutoPilotSlaveDetails.fromJson(json['slaveDetails'])
          : null,
      targetPositions: json['targetPositions']
          ?.map<JediAutoPilotPosition>((o) => JediAutoPilotPosition.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['masterDetails'] = masterDetails?.toJson();
    data['slaveDetails'] = slaveDetails?.toJson();
    data['targetPositions'] =
        targetPositions?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotSlaveDetailResponse &&
            (identical(other.masterDetails, masterDetails) ||
                const DeepCollectionEquality()
                    .equals(other.masterDetails, masterDetails)) &&
            (identical(other.slaveDetails, slaveDetails) ||
                const DeepCollectionEquality()
                    .equals(other.slaveDetails, slaveDetails)) &&
            (identical(other.targetPositions, targetPositions) ||
                const DeepCollectionEquality()
                    .equals(other.targetPositions, targetPositions)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(masterDetails) ^
        const DeepCollectionEquality().hash(slaveDetails) ^
        const DeepCollectionEquality().hash(targetPositions);
  }

  @override
  String toString() => 'JediAutoPilotSlaveDetailResponse(${toJson()})';
}
