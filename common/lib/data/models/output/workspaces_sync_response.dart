import 'package:collection/collection.dart';

class WorkspacesSyncResponse {
  final bool? success;
  const WorkspacesSyncResponse({this.success});
  WorkspacesSyncResponse copyWith({bool? success}) {
    return WorkspacesSyncResponse(
      success: success ?? this.success,
    );
  }

  factory WorkspacesSyncResponse.fromJson(Map<String, dynamic> json) {
    return WorkspacesSyncResponse(
      success: json['success'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspacesSyncResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(success);
  }

  @override
  String toString() => 'WorkspacesSyncResponse(${toJson()})';
}
