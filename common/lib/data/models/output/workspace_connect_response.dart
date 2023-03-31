import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/workspace.dart';
import 'package:collection/collection.dart';

class WorkspaceConnectResponse {
  final User? user;
  final List<Workspace>? workspaces;
  const WorkspaceConnectResponse({this.user, this.workspaces});
  WorkspaceConnectResponse copyWith({User? user, List<Workspace>? workspaces}) {
    return WorkspaceConnectResponse(
      user: user ?? this.user,
      workspaces: workspaces ?? this.workspaces,
    );
  }

  factory WorkspaceConnectResponse.fromJson(Map<String, dynamic> json) {
    return WorkspaceConnectResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      workspaces: json['workspaces']
          ?.map<Workspace>((o) => Workspace.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['workspaces'] = workspaces?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspaceConnectResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.workspaces, workspaces) ||
                const DeepCollectionEquality()
                    .equals(other.workspaces, workspaces)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(workspaces);
  }

  @override
  String toString() => 'WorkspaceConnectResponse(${toJson()})';
}
