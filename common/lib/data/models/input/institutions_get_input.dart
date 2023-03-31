import 'package:collection/collection.dart';

class InstitutionsGetInput {
  final List<int>? intitutionKeys;
  const InstitutionsGetInput({required this.intitutionKeys});
  InstitutionsGetInput copyWith({List<int>? intitutionKeys}) {
    return InstitutionsGetInput(
      intitutionKeys: intitutionKeys ?? this.intitutionKeys,
    );
  }

  factory InstitutionsGetInput.fromJson(Map<String, dynamic> json) {
    return InstitutionsGetInput(
      intitutionKeys:
          json['intitutionKeys']?.map<int>((o) => (o as int)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['intitutionKeys'] = intitutionKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InstitutionsGetInput &&
            (identical(other.intitutionKeys, intitutionKeys) ||
                const DeepCollectionEquality()
                    .equals(other.intitutionKeys, intitutionKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(intitutionKeys);
  }

  @override
  String toString() => 'InstitutionsGetInput(${toJson()})';
}
