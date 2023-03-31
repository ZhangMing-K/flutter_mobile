import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/snapshot.dart';
import 'package:collection/collection.dart';

class LeaderboardInstance {
  final int? userKey;
  final int? portfolioKey;
  final User? user;
  final Portfolio? portfolio;
  final Snapshot? snapshot;
  final int? rankNumber;
  final double? percentile;
  const LeaderboardInstance(
      {this.userKey,
      this.portfolioKey,
      this.user,
      this.portfolio,
      this.snapshot,
      this.rankNumber,
      this.percentile});
  LeaderboardInstance copyWith(
      {int? userKey,
      int? portfolioKey,
      User? user,
      Portfolio? portfolio,
      Snapshot? snapshot,
      int? rankNumber,
      double? percentile}) {
    return LeaderboardInstance(
      userKey: userKey ?? this.userKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      user: user ?? this.user,
      portfolio: portfolio ?? this.portfolio,
      snapshot: snapshot ?? this.snapshot,
      rankNumber: rankNumber ?? this.rankNumber,
      percentile: percentile ?? this.percentile,
    );
  }

  factory LeaderboardInstance.fromJson(Map<String, dynamic> json) {
    return LeaderboardInstance(
      userKey: json['userKey'],
      portfolioKey: json['portfolioKey'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      snapshot:
          json['snapshot'] != null ? Snapshot.fromJson(json['snapshot']) : null,
      rankNumber: json['rankNumber'],
      percentile: json['percentile']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['portfolioKey'] = portfolioKey;
    data['user'] = user?.toJson();
    data['portfolio'] = portfolio?.toJson();
    data['snapshot'] = snapshot?.toJson();
    data['rankNumber'] = rankNumber;
    data['percentile'] = percentile;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LeaderboardInstance &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.snapshot, snapshot) ||
                const DeepCollectionEquality()
                    .equals(other.snapshot, snapshot)) &&
            (identical(other.rankNumber, rankNumber) ||
                const DeepCollectionEquality()
                    .equals(other.rankNumber, rankNumber)) &&
            (identical(other.percentile, percentile) ||
                const DeepCollectionEquality()
                    .equals(other.percentile, percentile)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(snapshot) ^
        const DeepCollectionEquality().hash(rankNumber) ^
        const DeepCollectionEquality().hash(percentile);
  }

  @override
  String toString() => 'LeaderboardInstance(${toJson()})';
}
