import 'package:iris_common/data/models/output/jedi_auto_pilot_master_summary.dart';
import 'package:collection/collection.dart';

class JediAutoPilotMasterListResponse {
  final List<JediAutoPilotMasterSummary>? masters;
  const JediAutoPilotMasterListResponse({required this.masters});
  JediAutoPilotMasterListResponse copyWith(
      {List<JediAutoPilotMasterSummary>? masters}) {
    return JediAutoPilotMasterListResponse(
      masters: masters ?? this.masters,
    );
  }

  factory JediAutoPilotMasterListResponse.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotMasterListResponse(
      masters: json['masters']
          ?.map<JediAutoPilotMasterSummary>(
              (o) => JediAutoPilotMasterSummary.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['masters'] = masters?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotMasterListResponse &&
            (identical(other.masters, masters) ||
                const DeepCollectionEquality().equals(other.masters, masters)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(masters);
  }

  @override
  String toString() => 'JediAutoPilotMasterListResponse(${toJson()})';
}
