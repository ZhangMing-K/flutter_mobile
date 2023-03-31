import 'package:collection/collection.dart';

class JediAutoPilotMasterListInput {
  final int? page;
  const JediAutoPilotMasterListInput({this.page});
  JediAutoPilotMasterListInput copyWith({int? page}) {
    return JediAutoPilotMasterListInput(
      page: page ?? this.page,
    );
  }

  factory JediAutoPilotMasterListInput.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotMasterListInput(
      page: json['page'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotMasterListInput &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(page);
  }

  @override
  String toString() => 'JediAutoPilotMasterListInput(${toJson()})';
}
