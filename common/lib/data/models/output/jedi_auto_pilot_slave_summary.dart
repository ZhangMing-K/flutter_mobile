import 'package:collection/collection.dart';

class JediAutoPilotSlaveSummary {
  final int? autoPilotSettingsKey;
  final int? userKey;
  final String? userName;
  final int? portfolioKey;
  final double? totalCostBasis;
  const JediAutoPilotSlaveSummary(
      {required this.autoPilotSettingsKey,
      required this.userKey,
      required this.userName,
      required this.portfolioKey,
      required this.totalCostBasis});
  JediAutoPilotSlaveSummary copyWith(
      {int? autoPilotSettingsKey,
      int? userKey,
      String? userName,
      int? portfolioKey,
      double? totalCostBasis}) {
    return JediAutoPilotSlaveSummary(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      userKey: userKey ?? this.userKey,
      userName: userName ?? this.userName,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      totalCostBasis: totalCostBasis ?? this.totalCostBasis,
    );
  }

  factory JediAutoPilotSlaveSummary.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotSlaveSummary(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      userKey: json['userKey'],
      userName: json['userName'],
      portfolioKey: json['portfolioKey'],
      totalCostBasis: json['totalCostBasis']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['userKey'] = userKey;
    data['userName'] = userName;
    data['portfolioKey'] = portfolioKey;
    data['totalCostBasis'] = totalCostBasis;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotSlaveSummary &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.userName, userName) ||
                const DeepCollectionEquality()
                    .equals(other.userName, userName)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.totalCostBasis, totalCostBasis) ||
                const DeepCollectionEquality()
                    .equals(other.totalCostBasis, totalCostBasis)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(userName) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(totalCostBasis);
  }

  @override
  String toString() => 'JediAutoPilotSlaveSummary(${toJson()})';
}
