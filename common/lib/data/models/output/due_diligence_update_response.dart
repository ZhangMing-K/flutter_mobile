import 'package:iris_common/data/models/output/due_diligence.dart';
import 'package:collection/collection.dart';

class DueDiligenceUpdateResponse {
  final DueDiligence? dueDiligence;
  const DueDiligenceUpdateResponse({this.dueDiligence});
  DueDiligenceUpdateResponse copyWith({DueDiligence? dueDiligence}) {
    return DueDiligenceUpdateResponse(
      dueDiligence: dueDiligence ?? this.dueDiligence,
    );
  }

  factory DueDiligenceUpdateResponse.fromJson(Map<String, dynamic> json) {
    return DueDiligenceUpdateResponse(
      dueDiligence: json['dueDiligence'] != null
          ? DueDiligence.fromJson(json['dueDiligence'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['dueDiligence'] = dueDiligence?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligenceUpdateResponse &&
            (identical(other.dueDiligence, dueDiligence) ||
                const DeepCollectionEquality()
                    .equals(other.dueDiligence, dueDiligence)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(dueDiligence);
  }

  @override
  String toString() => 'DueDiligenceUpdateResponse(${toJson()})';
}
