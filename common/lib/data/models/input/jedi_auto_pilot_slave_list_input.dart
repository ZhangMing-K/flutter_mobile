import 'package:collection/collection.dart';

class JediAutoPilotSlaveListInput {
  final int? page;
  const JediAutoPilotSlaveListInput({this.page});
  JediAutoPilotSlaveListInput copyWith({int? page}) {
    return JediAutoPilotSlaveListInput(
      page: page ?? this.page,
    );
  }

  factory JediAutoPilotSlaveListInput.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotSlaveListInput(
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
        (other is JediAutoPilotSlaveListInput &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(page);
  }

  @override
  String toString() => 'JediAutoPilotSlaveListInput(${toJson()})';
}
