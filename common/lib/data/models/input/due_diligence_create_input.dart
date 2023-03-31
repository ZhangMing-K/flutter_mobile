import 'package:iris_common/data/models/input/due_diligence_bullet_item_input.dart';
import 'package:iris_common/data/models/enums/term.dart';
import 'package:collection/collection.dart';

class DueDiligenceCreateInput {
  final List<DueDiligenceBulletItemInput>? reasons;
  final String? title;
  final double? percentChangeTarget;
  final String? riskRatingReason;
  final int? assetKey;
  final TERM? term;
  final int? riskRating;
  const DueDiligenceCreateInput(
      {required this.reasons,
      this.title,
      this.percentChangeTarget,
      this.riskRatingReason,
      required this.assetKey,
      required this.term,
      required this.riskRating});
  DueDiligenceCreateInput copyWith(
      {List<DueDiligenceBulletItemInput>? reasons,
      String? title,
      double? percentChangeTarget,
      String? riskRatingReason,
      int? assetKey,
      TERM? term,
      int? riskRating}) {
    return DueDiligenceCreateInput(
      reasons: reasons ?? this.reasons,
      title: title ?? this.title,
      percentChangeTarget: percentChangeTarget ?? this.percentChangeTarget,
      riskRatingReason: riskRatingReason ?? this.riskRatingReason,
      assetKey: assetKey ?? this.assetKey,
      term: term ?? this.term,
      riskRating: riskRating ?? this.riskRating,
    );
  }

  factory DueDiligenceCreateInput.fromJson(Map<String, dynamic> json) {
    return DueDiligenceCreateInput(
      reasons: json['reasons']
          ?.map<DueDiligenceBulletItemInput>(
              (o) => DueDiligenceBulletItemInput.fromJson(o))
          .toList(),
      title: json['title'],
      percentChangeTarget: json['percentChangeTarget']?.toDouble(),
      riskRatingReason: json['riskRatingReason'],
      assetKey: json['assetKey'],
      term: json['term'] != null ? TERM.values.byName(json['term']) : null,
      riskRating: json['riskRating'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['reasons'] = reasons?.map((item) => item.toJson()).toList();
    data['title'] = title;
    data['percentChangeTarget'] = percentChangeTarget;
    data['riskRatingReason'] = riskRatingReason;
    data['assetKey'] = assetKey;
    data['term'] = term?.name;
    data['riskRating'] = riskRating;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligenceCreateInput &&
            (identical(other.reasons, reasons) ||
                const DeepCollectionEquality()
                    .equals(other.reasons, reasons)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.percentChangeTarget, percentChangeTarget) ||
                const DeepCollectionEquality()
                    .equals(other.percentChangeTarget, percentChangeTarget)) &&
            (identical(other.riskRatingReason, riskRatingReason) ||
                const DeepCollectionEquality()
                    .equals(other.riskRatingReason, riskRatingReason)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.term, term) ||
                const DeepCollectionEquality().equals(other.term, term)) &&
            (identical(other.riskRating, riskRating) ||
                const DeepCollectionEquality()
                    .equals(other.riskRating, riskRating)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(reasons) ^
        const DeepCollectionEquality().hash(title) ^
        const DeepCollectionEquality().hash(percentChangeTarget) ^
        const DeepCollectionEquality().hash(riskRatingReason) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(term) ^
        const DeepCollectionEquality().hash(riskRating);
  }

  @override
  String toString() => 'DueDiligenceCreateInput(${toJson()})';
}
