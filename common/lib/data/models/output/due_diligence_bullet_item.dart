import 'package:collection/collection.dart';

class DueDiligenceBulletItem {
  final String? value;
  final String? description;
  const DueDiligenceBulletItem({this.value, this.description});
  DueDiligenceBulletItem copyWith({String? value, String? description}) {
    return DueDiligenceBulletItem(
      value: value ?? this.value,
      description: description ?? this.description,
    );
  }

  factory DueDiligenceBulletItem.fromJson(Map<String, dynamic> json) {
    return DueDiligenceBulletItem(
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
        (other is DueDiligenceBulletItem &&
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
  String toString() => 'DueDiligenceBulletItem(${toJson()})';
}
