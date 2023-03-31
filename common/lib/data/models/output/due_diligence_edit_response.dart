import 'package:iris_common/data/models/output/due_diligence.dart';
import 'package:collection/collection.dart';

class DueDiligenceEditResponse {
  final DueDiligence? dueDiligence;
  const DueDiligenceEditResponse({this.dueDiligence});
  DueDiligenceEditResponse copyWith({DueDiligence? dueDiligence}) {
    return DueDiligenceEditResponse(
      dueDiligence: dueDiligence ?? this.dueDiligence,
    );
  }

  factory DueDiligenceEditResponse.fromJson(Map<String, dynamic> json) {
    return DueDiligenceEditResponse(
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
        (other is DueDiligenceEditResponse &&
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
  String toString() => 'DueDiligenceEditResponse(${toJson()})';
}
