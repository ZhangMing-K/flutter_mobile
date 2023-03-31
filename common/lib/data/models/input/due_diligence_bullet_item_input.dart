import 'package:collection/collection.dart';

class DueDiligenceBulletItemInput {
  final String? value;
  final String? description;
  const DueDiligenceBulletItemInput({required this.value, this.description});
  DueDiligenceBulletItemInput copyWith({String? value, String? description}) {
    return DueDiligenceBulletItemInput(
      value: value ?? this.value,
      description: description ?? this.description,
    );
  }

  factory DueDiligenceBulletItemInput.fromJson(Map<String, dynamic> json) {
    return DueDiligenceBulletItemInput(
      value: json['value'],
      description: json['description'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['description'] = description;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligenceBulletItemInput &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(value) ^
        const DeepCollectionEquality().hash(description);
  }

  @override
  String toString() => 'DueDiligenceBulletItemInput(${toJson()})';
}
