import 'package:collection/collection.dart';

class WorkspacesSyncInput {
  final int? integrationKey;
  const WorkspacesSyncInput({this.integrationKey});
  WorkspacesSyncInput copyWith({int? integrationKey}) {
    return WorkspacesSyncInput(
      integrationKey: integrationKey ?? this.integrationKey,
    );
  }

  factory WorkspacesSyncInput.fromJson(Map<String, dynamic> json) {
    return WorkspacesSyncInput(
      integrationKey: json['integrationKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['integrationKey'] = integrationKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspacesSyncInput &&
            (identical(other.integrationKey, integrationKey) ||
                const DeepCollectionEquality()
                    .equals(other.integrationKey, integrationKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(integrationKey);
  }

  @override
  String toString() => 'WorkspacesSyncInput(${toJson()})';
}
