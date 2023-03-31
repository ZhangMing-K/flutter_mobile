import 'package:collection/collection.dart';

class IrisAssetOutlook {
  final double? bullish;
  final double? bearish;
  const IrisAssetOutlook({this.bullish, this.bearish});
  IrisAssetOutlook copyWith({double? bullish, double? bearish}) {
    return IrisAssetOutlook(
      bullish: bullish ?? this.bullish,
      bearish: bearish ?? this.bearish,
    );
  }

  factory IrisAssetOutlook.fromJson(Map<String, dynamic> json) {
    return IrisAssetOutlook(
      bullish: json['bullish']?.toDouble(),
      bearish: json['bearish']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['bullish'] = bullish;
    data['bearish'] = bearish;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IrisAssetOutlook &&
            (identical(other.bullish, bullish) ||
                const DeepCollectionEquality()
                    .equals(other.bullish, bullish)) &&
            (identical(other.bearish, bearish) ||
                const DeepCollectionEquality().equals(other.bearish, bearish)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(bullish) ^
        const DeepCollectionEquality().hash(bearish);
  }

  @override
  String toString() => 'IrisAssetOutlook(${toJson()})';
}
