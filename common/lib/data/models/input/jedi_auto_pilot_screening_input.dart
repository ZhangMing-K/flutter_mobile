import 'package:collection/collection.dart';

class JediAutoPilotScreeningInput {
  final String? phoneNumber;
  final int? userKey;
  const JediAutoPilotScreeningInput({this.phoneNumber, this.userKey});
  JediAutoPilotScreeningInput copyWith({String? phoneNumber, int? userKey}) {
    return JediAutoPilotScreeningInput(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userKey: userKey ?? this.userKey,
    );
  }

  factory JediAutoPilotScreeningInput.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotScreeningInput(
      phoneNumber: json['phoneNumber'],
      userKey: json['userKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['userKey'] = userKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotScreeningInput &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality().equals(other.userKey, userKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(phoneNumber) ^
        const DeepCollectionEquality().hash(userKey);
  }

  @override
  String toString() => 'JediAutoPilotScreeningInput(${toJson()})';
}
