import 'package:iris_common/data/models/enums/leaderboard_type.dart';
import 'package:collection/collection.dart';

class GlobalLeaderboardGetInput {
  final LeaderboardType? type;
  final int? offset;
  const GlobalLeaderboardGetInput({required this.type, this.offset});
  GlobalLeaderboardGetInput copyWith({LeaderboardType? type, int? offset}) {
    return GlobalLeaderboardGetInput(
      type: type ?? this.type,
      offset: offset ?? this.offset,
    );
  }

  factory GlobalLeaderboardGetInput.fromJson(Map<String, dynamic> json) {
    return GlobalLeaderboardGetInput(
      type: json['type'] != null
          ? LeaderboardType.values.byName(json['type'])
          : null,
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['type'] = type?.name;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GlobalLeaderboardGetInput &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(type) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'GlobalLeaderboardGetInput(${toJson()})';
}
