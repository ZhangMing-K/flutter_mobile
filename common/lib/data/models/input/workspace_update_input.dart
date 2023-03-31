import 'package:iris_common/data/models/input/order_posting_permissions_options.dart';
import 'package:collection/collection.dart';

class WorkspaceUpdateInput {
  final int? workspaceKey;
  final bool? botEnabled;
  final OrderPostingPermissionsOptions? orderPostingPermissionOptions;
  const WorkspaceUpdateInput(
      {this.workspaceKey, this.botEnabled, this.orderPostingPermissionOptions});
  WorkspaceUpdateInput copyWith(
      {int? workspaceKey,
      bool? botEnabled,
      OrderPostingPermissionsOptions? orderPostingPermissionOptions}) {
    return WorkspaceUpdateInput(
      workspaceKey: workspaceKey ?? this.workspaceKey,
      botEnabled: botEnabled ?? this.botEnabled,
      orderPostingPermissionOptions:
          orderPostingPermissionOptions ?? this.orderPostingPermissionOptions,
    );
  }

  factory WorkspaceUpdateInput.fromJson(Map<String, dynamic> json) {
    return WorkspaceUpdateInput(
      workspaceKey: json['workspaceKey'],
      botEnabled: json['botEnabled'],
      orderPostingPermissionOptions:
          json['orderPostingPermissionOptions'] != null
              ? OrderPostingPermissionsOptions.fromJson(
                  json['orderPostingPermissionOptions'])
              : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['workspaceKey'] = workspaceKey;
    data['botEnabled'] = botEnabled;
    data['orderPostingPermissionOptions'] =
        orderPostingPermissionOptions?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspaceUpdateInput &&
            (identical(other.workspaceKey, workspaceKey) ||
                const DeepCollectionEquality()
                    .equals(other.workspaceKey, workspaceKey)) &&
            (identical(other.botEnabled, botEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.botEnabled, botEnabled)) &&
            (identical(other.orderPostingPermissionOptions,
                    orderPostingPermissionOptions) ||
                const DeepCollectionEquality().equals(
                    other.orderPostingPermissionOptions,
                    orderPostingPermissionOptions)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(workspaceKey) ^
        const DeepCollectionEquality().hash(botEnabled) ^
        const DeepCollectionEquality().hash(orderPostingPermissionOptions);
  }

  @override
  String toString() => 'WorkspaceUpdateInput(${toJson()})';
}
