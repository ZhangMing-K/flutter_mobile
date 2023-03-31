import '../../iris_common.dart';

WORKSPACE_SOURCE convertSocialToWorkspace(SOCIAL_SOURCE social) {
  switch (social) {
    case SOCIAL_SOURCE.SLACK:
      return WORKSPACE_SOURCE.SLACK;
    case SOCIAL_SOURCE.DISCORD:
      return WORKSPACE_SOURCE.DISCORD;
    default:
      return WORKSPACE_SOURCE.DISCORD;
  }
}

SOCIAL_SOURCE convertWorkspaceToSocial(WORKSPACE_SOURCE? workspace) {
  switch (workspace) {
    case WORKSPACE_SOURCE.SLACK:
      return SOCIAL_SOURCE.SLACK;

    case WORKSPACE_SOURCE.DISCORD:
      return SOCIAL_SOURCE.DISCORD;

    default:
      return SOCIAL_SOURCE.DISCORD;
  }
}
