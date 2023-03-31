import 'package:iris_common/data/models/output/due_diligence.dart';
import 'package:collection/collection.dart';

class DueDiligenceCancelResponse {
  final List<DueDiligence>? dueDiligences;
  const DueDiligenceCancelResponse({this.dueDiligences});
  DueDiligenceCancelResponse copyWith({List<DueDiligence>? dueDiligences}) {
    return DueDiligenceCancelResponse(
      dueDiligences: dueDiligences ?? this.dueDiligences,
    );
  }

  factory DueDiligenceCancelResponse.fromJson(Map<String, dynamic> json) {
    return DueDiligenceCancelResponse(
      dueDiligences: json['dueDiligences']
          ?.map<DueDiligence>((o) => DueDiligence.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['dueDiligences'] =
        dueDiligences?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligenceCancelResponse &&
            (identical(other.dueDiligences, dueDiligences) ||
                const DeepCollectionEquality()
                    .equals(other.dueDiligences, dueDiligences)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(dueDiligences);
  }

  @override
  String toString() => 'DueDiligenceCancelResponse(${toJson()})';
}
