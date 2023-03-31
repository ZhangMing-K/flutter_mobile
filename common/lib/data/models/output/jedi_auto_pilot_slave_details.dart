import 'package:iris_common/data/models/output/jedi_auto_pilot_position.dart';
import 'package:collection/collection.dart';

class JediAutoPilotSlaveDetails {
  final int? autoPilotSettingsKey;
  final int? userKey;
  final String? userName;
  final int? portfolioKey;
  final List<JediAutoPilotPosition>? positions;
  const JediAutoPilotSlaveDetails(
      {required this.autoPilotSettingsKey,
      required this.userKey,
      required this.userName,
      required this.portfolioKey,
      this.positions});
  JediAutoPilotSlaveDetails copyWith(
      {int? autoPilotSettingsKey,
      int? userKey,
      String? userName,
      int? portfolioKey,
      List<JediAutoPilotPosition>? positions}) {
    return JediAutoPilotSlaveDetails(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      userKey: userKey ?? this.userKey,
      userName: userName ?? this.userName,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      positions: positions ?? this.positions,
    );
  }

  factory JediAutoPilotSlaveDetails.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotSlaveDetails(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      userKey: json['userKey'],
      userName: json['userName'],
      portfolioKey: json['portfolioKey'],
      positions: json['positions']
          ?.map<JediAutoPilotPosition>((o) => JediAutoPilotPosition.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['userKey'] = userKey;
    data['userName'] = userName;
    data['portfolioKey'] = portfolioKey;
    data['positions'] = positions?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotSlaveDetails &&
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
            (identical(other.positions, positions) ||
                const DeepCollectionEquality()
                    .equals(other.positions, positions)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(userName) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(positions);
  }

  @override
  String toString() => 'JediAutoPilotSlaveDetails(${toJson()})';
}
