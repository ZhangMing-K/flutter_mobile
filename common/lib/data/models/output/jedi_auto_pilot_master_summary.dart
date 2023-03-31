import 'package:collection/collection.dart';

class JediAutoPilotMasterSummary {
  final int? userKey;
  final int? portfolioKey;
  final String? userName;
  final int? slaveCount;
  final double? totalCostBasis;
  const JediAutoPilotMasterSummary(
      {required this.userKey,
      required this.portfolioKey,
      required this.userName,
      required this.slaveCount,
      required this.totalCostBasis});
  JediAutoPilotMasterSummary copyWith(
      {int? userKey,
      int? portfolioKey,
      String? userName,
      int? slaveCount,
      double? totalCostBasis}) {
    return JediAutoPilotMasterSummary(
      userKey: userKey ?? this.userKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      userName: userName ?? this.userName,
      slaveCount: slaveCount ?? this.slaveCount,
      totalCostBasis: totalCostBasis ?? this.totalCostBasis,
    );
  }

  factory JediAutoPilotMasterSummary.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotMasterSummary(
      userKey: json['userKey'],
      portfolioKey: json['portfolioKey'],
      userName: json['userName'],
      slaveCount: json['slaveCount'],
      totalCostBasis: json['totalCostBasis']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['portfolioKey'] = portfolioKey;
    data['userName'] = userName;
    data['slaveCount'] = slaveCount;
    data['totalCostBasis'] = totalCostBasis;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotMasterSummary &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.userName, userName) ||
                const DeepCollectionEquality()
                    .equals(other.userName, userName)) &&
            (identical(other.slaveCount, slaveCount) ||
                const DeepCollectionEquality()
                    .equals(other.slaveCount, slaveCount)) &&
            (identical(other.totalCostBasis, totalCostBasis) ||
                const DeepCollectionEquality()
                    .equals(other.totalCostBasis, totalCostBasis)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(userName) ^
        const DeepCollectionEquality().hash(slaveCount) ^
        const DeepCollectionEquality().hash(totalCostBasis);
  }

  @override
  String toString() => 'JediAutoPilotMasterSummary(${toJson()})';
}
