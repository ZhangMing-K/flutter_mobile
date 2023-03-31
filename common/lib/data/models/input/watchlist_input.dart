import 'package:collection/collection.dart';

class WatchlistInput {
  final int? limit;
  final int? offset;
  const WatchlistInput({this.limit, this.offset});
  WatchlistInput copyWith({int? limit, int? offset}) {
    return WatchlistInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory WatchlistInput.fromJson(Map<String, dynamic> json) {
    return WatchlistInput(
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WatchlistInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'WatchlistInput(${toJson()})';
}
