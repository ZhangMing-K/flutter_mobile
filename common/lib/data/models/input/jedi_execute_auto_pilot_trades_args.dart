import 'package:collection/collection.dart';

class JediExecuteAutoPilotTradesArgs {
  final List<int>? autoPilotOrderKeys;
  final bool? retry;
  const JediExecuteAutoPilotTradesArgs(
      {required this.autoPilotOrderKeys, required this.retry});
  JediExecuteAutoPilotTradesArgs copyWith(
      {List<int>? autoPilotOrderKeys, bool? retry}) {
    return JediExecuteAutoPilotTradesArgs(
      autoPilotOrderKeys: autoPilotOrderKeys ?? this.autoPilotOrderKeys,
      retry: retry ?? this.retry,
    );
  }

  factory JediExecuteAutoPilotTradesArgs.fromJson(Map<String, dynamic> json) {
    return JediExecuteAutoPilotTradesArgs(
      autoPilotOrderKeys:
          json['autoPilotOrderKeys']?.map<int>((o) => (o as int)).toList(),
      retry: json['retry'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotOrderKeys'] = autoPilotOrderKeys;
    data['retry'] = retry;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediExecuteAutoPilotTradesArgs &&
            (identical(other.autoPilotOrderKeys, autoPilotOrderKeys) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotOrderKeys, autoPilotOrderKeys)) &&
            (identical(other.retry, retry) ||
                const DeepCollectionEquality().equals(other.retry, retry)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotOrderKeys) ^
        const DeepCollectionEquality().hash(retry);
  }

  @override
  String toString() => 'JediExecuteAutoPilotTradesArgs(${toJson()})';
}
