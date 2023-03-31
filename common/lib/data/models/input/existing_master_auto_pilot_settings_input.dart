import 'package:collection/collection.dart';

class ExistingMasterAutoPilotSettingsInput {
  final int? masterPortfolioKey;
  const ExistingMasterAutoPilotSettingsInput(
      {required this.masterPortfolioKey});
  ExistingMasterAutoPilotSettingsInput copyWith({int? masterPortfolioKey}) {
    return ExistingMasterAutoPilotSettingsInput(
      masterPortfolioKey: masterPortfolioKey ?? this.masterPortfolioKey,
    );
  }

  factory ExistingMasterAutoPilotSettingsInput.fromJson(
      Map<String, dynamic> json) {
    return ExistingMasterAutoPilotSettingsInput(
      masterPortfolioKey: json['masterPortfolioKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['masterPortfolioKey'] = masterPortfolioKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ExistingMasterAutoPilotSettingsInput &&
            (identical(other.masterPortfolioKey, masterPortfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.masterPortfolioKey, masterPortfolioKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(masterPortfolioKey);
  }

  @override
  String toString() => 'ExistingMasterAutoPilotSettingsInput(${toJson()})';
}
