import 'package:collection/collection.dart';

class Hashtag {
  final int? hashtagKey;
  final String? value;
  const Hashtag({this.hashtagKey, this.value});
  Hashtag copyWith({int? hashtagKey, String? value}) {
    return Hashtag(
      hashtagKey: hashtagKey ?? this.hashtagKey,
      value: value ?? this.value,
    );
  }

  factory Hashtag.fromJson(Map<String, dynamic> json) {
    return Hashtag(
      hashtagKey: json['hashtagKey'],
      value: json['value'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['hashtagKey'] = hashtagKey;
    data['value'] = value;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Hashtag &&
            (identical(other.hashtagKey, hashtagKey) ||
                const DeepCollectionEquality()
                    .equals(other.hashtagKey, hashtagKey)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(hashtagKey) ^
        const DeepCollectionEquality().hash(value);
  }

  @override
  String toString() => 'Hashtag(${toJson()})';
}
