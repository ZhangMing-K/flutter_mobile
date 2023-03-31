import 'package:collection/collection.dart';

class AutoPilotFeaturedPortfolioOrdersInput {
  final int? limit;
  final int? offset;
  const AutoPilotFeaturedPortfolioOrdersInput(
      {required this.limit, required this.offset});
  AutoPilotFeaturedPortfolioOrdersInput copyWith({int? limit, int? offset}) {
    return AutoPilotFeaturedPortfolioOrdersInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory AutoPilotFeaturedPortfolioOrdersInput.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotFeaturedPortfolioOrdersInput(
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
        (other is AutoPilotFeaturedPortfolioOrdersInput &&
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
  String toString() => 'AutoPilotFeaturedPortfolioOrdersInput(${toJson()})';
}
