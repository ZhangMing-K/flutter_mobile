import 'package:iris_common/data/models/enums/workspace_source.dart';
import 'package:collection/collection.dart';

class ChildWorkspacesInput {
  final List<WORKSPACE_SOURCE>? source;
  final int? parentWorkspaceKey;
  final bool? botEnabled;
  final int? limit;
  final int? offset;
  const ChildWorkspacesInput(
      {this.source,
      this.parentWorkspaceKey,
      this.botEnabled,
      this.limit,
      this.offset});
  ChildWorkspacesInput copyWith(
      {List<WORKSPACE_SOURCE>? source,
      int? parentWorkspaceKey,
      bool? botEnabled,
      int? limit,
      int? offset}) {
    return ChildWorkspacesInput(
      source: source ?? this.source,
      parentWorkspaceKey: parentWorkspaceKey ?? this.parentWorkspaceKey,
      botEnabled: botEnabled ?? this.botEnabled,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory ChildWorkspacesInput.fromJson(Map<String, dynamic> json) {
    return ChildWorkspacesInput(
      source: json['source']
          ?.map<WORKSPACE_SOURCE>((o) => WORKSPACE_SOURCE.values.byName(o))
          .toList(),
      parentWorkspaceKey: json['parentWorkspaceKey'],
      botEnabled: json['botEnabled'],
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['source'] = source?.map((item) => item.name).toList();
    data['parentWorkspaceKey'] = parentWorkspaceKey;
    data['botEnabled'] = botEnabled;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChildWorkspacesInput &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.parentWorkspaceKey, parentWorkspaceKey) ||
                const DeepCollectionEquality()
                    .equals(other.parentWorkspaceKey, parentWorkspaceKey)) &&
            (identical(other.botEnabled, botEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.botEnabled, botEnabled)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(source) ^
        const DeepCollectionEquality().hash(parentWorkspaceKey) ^
        const DeepCollectionEquality().hash(botEnabled) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'ChildWorkspacesInput(${toJson()})';
}
