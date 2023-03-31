import 'package:collection/collection.dart';

class WorkspacesGetInput {
  final List<int>? workspaceKeys;
  const WorkspacesGetInput({this.workspaceKeys});
  WorkspacesGetInput copyWith({List<int>? workspaceKeys}) {
    return WorkspacesGetInput(
      workspaceKeys: workspaceKeys ?? this.workspaceKeys,
    );
  }

  factory WorkspacesGetInput.fromJson(Map<String, dynamic> json) {
    return WorkspacesGetInput(
      workspaceKeys:
          json['workspaceKeys']?.map<int>((o) => (o as int)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['workspaceKeys'] = workspaceKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspacesGetInput &&
            (identical(other.workspaceKeys, workspaceKeys) ||
                const DeepCollectionEquality()
                    .equals(other.workspaceKeys, workspaceKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(workspaceKeys);
  }

  @override
  String toString() => 'WorkspacesGetInput(${toJson()})';
}
