import 'package:collection/collection.dart';

class InfoSearchInput {
  final List<String>? infoNames;
  const InfoSearchInput({this.infoNames});
  InfoSearchInput copyWith({List<String>? infoNames}) {
    return InfoSearchInput(
      infoNames: infoNames ?? this.infoNames,
    );
  }

  factory InfoSearchInput.fromJson(Map<String, dynamic> json) {
    return InfoSearchInput(
      infoNames: json['infoNames']?.map<String>((o) => o.toString()).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['infoNames'] = infoNames;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InfoSearchInput &&
            (identical(other.infoNames, infoNames) ||
                const DeepCollectionEquality()
                    .equals(other.infoNames, infoNames)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(infoNames);
  }

  @override
  String toString() => 'InfoSearchInput(${toJson()})';
}
