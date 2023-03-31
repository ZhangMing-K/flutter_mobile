import 'package:iris_common/data/models/output/due_diligence.dart';
import 'package:collection/collection.dart';

class DueDiligenceSearchResponse {
  final List<DueDiligence>? dueDiligences;
  const DueDiligenceSearchResponse({this.dueDiligences});
  DueDiligenceSearchResponse copyWith({List<DueDiligence>? dueDiligences}) {
    return DueDiligenceSearchResponse(
      dueDiligences: dueDiligences ?? this.dueDiligences,
    );
  }

  factory DueDiligenceSearchResponse.fromJson(Map<String, dynamic> json) {
    return DueDiligenceSearchResponse(
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
        (other is DueDiligenceSearchResponse &&
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
  String toString() => 'DueDiligenceSearchResponse(${toJson()})';
}
