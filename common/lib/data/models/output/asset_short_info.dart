import 'package:collection/collection.dart';

class AssetShortInfo {
  final double? shortInterestRatioDaysToCover;
  final double? shortPercentOfFloat;
  const AssetShortInfo(
      {this.shortInterestRatioDaysToCover, this.shortPercentOfFloat});
  AssetShortInfo copyWith(
      {double? shortInterestRatioDaysToCover, double? shortPercentOfFloat}) {
    return AssetShortInfo(
      shortInterestRatioDaysToCover:
          shortInterestRatioDaysToCover ?? this.shortInterestRatioDaysToCover,
      shortPercentOfFloat: shortPercentOfFloat ?? this.shortPercentOfFloat,
    );
  }

  factory AssetShortInfo.fromJson(Map<String, dynamic> json) {
    return AssetShortInfo(
      shortInterestRatioDaysToCover:
          json['shortInterestRatioDaysToCover']?.toDouble(),
      shortPercentOfFloat: json['shortPercentOfFloat']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['shortInterestRatioDaysToCover'] = shortInterestRatioDaysToCover;
    data['shortPercentOfFloat'] = shortPercentOfFloat;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetShortInfo &&
            (identical(other.shortInterestRatioDaysToCover,
                    shortInterestRatioDaysToCover) ||
                const DeepCollectionEquality().equals(
                    other.shortInterestRatioDaysToCover,
                    shortInterestRatioDaysToCover)) &&
            (identical(other.shortPercentOfFloat, shortPercentOfFloat) ||
                const DeepCollectionEquality()
                    .equals(other.shortPercentOfFloat, shortPercentOfFloat)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(shortInterestRatioDaysToCover) ^
        const DeepCollectionEquality().hash(shortPercentOfFloat);
  }

  @override
  String toString() => 'AssetShortInfo(${toJson()})';
}
