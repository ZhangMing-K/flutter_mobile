import 'package:iris_common/data/models/input/due_diligence_bullet_item_input.dart';
import 'package:collection/collection.dart';

class DueDiligenceEditInput {
  final int? dueDiligenceKey;
  final List<DueDiligenceBulletItemInput>? reasons;
  final String? title;
  final double? priceTarget;
  final int? riskRating;
  final String? riskRatingReason;
  final bool? appendNewReasons;
  const DueDiligenceEditInput(
      {required this.dueDiligenceKey,
      this.reasons,
      this.title,
      this.priceTarget,
      this.riskRating,
      this.riskRatingReason,
      this.appendNewReasons});
  DueDiligenceEditInput copyWith(
      {int? dueDiligenceKey,
      List<DueDiligenceBulletItemInput>? reasons,
      String? title,
      double? priceTarget,
      int? riskRating,
      String? riskRatingReason,
      bool? appendNewReasons}) {
    return DueDiligenceEditInput(
      dueDiligenceKey: dueDiligenceKey ?? this.dueDiligenceKey,
      reasons: reasons ?? this.reasons,
      title: title ?? this.title,
      priceTarget: priceTarget ?? this.priceTarget,
      riskRating: riskRating ?? this.riskRating,
      riskRatingReason: riskRatingReason ?? this.riskRatingReason,
      appendNewReasons: appendNewReasons ?? this.appendNewReasons,
    );
  }

  factory DueDiligenceEditInput.fromJson(Map<String, dynamic> json) {
    return DueDiligenceEditInput(
      dueDiligenceKey: json['dueDiligenceKey'],
      reasons: json['reasons']
          ?.map<DueDiligenceBulletItemInput>(
              (o) => DueDiligenceBulletItemInput.fromJson(o))
          .toList(),
      title: json['title'],
      priceTarget: json['priceTarget']?.toDouble(),
      riskRating: json['riskRating'],
      riskRatingReason: json['riskRatingReason'],
      appendNewReasons: json['appendNewReasons'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['dueDiligenceKey'] = dueDiligenceKey;
    data['reasons'] = reasons?.map((item) => item.toJson()).toList();
    data['title'] = title;
    data['priceTarget'] = priceTarget;
    data['riskRating'] = riskRating;
    data['riskRatingReason'] = riskRatingReason;
    data['appendNewReasons'] = appendNewReasons;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligenceEditInput &&
            (identical(other.dueDiligenceKey, dueDiligenceKey) ||
                const DeepCollectionEquality()
                    .equals(other.dueDiligenceKey, dueDiligenceKey)) &&
            (identical(other.reasons, reasons) ||
                const DeepCollectionEquality()
                    .equals(other.reasons, reasons)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.priceTarget, priceTarget) ||
                const DeepCollectionEquality()
                    .equals(other.priceTarget, priceTarget)) &&
            (identical(other.riskRating, riskRating) ||
                const DeepCollectionEquality()
                    .equals(other.riskRating, riskRating)) &&
            (identical(other.riskRatingReason, riskRatingReason) ||
                const DeepCollectionEquality()
                    .equals(other.riskRatingReason, riskRatingReason)) &&
            (identical(other.appendNewReasons, appendNewReasons) ||
                const DeepCollectionEquality()
                    .equals(other.appendNewReasons, appendNewReasons)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(dueDiligenceKey) ^
        const DeepCollectionEquality().hash(reasons) ^
        const DeepCollectionEquality().hash(title) ^
        const DeepCollectionEquality().hash(priceTarget) ^
        const DeepCollectionEquality().hash(riskRating) ^
        const DeepCollectionEquality().hash(riskRatingReason) ^
        const DeepCollectionEquality().hash(appendNewReasons);
  }

  @override
  String toString() => 'DueDiligenceEditInput(${toJson()})';
}
