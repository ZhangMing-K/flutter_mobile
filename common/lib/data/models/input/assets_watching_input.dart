import 'package:collection/collection.dart';

class AssetsWatchingInput {
  final int? limit;
  final int? offset;
  final bool? global;
  const AssetsWatchingInput({this.limit, this.offset, this.global});
  AssetsWatchingInput copyWith({int? limit, int? offset, bool? global}) {
    return AssetsWatchingInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      global: global ?? this.global,
    );
  }

  factory AssetsWatchingInput.fromJson(Map<String, dynamic> json) {
    return AssetsWatchingInput(
      limit: json['limit'],
      offset: json['offset'],
      global: json['global'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['global'] = global;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetsWatchingInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.global, global) ||
                const DeepCollectionEquality().equals(other.global, global)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(global);
  }

  @override
  String toString() => 'AssetsWatchingInput(${toJson()})';
}
