import 'package:collection/collection.dart';

class WorkspacesWithoutBotInput {
  final int? limit;
  final int? offset;
  const WorkspacesWithoutBotInput({this.limit, this.offset});
  WorkspacesWithoutBotInput copyWith({int? limit, int? offset}) {
    return WorkspacesWithoutBotInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory WorkspacesWithoutBotInput.fromJson(Map<String, dynamic> json) {
    return WorkspacesWithoutBotInput(
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspacesWithoutBotInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'WorkspacesWithoutBotInput(${toJson()})';
}
