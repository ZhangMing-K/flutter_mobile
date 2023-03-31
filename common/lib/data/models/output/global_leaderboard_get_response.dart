import 'package:collection/collection.dart';

class GlobalLeaderboardGetResponse {
  final List<int>? userKeys;
  final int? nextOffset;
  const GlobalLeaderboardGetResponse(
      {required this.userKeys, required this.nextOffset});
  GlobalLeaderboardGetResponse copyWith(
      {List<int>? userKeys, int? nextOffset}) {
    return GlobalLeaderboardGetResponse(
      userKeys: userKeys ?? this.userKeys,
      nextOffset: nextOffset ?? this.nextOffset,
    );
  }

  factory GlobalLeaderboardGetResponse.fromJson(Map<String, dynamic> json) {
    return GlobalLeaderboardGetResponse(
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      nextOffset: json['nextOffset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKeys'] = userKeys;
    data['nextOffset'] = nextOffset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GlobalLeaderboardGetResponse &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.nextOffset, nextOffset) ||
                const DeepCollectionEquality()
                    .equals(other.nextOffset, nextOffset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(nextOffset);
  }

  @override
  String toString() => 'GlobalLeaderboardGetResponse(${toJson()})';
}
