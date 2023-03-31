import 'package:iris_common/data/models/enums/setup_status.dart';
import 'package:collection/collection.dart';

class SlaveAutoPilotPortfoliosGetInput {
  final int? autoPilotSettingsKey;
  final List<SETUP_STATUS>? setupStatuses;
  const SlaveAutoPilotPortfoliosGetInput(
      {this.autoPilotSettingsKey, this.setupStatuses});
  SlaveAutoPilotPortfoliosGetInput copyWith(
      {int? autoPilotSettingsKey, List<SETUP_STATUS>? setupStatuses}) {
    return SlaveAutoPilotPortfoliosGetInput(
      autoPilotSettingsKey: autoPilotSettingsKey ?? this.autoPilotSettingsKey,
      setupStatuses: setupStatuses ?? this.setupStatuses,
    );
  }

  factory SlaveAutoPilotPortfoliosGetInput.fromJson(Map<String, dynamic> json) {
    return SlaveAutoPilotPortfoliosGetInput(
      autoPilotSettingsKey: json['autoPilotSettingsKey'],
      setupStatuses: json['setupStatuses']
          ?.map<SETUP_STATUS>((o) => SETUP_STATUS.values.byName(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotSettingsKey'] = autoPilotSettingsKey;
    data['setupStatuses'] = setupStatuses?.map((item) => item.name).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SlaveAutoPilotPortfoliosGetInput &&
            (identical(other.autoPilotSettingsKey, autoPilotSettingsKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotSettingsKey, autoPilotSettingsKey)) &&
            (identical(other.setupStatuses, setupStatuses) ||
                const DeepCollectionEquality()
                    .equals(other.setupStatuses, setupStatuses)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotSettingsKey) ^
        const DeepCollectionEquality().hash(setupStatuses);
  }

  @override
  String toString() => 'SlaveAutoPilotPortfoliosGetInput(${toJson()})';
}
