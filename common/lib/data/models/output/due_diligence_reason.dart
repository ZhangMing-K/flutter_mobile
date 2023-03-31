import 'package:iris_common/data/models/output/due_diligence_bullet_item.dart';
import 'package:collection/collection.dart';

class DueDiligenceReason {
  final DateTime? createdAt;
  final List<DueDiligenceBulletItem>? reasons;
  const DueDiligenceReason({this.createdAt, this.reasons});
  DueDiligenceReason copyWith(
      {DateTime? createdAt, List<DueDiligenceBulletItem>? reasons}) {
    return DueDiligenceReason(
      createdAt: createdAt ?? this.createdAt,
      reasons: reasons ?? this.reasons,
    );
  }

  factory DueDiligenceReason.fromJson(Map<String, dynamic> json) {
    return DueDiligenceReason(
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      reasons: json['reasons']
          ?.map<DueDiligenceBulletItem>(
              (o) => DueDiligenceBulletItem.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['createdAt'] = createdAt?.toString();
    data['reasons'] = reasons?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligenceReason &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.reasons, reasons) ||
                const DeepCollectionEquality().equals(other.reasons, reasons)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(reasons);
  }

  @override
  String toString() => 'DueDiligenceReason(${toJson()})';
}
