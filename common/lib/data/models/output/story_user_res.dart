import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class StoryUserRes {
  final User? user;
  final int? points;
  const StoryUserRes({this.user, this.points});
  StoryUserRes copyWith({User? user, int? points}) {
    return StoryUserRes(
      user: user ?? this.user,
      points: points ?? this.points,
    );
  }

  factory StoryUserRes.fromJson(Map<String, dynamic> json) {
    return StoryUserRes(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      points: json['points'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['points'] = points;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StoryUserRes &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(points);
  }

  @override
  String toString() => 'StoryUserRes(${toJson()})';
}
