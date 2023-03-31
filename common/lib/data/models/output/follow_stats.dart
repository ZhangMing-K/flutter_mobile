import 'package:iris_common/data/models/enums/follow_stats_entity_type.dart';
import 'package:collection/collection.dart';

class FollowStats {
  final int? numberOfFollowers;
  final int? numberOfPortfoliosFollowing;
  final int? numberFollowing;
  final FOLLOW_STATS_ENTITY_TYPE? entityType;
  final int? lookupKey;
  const FollowStats(
      {this.numberOfFollowers,
      this.numberOfPortfoliosFollowing,
      this.numberFollowing,
      this.entityType,
      this.lookupKey});
  FollowStats copyWith(
      {int? numberOfFollowers,
      int? numberOfPortfoliosFollowing,
      int? numberFollowing,
      FOLLOW_STATS_ENTITY_TYPE? entityType,
      int? lookupKey}) {
    return FollowStats(
      numberOfFollowers: numberOfFollowers ?? this.numberOfFollowers,
      numberOfPortfoliosFollowing:
          numberOfPortfoliosFollowing ?? this.numberOfPortfoliosFollowing,
      numberFollowing: numberFollowing ?? this.numberFollowing,
      entityType: entityType ?? this.entityType,
      lookupKey: lookupKey ?? this.lookupKey,
    );
  }

  factory FollowStats.fromJson(Map<String, dynamic> json) {
    return FollowStats(
      numberOfFollowers: json['numberOfFollowers'],
      numberOfPortfoliosFollowing: json['numberOfPortfoliosFollowing'],
      numberFollowing: json['numberFollowing'],
      entityType: json['entityType'] != null
          ? FOLLOW_STATS_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      lookupKey: json['lookupKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['numberOfFollowers'] = numberOfFollowers;
    data['numberOfPortfoliosFollowing'] = numberOfPortfoliosFollowing;
    data['numberFollowing'] = numberFollowing;
    data['entityType'] = entityType?.name;
    data['lookupKey'] = lookupKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FollowStats &&
            (identical(other.numberOfFollowers, numberOfFollowers) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfFollowers, numberOfFollowers)) &&
            (identical(other.numberOfPortfoliosFollowing,
                    numberOfPortfoliosFollowing) ||
                const DeepCollectionEquality().equals(
                    other.numberOfPortfoliosFollowing,
                    numberOfPortfoliosFollowing)) &&
            (identical(other.numberFollowing, numberFollowing) ||
                const DeepCollectionEquality()
                    .equals(other.numberFollowing, numberFollowing)) &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.lookupKey, lookupKey) ||
                const DeepCollectionEquality()
                    .equals(other.lookupKey, lookupKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(numberOfFollowers) ^
        const DeepCollectionEquality().hash(numberOfPortfoliosFollowing) ^
        const DeepCollectionEquality().hash(numberFollowing) ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(lookupKey);
  }

  @override
  String toString() => 'FollowStats(${toJson()})';
}
