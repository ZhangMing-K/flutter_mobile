import '../../iris_common.dart';

String getPermissionLevel(PERMISSION_LEVEL? permissionLevel) {
  switch (permissionLevel) {
    case PERMISSION_LEVEL.ADMIN:
      return 'Admin';
    case PERMISSION_LEVEL.OWNER:
      return 'Owner';
    default:
      return 'Admin';
  }
}
