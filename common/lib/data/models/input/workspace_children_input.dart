import 'package:iris_common/data/models/enums/workspace_type.dart';
import 'package:collection/collection.dart';

class WorkspaceChildrenInput {
  final int? limit;
  final int? offset;
  final bool? botEnabled;
  final List<WORKSPACE_TYPE>? workspaceTypes;
  const WorkspaceChildrenInput(
      {this.limit, this.offset, this.botEnabled, this.workspaceTypes});
  WorkspaceChildrenInput copyWith(
      {int? limit,
      int? offset,
      bool? botEnabled,
      List<WORKSPACE_TYPE>? workspaceTypes}) {
    return WorkspaceChildrenInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      botEnabled: botEnabled ?? this.botEnabled,
      workspaceTypes: workspaceTypes ?? this.workspaceTypes,
    );
  }

  factory WorkspaceChildrenInput.fromJson(Map<String, dynamic> json) {
    return WorkspaceChildrenInput(
      limit: json['limit'],
      offset: json['offset'],
      botEnabled: json['botEnabled'],
      workspaceTypes: json['workspaceTypes']
          ?.map<WORKSPACE_TYPE>((o) => WORKSPACE_TYPE.values.byName(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['botEnabled'] = botEnabled;
    data['workspaceTypes'] = workspaceTypes?.map((item) => item.name).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspaceChildrenInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.botEnabled, botEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.botEnabled, botEnabled)) &&
            (identical(other.workspaceTypes, workspaceTypes) ||
                const DeepCollectionEquality()
                    .equals(other.workspaceTypes, workspaceTypes)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(botEnabled) ^
        const DeepCollectionEquality().hash(workspaceTypes);
  }

  @override
  String toString() => 'WorkspaceChildrenInput(${toJson()})';
}
