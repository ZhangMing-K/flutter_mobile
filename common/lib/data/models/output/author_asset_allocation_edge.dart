import 'package:collection/collection.dart';

class AuthorAssetAllocationEdge {
  final double? bearishAmount;
  final double? bullishAmount;
  final double? bearishAllocation;
  final double? bullishAllocation;
  const AuthorAssetAllocationEdge(
      {this.bearishAmount,
      this.bullishAmount,
      this.bearishAllocation,
      this.bullishAllocation});
  AuthorAssetAllocationEdge copyWith(
      {double? bearishAmount,
      double? bullishAmount,
      double? bearishAllocation,
      double? bullishAllocation}) {
    return AuthorAssetAllocationEdge(
      bearishAmount: bearishAmount ?? this.bearishAmount,
      bullishAmount: bullishAmount ?? this.bullishAmount,
      bearishAllocation: bearishAllocation ?? this.bearishAllocation,
      bullishAllocation: bullishAllocation ?? this.bullishAllocation,
    );
  }

  factory AuthorAssetAllocationEdge.fromJson(Map<String, dynamic> json) {
    return AuthorAssetAllocationEdge(
      bearishAmount: json['bearishAmount']?.toDouble(),
      bullishAmount: json['bullishAmount']?.toDouble(),
      bearishAllocation: json['bearishAllocation']?.toDouble(),
      bullishAllocation: json['bullishAllocation']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['bearishAmount'] = bearishAmount;
    data['bullishAmount'] = bullishAmount;
    data['bearishAllocation'] = bearishAllocation;
    data['bullishAllocation'] = bullishAllocation;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AuthorAssetAllocationEdge &&
            (identical(other.bearishAmount, bearishAmount) ||
                const DeepCollectionEquality()
                    .equals(other.bearishAmount, bearishAmount)) &&
            (identical(other.bullishAmount, bullishAmount) ||
                const DeepCollectionEquality()
                    .equals(other.bullishAmount, bullishAmount)) &&
            (identical(other.bearishAllocation, bearishAllocation) ||
                const DeepCollectionEquality()
                    .equals(other.bearishAllocation, bearishAllocation)) &&
            (identical(other.bullishAllocation, bullishAllocation) ||
                const DeepCollectionEquality()
                    .equals(other.bullishAllocation, bullishAllocation)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(bearishAmount) ^
        const DeepCollectionEquality().hash(bullishAmount) ^
        const DeepCollectionEquality().hash(bearishAllocation) ^
        const DeepCollectionEquality().hash(bullishAllocation);
  }

  @override
  String toString() => 'AuthorAssetAllocationEdge(${toJson()})';
}
