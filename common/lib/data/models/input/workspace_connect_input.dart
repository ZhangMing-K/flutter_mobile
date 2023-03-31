import 'package:iris_common/data/models/enums/workspace_source.dart';
import 'package:iris_common/data/models/enums/order_posting_permissions.dart';
import 'package:collection/collection.dart';

class WorkspaceConnectInput {
  final String? token;
  final String? remoteId;
  final int? integrationKey;
  final WORKSPACE_SOURCE? source;
  final ORDER_POSTING_PERMISSIONS? orderPostingPermission;
  const WorkspaceConnectInput(
      {this.token,
      this.remoteId,
      this.integrationKey,
      this.source,
      this.orderPostingPermission});
  WorkspaceConnectInput copyWith(
      {String? token,
      String? remoteId,
      int? integrationKey,
      WORKSPACE_SOURCE? source,
      ORDER_POSTING_PERMISSIONS? orderPostingPermission}) {
    return WorkspaceConnectInput(
      token: token ?? this.token,
      remoteId: remoteId ?? this.remoteId,
      integrationKey: integrationKey ?? this.integrationKey,
      source: source ?? this.source,
      orderPostingPermission:
          orderPostingPermission ?? this.orderPostingPermission,
    );
  }

  factory WorkspaceConnectInput.fromJson(Map<String, dynamic> json) {
    return WorkspaceConnectInput(
      token: json['token'],
      remoteId: json['remoteId'],
      integrationKey: json['integrationKey'],
      source: json['source'] != null
          ? WORKSPACE_SOURCE.values.byName(json['source'])
          : null,
      orderPostingPermission: json['orderPostingPermission'] != null
          ? ORDER_POSTING_PERMISSIONS.values
              .byName(json['orderPostingPermission'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['remoteId'] = remoteId;
    data['integrationKey'] = integrationKey;
    data['source'] = source?.name;
    data['orderPostingPermission'] = orderPostingPermission?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspaceConnectInput &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.integrationKey, integrationKey) ||
                const DeepCollectionEquality()
                    .equals(other.integrationKey, integrationKey)) &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.orderPostingPermission, orderPostingPermission) ||
                const DeepCollectionEquality().equals(
                    other.orderPostingPermission, orderPostingPermission)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(token) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(integrationKey) ^
        const DeepCollectionEquality().hash(source) ^
        const DeepCollectionEquality().hash(orderPostingPermission);
  }

  @override
  String toString() => 'WorkspaceConnectInput(${toJson()})';
}
