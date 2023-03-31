import 'package:iris_common/data/models/output/due_diligence.dart';
import 'package:collection/collection.dart';

class DueDiligenceCreateResponse {
  final DueDiligence? dueDiligence;
  const DueDiligenceCreateResponse({this.dueDiligence});
  DueDiligenceCreateResponse copyWith({DueDiligence? dueDiligence}) {
    return DueDiligenceCreateResponse(
      dueDiligence: dueDiligence ?? this.dueDiligence,
    );
  }

  factory DueDiligenceCreateResponse.fromJson(Map<String, dynamic> json) {
    return DueDiligenceCreateResponse(
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
        (other is DueDiligenceCreateResponse &&
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
  String toString() => 'DueDiligenceCreateResponse(${toJson()})';
}
