import 'package:collection/collection.dart';

class JediAutoPilotMasterDetailInput {
  final int? portfolioKey;
  const JediAutoPilotMasterDetailInput({required this.portfolioKey});
  JediAutoPilotMasterDetailInput copyWith({int? portfolioKey}) {
    return JediAutoPilotMasterDetailInput(
      portfolioKey: portfolioKey ?? this.portfolioKey,
    );
  }

  factory JediAutoPilotMasterDetailInput.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotMasterDetailInput(
      portfolioKey: json['portfolioKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioKey'] = portfolioKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotMasterDetailInput &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioKey);
  }

  @override
  String toString() => 'JediAutoPilotMasterDetailInput(${toJson()})';
}
