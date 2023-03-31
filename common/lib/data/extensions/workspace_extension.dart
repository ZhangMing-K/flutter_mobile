import '../../iris_common.dart';

extension WorkspaceExt on Workspace {
  bool get authUserHasUpdatePermissions {
    final List<PERMISSION_LEVEL> allowedPermissions =
        [PERMISSION_LEVEL.ADMIN, PERMISSION_LEVEL.OWNER].toList();

    return allowedPermissions.contains(authUserPermissionLevel);
  }

  bool? get authUserMayAddPortfolio {
    return orderPostingPermission == ORDER_POSTING_PERMISSIONS.ADMIN_ONLY
        ? authUserHasUpdatePermissions && botEnabled! && botInChannel
        : botEnabled! && botInChannel;
  }

  get botInChannel {
    return botJoinedAt != null;
  }

  get channelName {
    return '# $name';
  }

  get imageUrl {
    if (pictureUrl == null) return null;

    final String urlBase = ENV.DISCORD_WEB_URL!;
    final String url = urlBase + '/icons/$remoteId/$pictureUrl.webp';

    return url;
  }

  get serverInitials {
    final nameArray = name!.split(' ');
    final initialsArray = nameArray.map((e) => e[0]);

    return initialsArray.join();
  }
}
