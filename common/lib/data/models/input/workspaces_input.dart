import 'package:iris_common/data/models/enums/workspace_source.dart';
import 'package:collection/collection.dart';

class WorkspacesInput {
  final List<WORKSPACE_SOURCE>? source;
  final int? limit;
  final int? offset;
  const WorkspacesInput({this.source, this.limit, this.offset});
  WorkspacesInput copyWith(
      {List<WORKSPACE_SOURCE>? source, int? limit, int? offset}) {
    return WorkspacesInput(
      source: source ?? this.source,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory WorkspacesInput.fromJson(Map<String, dynamic> json) {
    return WorkspacesInput(
      source: json['source']
          ?.map<WORKSPACE_SOURCE>((o) => WORKSPACE_SOURCE.values.byName(o))
          .toList(),
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['source'] = source?.map((item) => item.name).toList();
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspacesInput &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(source) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'WorkspacesInput(${toJson()})';
}
