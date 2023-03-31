import 'package:iris_common/data/models/enums/flag_entity_type.dart';
import 'package:iris_common/data/models/enums/flag_reason_type.dart';
import 'package:iris_common/data/models/enums/review_status.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/flag_stats.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class Flag {
  final int? flagKey;
  final FLAG_ENTITY_TYPE? flagEntityType;
  final int? flagEntityKey;
  final int? parentKey;
  final int? reviewedByUserKey;
  final FLAG_REASON_TYPE? flagType;
  final String? reason;
  final int? flaggedByUserKey;
  final DateTime? flaggedAt;
  final DateTime? reviewedAt;
  final REVIEW_STATUS? reviewStatus;
  final Flag? parent;
  final User? reviewedByUser;
  final User? flaggedByUser;
  final User? user;
  final List<FlagStats>? flagStats;
  final Portfolio? portfolio;
  final List<Flag>? children;
  final int? numberOfChildren;
  final TextModel? text;
  const Flag(
      {this.flagKey,
      this.flagEntityType,
      this.flagEntityKey,
      this.parentKey,
      this.reviewedByUserKey,
      this.flagType,
      this.reason,
      this.flaggedByUserKey,
      this.flaggedAt,
      this.reviewedAt,
      this.reviewStatus,
      this.parent,
      this.reviewedByUser,
      this.flaggedByUser,
      this.user,
      this.flagStats,
      this.portfolio,
      this.children,
      this.numberOfChildren,
      this.text});
  Flag copyWith(
      {int? flagKey,
      FLAG_ENTITY_TYPE? flagEntityType,
      int? flagEntityKey,
      int? parentKey,
      int? reviewedByUserKey,
      FLAG_REASON_TYPE? flagType,
      String? reason,
      int? flaggedByUserKey,
      DateTime? flaggedAt,
      DateTime? reviewedAt,
      REVIEW_STATUS? reviewStatus,
      Flag? parent,
      User? reviewedByUser,
      User? flaggedByUser,
      User? user,
      List<FlagStats>? flagStats,
      Portfolio? portfolio,
      List<Flag>? children,
      int? numberOfChildren,
      TextModel? text}) {
    return Flag(
      flagKey: flagKey ?? this.flagKey,
      flagEntityType: flagEntityType ?? this.flagEntityType,
      flagEntityKey: flagEntityKey ?? this.flagEntityKey,
      parentKey: parentKey ?? this.parentKey,
      reviewedByUserKey: reviewedByUserKey ?? this.reviewedByUserKey,
      flagType: flagType ?? this.flagType,
      reason: reason ?? this.reason,
      flaggedByUserKey: flaggedByUserKey ?? this.flaggedByUserKey,
      flaggedAt: flaggedAt ?? this.flaggedAt,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      parent: parent ?? this.parent,
      reviewedByUser: reviewedByUser ?? this.reviewedByUser,
      flaggedByUser: flaggedByUser ?? this.flaggedByUser,
      user: user ?? this.user,
      flagStats: flagStats ?? this.flagStats,
      portfolio: portfolio ?? this.portfolio,
      children: children ?? this.children,
      numberOfChildren: numberOfChildren ?? this.numberOfChildren,
      text: text ?? this.text,
    );
  }

  factory Flag.fromJson(Map<String, dynamic> json) {
    return Flag(
      flagKey: json['flagKey'],
      flagEntityType: json['flagEntityType'] != null
          ? FLAG_ENTITY_TYPE.values.byName(json['flagEntityType'])
          : null,
      flagEntityKey: json['flagEntityKey'],
      parentKey: json['parentKey'],
      reviewedByUserKey: json['reviewedByUserKey'],
      flagType: json['flagType'] != null
          ? FLAG_REASON_TYPE.values.byName(json['flagType'])
          : null,
      reason: json['reason'],
      flaggedByUserKey: json['flaggedByUserKey'],
      flaggedAt:
          json['flaggedAt'] != null ? DateTime.parse(json['flaggedAt']) : null,
      reviewedAt: json['reviewedAt'] != null
          ? DateTime.parse(json['reviewedAt'])
          : null,
      reviewStatus: json['reviewStatus'] != null
          ? REVIEW_STATUS.values.byName(json['reviewStatus'])
          : null,
      parent: json['parent'] != null ? Flag.fromJson(json['parent']) : null,
      reviewedByUser: json['reviewedByUser'] != null
          ? User.fromJson(json['reviewedByUser'])
          : null,
      flaggedByUser: json['flaggedByUser'] != null
          ? User.fromJson(json['flaggedByUser'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      flagStats: json['flagStats']
          ?.map<FlagStats>((o) => FlagStats.fromJson(o))
          .toList(),
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      children: json['children']?.map<Flag>((o) => Flag.fromJson(o)).toList(),
      numberOfChildren: json['numberOfChildren'],
      text: json['text'] != null ? TextModel.fromJson(json['text']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['flagKey'] = flagKey;
    data['flagEntityType'] = flagEntityType?.name;
    data['flagEntityKey'] = flagEntityKey;
    data['parentKey'] = parentKey;
    data['reviewedByUserKey'] = reviewedByUserKey;
    data['flagType'] = flagType?.name;
    data['reason'] = reason;
    data['flaggedByUserKey'] = flaggedByUserKey;
    data['flaggedAt'] = flaggedAt?.toString();
    data['reviewedAt'] = reviewedAt?.toString();
    data['reviewStatus'] = reviewStatus?.name;
    data['parent'] = parent?.toJson();
    data['reviewedByUser'] = reviewedByUser?.toJson();
    data['flaggedByUser'] = flaggedByUser?.toJson();
    data['user'] = user?.toJson();
    data['flagStats'] = flagStats?.map((item) => item.toJson()).toList();
    data['portfolio'] = portfolio?.toJson();
    data['children'] = children?.map((item) => item.toJson()).toList();
    data['numberOfChildren'] = numberOfChildren;
    data['text'] = text?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Flag &&
            (identical(other.flagKey, flagKey) ||
                const DeepCollectionEquality()
                    .equals(other.flagKey, flagKey)) &&
            (identical(other.flagEntityType, flagEntityType) ||
                const DeepCollectionEquality()
                    .equals(other.flagEntityType, flagEntityType)) &&
            (identical(other.flagEntityKey, flagEntityKey) ||
                const DeepCollectionEquality()
                    .equals(other.flagEntityKey, flagEntityKey)) &&
            (identical(other.parentKey, parentKey) ||
                const DeepCollectionEquality()
                    .equals(other.parentKey, parentKey)) &&
            (identical(other.reviewedByUserKey, reviewedByUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.reviewedByUserKey, reviewedByUserKey)) &&
            (identical(other.flagType, flagType) ||
                const DeepCollectionEquality()
                    .equals(other.flagType, flagType)) &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)) &&
            (identical(other.flaggedByUserKey, flaggedByUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.flaggedByUserKey, flaggedByUserKey)) &&
            (identical(other.flaggedAt, flaggedAt) ||
                const DeepCollectionEquality()
                    .equals(other.flaggedAt, flaggedAt)) &&
            (identical(other.reviewedAt, reviewedAt) ||
                const DeepCollectionEquality()
                    .equals(other.reviewedAt, reviewedAt)) &&
            (identical(other.reviewStatus, reviewStatus) ||
                const DeepCollectionEquality()
                    .equals(other.reviewStatus, reviewStatus)) &&
            (identical(other.parent, parent) ||
                const DeepCollectionEquality().equals(other.parent, parent)) &&
            (identical(other.reviewedByUser, reviewedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.reviewedByUser, reviewedByUser)) &&
            (identical(other.flaggedByUser, flaggedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.flaggedByUser, flaggedByUser)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.flagStats, flagStats) ||
                const DeepCollectionEquality()
                    .equals(other.flagStats, flagStats)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.children, children) ||
                const DeepCollectionEquality()
                    .equals(other.children, children)) &&
            (identical(other.numberOfChildren, numberOfChildren) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfChildren, numberOfChildren)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(flagKey) ^
        const DeepCollectionEquality().hash(flagEntityType) ^
        const DeepCollectionEquality().hash(flagEntityKey) ^
        const DeepCollectionEquality().hash(parentKey) ^
        const DeepCollectionEquality().hash(reviewedByUserKey) ^
        const DeepCollectionEquality().hash(flagType) ^
        const DeepCollectionEquality().hash(reason) ^
        const DeepCollectionEquality().hash(flaggedByUserKey) ^
        const DeepCollectionEquality().hash(flaggedAt) ^
        const DeepCollectionEquality().hash(reviewedAt) ^
        const DeepCollectionEquality().hash(reviewStatus) ^
        const DeepCollectionEquality().hash(parent) ^
        const DeepCollectionEquality().hash(reviewedByUser) ^
        const DeepCollectionEquality().hash(flaggedByUser) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(flagStats) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(children) ^
        const DeepCollectionEquality().hash(numberOfChildren) ^
        const DeepCollectionEquality().hash(text);
  }

  @override
  String toString() => 'Flag(${toJson()})';
}
