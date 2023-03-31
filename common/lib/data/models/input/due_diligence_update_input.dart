import 'package:iris_common/data/models/input/due_diligence_bullet_item_input.dart';
import 'package:collection/collection.dart';

class DueDiligenceUpdateInput {
  final int? dueDiligenceKey;
  final List<DueDiligenceBulletItemInput>? reasons;
  final double? priceTarget;
  final String? title;
  final int? riskRating;
  final String? riskRatingReason;
  const DueDiligenceUpdateInput(
      {required this.dueDiligenceKey,
      required this.reasons,
      required this.priceTarget,
      this.title,
      this.riskRating,
      this.riskRatingReason});
  DueDiligenceUpdateInput copyWith(
      {int? dueDiligenceKey,
      List<DueDiligenceBulletItemInput>? reasons,
      double? priceTarget,
      String? title,
      int? riskRating,
      String? riskRatingReason}) {
    return DueDiligenceUpdateInput(
      dueDiligenceKey: dueDiligenceKey ?? this.dueDiligenceKey,
      reasons: reasons ?? this.reasons,
      priceTarget: priceTarget ?? this.priceTarget,
      title: title ?? this.title,
      riskRating: riskRating ?? this.riskRating,
      riskRatingReason: riskRatingReason ?? this.riskRatingReason,
    );
  }

  factory DueDiligenceUpdateInput.fromJson(Map<String, dynamic> json) {
    return DueDiligenceUpdateInput(
      dueDiligenceKey: json['dueDiligenceKey'],
      reasons: json['reasons']
          ?.map<DueDiligenceBulletItemInput>(
              (o) => DueDiligenceBulletItemInput.fromJson(o))
          .toList(),
      priceTarget: json['priceTarget']?.toDouble(),
      title: json['title'],
      riskRating: json['riskRating'],
      riskRatingReason: json['riskRatingReason'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['dueDiligenceKey'] = dueDiligenceKey;
    data['reasons'] = reasons?.map((item) => item.toJson()).toList();
    data['priceTarget'] = priceTarget;
    data['title'] = title;
    data['riskRating'] = riskRating;
    data['riskRatingReason'] = riskRatingReason;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligenceUpdateInput &&
            (identical(other.dueDiligenceKey, dueDiligenceKey) ||
                const DeepCollectionEquality()
                    .equals(other.dueDiligenceKey, dueDiligenceKey)) &&
            (identical(other.reasons, reasons) ||
                const DeepCollectionEquality()
                    .equals(other.reasons, reasons)) &&
            (identical(other.priceTarget, priceTarget) ||
                const DeepCollectionEquality()
                    .equals(other.priceTarget, priceTarget)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.riskRating, riskRating) ||
                const DeepCollectionEquality()
                    .equals(other.riskRating, riskRating)) &&
            (identical(other.riskRatingReason, riskRatingReason) ||
                const DeepCollectionEquality()
                    .equals(other.riskRatingReason, riskRatingReason)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(dueDiligenceKey) ^
        const DeepCollectionEquality().hash(reasons) ^
        const DeepCollectionEquality().hash(priceTarget) ^
        const DeepCollectionEquality().hash(title) ^
        const DeepCollectionEquality().hash(riskRating) ^
        const DeepCollectionEquality().hash(riskRatingReason);
  }

  @override
  String toString() => 'DueDiligenceUpdateInput(${toJson()})';
}
