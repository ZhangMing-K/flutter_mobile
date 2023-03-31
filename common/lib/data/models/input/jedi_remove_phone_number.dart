import 'package:collection/collection.dart';

class JediRemovePhoneNumber {
  final String? phoneNumber;
  const JediRemovePhoneNumber({required this.phoneNumber});
  JediRemovePhoneNumber copyWith({String? phoneNumber}) {
    return JediRemovePhoneNumber(
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory JediRemovePhoneNumber.fromJson(Map<String, dynamic> json) {
    return JediRemovePhoneNumber(
      phoneNumber: json['phoneNumber'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediRemovePhoneNumber &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(phoneNumber);
  }

  @override
  String toString() => 'JediRemovePhoneNumber(${toJson()})';
}
