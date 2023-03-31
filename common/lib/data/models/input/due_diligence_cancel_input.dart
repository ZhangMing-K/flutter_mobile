import 'package:collection/collection.dart';

class DueDiligenceCancelInput {
  final int? dueDiligenceKey;
  final String? reason;
  const DueDiligenceCancelInput(
      {required this.dueDiligenceKey, required this.reason});
  DueDiligenceCancelInput copyWith({int? dueDiligenceKey, String? reason}) {
    return DueDiligenceCancelInput(
      dueDiligenceKey: dueDiligenceKey ?? this.dueDiligenceKey,
      reason: reason ?? this.reason,
    );
  }

  factory DueDiligenceCancelInput.fromJson(Map<String, dynamic> json) {
    return DueDiligenceCancelInput(
      dueDiligenceKey: json['dueDiligenceKey'],
      reason: json['reason'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['dueDiligenceKey'] = dueDiligenceKey;
    data['reason'] = reason;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligenceCancelInput &&
            (identical(other.dueDiligenceKey, dueDiligenceKey) ||
                const DeepCollectionEquality()
                    .equals(other.dueDiligenceKey, dueDiligenceKey)) &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(dueDiligenceKey) ^
        const DeepCollectionEquality().hash(reason);
  }

  @override
  String toString() => 'DueDiligenceCancelInput(${toJson()})';
}
