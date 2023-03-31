import 'package:collection/collection.dart';

class DueDiligenceDeleteInput {
  final int? dueDiligenceKey;
  const DueDiligenceDeleteInput({required this.dueDiligenceKey});
  DueDiligenceDeleteInput copyWith({int? dueDiligenceKey}) {
    return DueDiligenceDeleteInput(
      dueDiligenceKey: dueDiligenceKey ?? this.dueDiligenceKey,
    );
  }

  factory DueDiligenceDeleteInput.fromJson(Map<String, dynamic> json) {
    return DueDiligenceDeleteInput(
      dueDiligenceKey: json['dueDiligenceKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['dueDiligenceKey'] = dueDiligenceKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligenceDeleteInput &&
            (identical(other.dueDiligenceKey, dueDiligenceKey) ||
                const DeepCollectionEquality()
                    .equals(other.dueDiligenceKey, dueDiligenceKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(dueDiligenceKey);
  }

  @override
  String toString() => 'DueDiligenceDeleteInput(${toJson()})';
}
