import 'package:iris_common/data/models/output/workspace.dart';
import 'package:collection/collection.dart';

class WorkspaceUpdateResponse {
  final Workspace? workspace;
  const WorkspaceUpdateResponse({this.workspace});
  WorkspaceUpdateResponse copyWith({Workspace? workspace}) {
    return WorkspaceUpdateResponse(
      workspace: workspace ?? this.workspace,
    );
  }

  factory WorkspaceUpdateResponse.fromJson(Map<String, dynamic> json) {
    return WorkspaceUpdateResponse(
      workspace: json['workspace'] != null
          ? Workspace.fromJson(json['workspace'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['workspace'] = workspace?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspaceUpdateResponse &&
            (identical(other.workspace, workspace) ||
                const DeepCollectionEquality()
                    .equals(other.workspace, workspace)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(workspace);
  }

  @override
  String toString() => 'WorkspaceUpdateResponse(${toJson()})';
}
