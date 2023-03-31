import 'package:collection/collection.dart';

class AssetInput {
  final int? limit;
  final int? offset;
  const AssetInput({this.limit, this.offset});
  AssetInput copyWith({int? limit, int? offset}) {
    return AssetInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory AssetInput.fromJson(Map<String, dynamic> json) {
    return AssetInput(
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
        (other is AssetInput &&
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
  String toString() => 'AssetInput(${toJson()})';
}
