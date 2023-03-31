import 'package:collection/collection.dart';

class ColectionPendingPortfoliosInput {
  final List<int>? userKeys;
  final int? limit;
  final String? cursor;
  const ColectionPendingPortfoliosInput(
      {this.userKeys, required this.limit, this.cursor});
  ColectionPendingPortfoliosInput copyWith(
      {List<int>? userKeys, int? limit, String? cursor}) {
    return ColectionPendingPortfoliosInput(
      userKeys: userKeys ?? this.userKeys,
      limit: limit ?? this.limit,
      cursor: cursor ?? this.cursor,
    );
  }

  factory ColectionPendingPortfoliosInput.fromJson(Map<String, dynamic> json) {
    return ColectionPendingPortfoliosInput(
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      limit: json['limit'],
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKeys'] = userKeys;
    data['limit'] = limit;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ColectionPendingPortfoliosInput &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'ColectionPendingPortfoliosInput(${toJson()})';
}
