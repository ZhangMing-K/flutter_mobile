import 'package:iris_common/data/models/output/workspace.dart';
import 'package:collection/collection.dart';

class WorkspacesGetResponse {
  final List<Workspace>? workspaces;
  const WorkspacesGetResponse({this.workspaces});
  WorkspacesGetResponse copyWith({List<Workspace>? workspaces}) {
    return WorkspacesGetResponse(
      workspaces: workspaces ?? this.workspaces,
    );
  }

  factory WorkspacesGetResponse.fromJson(Map<String, dynamic> json) {
    return WorkspacesGetResponse(
      workspaces: json['workspaces']
          ?.map<Workspace>((o) => Workspace.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['workspaces'] = workspaces?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspacesGetResponse &&
            (identical(other.workspaces, workspaces) ||
                const DeepCollectionEquality()
                    .equals(other.workspaces, workspaces)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(workspaces);
  }

  @override
  String toString() => 'WorkspacesGetResponse(${toJson()})';
}
