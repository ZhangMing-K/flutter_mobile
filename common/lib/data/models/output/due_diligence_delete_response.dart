import 'package:iris_common/data/models/output/due_diligence.dart';
import 'package:collection/collection.dart';

class DueDiligenceDeleteResponse {
  final DueDiligence? dueDiligence;
  const DueDiligenceDeleteResponse({this.dueDiligence});
  DueDiligenceDeleteResponse copyWith({DueDiligence? dueDiligence}) {
    return DueDiligenceDeleteResponse(
      dueDiligence: dueDiligence ?? this.dueDiligence,
    );
  }

  factory DueDiligenceDeleteResponse.fromJson(Map<String, dynamic> json) {
    return DueDiligenceDeleteResponse(
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
        (other is DueDiligenceDeleteResponse &&
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
  String toString() => 'DueDiligenceDeleteResponse(${toJson()})';
}
