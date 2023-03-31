import 'package:collection/collection.dart';

class Info {
  final int? infoKey;
  final String? infoName;
  final String? value;
  const Info({this.infoKey, this.infoName, this.value});
  Info copyWith({int? infoKey, String? infoName, String? value}) {
    return Info(
      infoKey: infoKey ?? this.infoKey,
      infoName: infoName ?? this.infoName,
      value: value ?? this.value,
    );
  }

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      infoKey: json['infoKey'],
      infoName: json['infoName'],
      value: json['value'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['infoKey'] = infoKey;
    data['infoName'] = infoName;
    data['value'] = value;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Info &&
            (identical(other.infoKey, infoKey) ||
                const DeepCollectionEquality()
                    .equals(other.infoKey, infoKey)) &&
            (identical(other.infoName, infoName) ||
                const DeepCollectionEquality()
                    .equals(other.infoName, infoName)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(infoKey) ^
        const DeepCollectionEquality().hash(infoName) ^
        const DeepCollectionEquality().hash(value);
  }

  @override
  String toString() => 'Info(${toJson()})';
}
