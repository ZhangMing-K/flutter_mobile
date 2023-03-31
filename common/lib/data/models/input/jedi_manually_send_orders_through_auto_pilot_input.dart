import 'package:collection/collection.dart';

class JediManuallySendOrdersThroughAutoPilotInput {
  final List<int>? orderKeys;
  const JediManuallySendOrdersThroughAutoPilotInput({required this.orderKeys});
  JediManuallySendOrdersThroughAutoPilotInput copyWith({List<int>? orderKeys}) {
    return JediManuallySendOrdersThroughAutoPilotInput(
      orderKeys: orderKeys ?? this.orderKeys,
    );
  }

  factory JediManuallySendOrdersThroughAutoPilotInput.fromJson(
      Map<String, dynamic> json) {
    return JediManuallySendOrdersThroughAutoPilotInput(
      orderKeys: json['orderKeys']?.map<int>((o) => o.toint()).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['orderKeys'] = orderKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediManuallySendOrdersThroughAutoPilotInput &&
            (identical(other.orderKeys, orderKeys) ||
                const DeepCollectionEquality()
                    .equals(other.orderKeys, orderKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(orderKeys);
  }

  @override
  String toString() =>
      'JediManuallySendOrdersThroughAutoPilotInput(${toJson()})';
}
