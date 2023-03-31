import 'package:collection/collection.dart';

class TestMessage {
  final int? testMessageKey;
  final String? value;
  const TestMessage({this.testMessageKey, this.value});
  TestMessage copyWith({int? testMessageKey, String? value}) {
    return TestMessage(
      testMessageKey: testMessageKey ?? this.testMessageKey,
      value: value ?? this.value,
    );
  }

  factory TestMessage.fromJson(Map<String, dynamic> json) {
    return TestMessage(
      testMessageKey: json['testMessageKey'],
      value: json['value'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['testMessageKey'] = testMessageKey;
    data['value'] = value;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TestMessage &&
            (identical(other.testMessageKey, testMessageKey) ||
                const DeepCollectionEquality()
                    .equals(other.testMessageKey, testMessageKey)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(testMessageKey) ^
        const DeepCollectionEquality().hash(value);
  }

  @override
  String toString() => 'TestMessage(${toJson()})';
}
