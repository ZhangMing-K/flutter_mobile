import 'package:collection/collection.dart';

class AutoPilotSettingsDeleteInput {
  final int? autoPilotSettingsKey;
  final bool? sellOutPortfolio;
  const AutoPilotSettingsDeleteInput(
      {required this.autoPilotSettingsKey, this.sellOutPortfolio});
  AutoPilotSettingsDeleteInput copyWith(
      {int? autoPilotSettingsKey, bool? sellOutPortfolio}) {
    return AutoPilotSettingsDeleteInput(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      sellOutPortfolio: sellOutPortfolio ?? this.sellOutPortfolio,
    );
  }

  factory AutoPilotSettingsDeleteInput.fromJson(Map<String, dynamic> json) {
    return AutoPilotSettingsDeleteInput(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      sellOutPortfolio: json['sellOutPortfolio'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['sellOutPortfolio'] = sellOutPortfolio;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotSettingsDeleteInput &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.sellOutPortfolio, sellOutPortfolio) ||
                const DeepCollectionEquality()
                    .equals(other.sellOutPortfolio, sellOutPortfolio)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(sellOutPortfolio);
  }

  @override
  String toString() => 'AutoPilotSettingsDeleteInput(${toJson()})';
}
