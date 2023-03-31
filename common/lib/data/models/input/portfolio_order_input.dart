import 'package:collection/collection.dart';

class PortfolioOrderInput {
  final int? limit;
  final int? offset;
  const PortfolioOrderInput({this.limit, this.offset});
  PortfolioOrderInput copyWith({int? limit, int? offset}) {
    return PortfolioOrderInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory PortfolioOrderInput.fromJson(Map<String, dynamic> json) {
    return PortfolioOrderInput(
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
        (other is PortfolioOrderInput &&
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
  String toString() => 'PortfolioOrderInput(${toJson()})';
}
