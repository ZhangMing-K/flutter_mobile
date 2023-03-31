import 'package:iris_common/data/models/enums/option_type.dart';
import 'package:collection/collection.dart';

class OptionInfo {
  final double? strikePrice;
  final OPTION_TYPE? optionType;
  final DateTime? expiresAt;
  const OptionInfo({this.strikePrice, this.optionType, this.expiresAt});
  OptionInfo copyWith(
      {double? strikePrice, OPTION_TYPE? optionType, DateTime? expiresAt}) {
    return OptionInfo(
      strikePrice: strikePrice ?? this.strikePrice,
      optionType: optionType ?? this.optionType,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  factory OptionInfo.fromJson(Map<String, dynamic> json) {
    return OptionInfo(
      strikePrice: json['strikePrice']?.toDouble(),
      optionType: json['optionType'] != null
          ? OPTION_TYPE.values.byName(json['optionType'])
          : null,
      expiresAt:
          json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['strikePrice'] = strikePrice;
    data['optionType'] = optionType?.name;
    data['expiresAt'] = expiresAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OptionInfo &&
            (identical(other.strikePrice, strikePrice) ||
                const DeepCollectionEquality()
                    .equals(other.strikePrice, strikePrice)) &&
            (identical(other.optionType, optionType) ||
                const DeepCollectionEquality()
                    .equals(other.optionType, optionType)) &&
            (identical(other.expiresAt, expiresAt) ||
                const DeepCollectionEquality()
                    .equals(other.expiresAt, expiresAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(strikePrice) ^
        const DeepCollectionEquality().hash(optionType) ^
        const DeepCollectionEquality().hash(expiresAt);
  }

  @override
  String toString() => 'OptionInfo(${toJson()})';
}
