import 'package:collection/collection.dart';

class OutlookDivision {
  final double? bearPercentage;
  final double? bullPercentage;
  final double? nuetralPercentage;
  const OutlookDivision(
      {this.bearPercentage, this.bullPercentage, this.nuetralPercentage});
  OutlookDivision copyWith(
      {double? bearPercentage,
      double? bullPercentage,
      double? nuetralPercentage}) {
    return OutlookDivision(
      bearPercentage: bearPercentage ?? this.bearPercentage,
      bullPercentage: bullPercentage ?? this.bullPercentage,
      nuetralPercentage: nuetralPercentage ?? this.nuetralPercentage,
    );
  }

  factory OutlookDivision.fromJson(Map<String, dynamic> json) {
    return OutlookDivision(
      bearPercentage: json['bearPercentage']?.toDouble(),
      bullPercentage: json['bullPercentage']?.toDouble(),
      nuetralPercentage: json['nuetralPercentage']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['bearPercentage'] = bearPercentage;
    data['bullPercentage'] = bullPercentage;
    data['nuetralPercentage'] = nuetralPercentage;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OutlookDivision &&
            (identical(other.bearPercentage, bearPercentage) ||
                const DeepCollectionEquality()
                    .equals(other.bearPercentage, bearPercentage)) &&
            (identical(other.bullPercentage, bullPercentage) ||
                const DeepCollectionEquality()
                    .equals(other.bullPercentage, bullPercentage)) &&
            (identical(other.nuetralPercentage, nuetralPercentage) ||
                const DeepCollectionEquality()
                    .equals(other.nuetralPercentage, nuetralPercentage)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(bearPercentage) ^
        const DeepCollectionEquality().hash(bullPercentage) ^
        const DeepCollectionEquality().hash(nuetralPercentage);
  }

  @override
  String toString() => 'OutlookDivision(${toJson()})';
}
