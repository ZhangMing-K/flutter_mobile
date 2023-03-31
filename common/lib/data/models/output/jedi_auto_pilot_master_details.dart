import 'package:iris_common/data/models/output/jedi_auto_pilot_position.dart';
import 'package:collection/collection.dart';

class JediAutoPilotMasterDetails {
  final int? userKey;
  final String? userName;
  final int? portfolioKey;
  final List<JediAutoPilotPosition>? positions;
  const JediAutoPilotMasterDetails(
      {required this.userKey,
      required this.userName,
      required this.portfolioKey,
      this.positions});
  JediAutoPilotMasterDetails copyWith(
      {int? userKey,
      String? userName,
      int? portfolioKey,
      List<JediAutoPilotPosition>? positions}) {
    return JediAutoPilotMasterDetails(
      userKey: userKey ?? this.userKey,
      userName: userName ?? this.userName,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      positions: positions ?? this.positions,
    );
  }

  factory JediAutoPilotMasterDetails.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotMasterDetails(
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
    data['userKey'] = userKey;
    data['userName'] = userName;
    data['portfolioKey'] = portfolioKey;
    data['positions'] = positions?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotMasterDetails &&
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
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(userName) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(positions);
  }

  @override
  String toString() => 'JediAutoPilotMasterDetails(${toJson()})';
}
