import 'package:iris_common/data/models/output/leaderboard.dart';
import 'package:collection/collection.dart';

class LeaderboardGetResponse {
  final Leaderboard? leaderboard;
  const LeaderboardGetResponse({this.leaderboard});
  LeaderboardGetResponse copyWith({Leaderboard? leaderboard}) {
    return LeaderboardGetResponse(
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }

  factory LeaderboardGetResponse.fromJson(Map<String, dynamic> json) {
    return LeaderboardGetResponse(
      leaderboard: json['leaderboard'] != null
          ? Leaderboard.fromJson(json['leaderboard'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['leaderboard'] = leaderboard?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LeaderboardGetResponse &&
            (identical(other.leaderboard, leaderboard) ||
                const DeepCollectionEquality()
                    .equals(other.leaderboard, leaderboard)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(leaderboard);
  }

  @override
  String toString() => 'LeaderboardGetResponse(${toJson()})';
}
