import 'package:iris_common/data/models/enums/review_status.dart';
import 'package:collection/collection.dart';

class FlagReviewInput {
  final REVIEW_STATUS? reviewStatus;
  final int? flagKey;
  const FlagReviewInput({required this.reviewStatus, required this.flagKey});
  FlagReviewInput copyWith({REVIEW_STATUS? reviewStatus, int? flagKey}) {
    return FlagReviewInput(
      reviewStatus: reviewStatus ?? this.reviewStatus,
      flagKey: flagKey ?? this.flagKey,
    );
  }

  factory FlagReviewInput.fromJson(Map<String, dynamic> json) {
    return FlagReviewInput(
      reviewStatus: json['reviewStatus'] != null
          ? REVIEW_STATUS.values.byName(json['reviewStatus'])
          : null,
      flagKey: json['flagKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['reviewStatus'] = reviewStatus?.name;
    data['flagKey'] = flagKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FlagReviewInput &&
            (identical(other.reviewStatus, reviewStatus) ||
                const DeepCollectionEquality()
                    .equals(other.reviewStatus, reviewStatus)) &&
            (identical(other.flagKey, flagKey) ||
                const DeepCollectionEquality().equals(other.flagKey, flagKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(reviewStatus) ^
        const DeepCollectionEquality().hash(flagKey);
  }

  @override
  String toString() => 'FlagReviewInput(${toJson()})';
}
