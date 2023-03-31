import 'package:get/get.dart';

import '../../../iris_common.dart';

class LinkSocialsViewController extends GetxController {
  final SocialService socialService = Get.find();

  final IAuthUserService authUserStore = Get.find();
  RxList<SOCIAL_SOURCE> currentIntegrations$ = RxList([]);
  List<SOCIAL_SOURCE> integrationsToDisplay = [SOCIAL_SOURCE.TWITTER];
  LinkSocialsViewController() {
    setIntegrationList();
  }

  bool hasIntegration(SOCIAL_SOURCE? source) {
    final integration = authUserStore.loggedUser!.integrations
        ?.firstWhereOrNull((element) => element.source == source);
    return integration != null && integration.token != null ? true : false;
  }

  Future<void> linkSocial(SOCIAL_SOURCE source) async {
    final User? authUser = authUserStore.loggedUser?.copyWith();
    final oAuthKey = await Get.to(
        () => OauthWebViewContainer(
              url: oauthUrl(source),
              socialSource: source,
              clearCache: true,
            ),
        transition: Transition.cupertino);
    if (oAuthKey != null) {
      final integrations = await socialService.socialLink(source,
          token: oAuthKey['oauthToken'],
          verifierToken: oAuthKey['oauthVerifier']);

      if (integrations == null) return;

      if (authUser != null) {
        authUserStore
            .editUserData(authUser.copyWith(integrations: integrations));
      }

      final List<SOCIAL_SOURCE> newIntegrations = [];

      for (var element in authUserStore.loggedUser!.integrations!) {
        final elementSource = element.source;

        if (hasIntegration(elementSource)) {
          if (elementSource != null) {
            newIntegrations.add(elementSource);
          }
        }
      }

      currentIntegrations$.assignAll(newIntegrations);
    }
  }

  String oauthUrl(SOCIAL_SOURCE source) {
    switch (source) {
      case SOCIAL_SOURCE.TWITTER:
        return ENV.GRAPHQL_API_URL!
            .replaceAll('graphql', 'social/twitter/login');
      default:
        return ENV.GRAPHQL_API_URL!
            .replaceAll('graphql', 'social/twitter/login');
    }
  }

  setIntegrationList() {
    if (authUserStore.loggedUser!.integrations == null) return;

    final List<SOCIAL_SOURCE> newList = <SOCIAL_SOURCE>[];
    for (var element in authUserStore.loggedUser!.integrations!) {
      if (integrationsToDisplay.contains(element.source) &&
          element.token != null) newList.add(element.source!);
    }
    currentIntegrations$.assignAll(newList);
  }

  socialLogin(SOCIAL_SOURCE source) async {
    final bool linkAccount =
        currentIntegrations$.contains(source) ? false : true;
    if (linkAccount) {
      linkSocial(source);
    } else {
      unlinkSocial(source);
    }
  }

  Future<void> unlinkSocial(SOCIAL_SOURCE source) async {
    final User? authUser = authUserStore.loggedUser?.copyWith();
    Get.back();
    final integration = authUserStore.loggedUser!.integrations
        ?.firstWhereOrNull((element) => element.source == source);

    if (integration == null) return;

    final data = await socialService.socialLink(source,
        token: null,
        verifierToken: null,
        integrationKey: integration.integrationKey);

    if (data == null) return;

    final List<Integration> integrations = data.toList();

    authUser?.integrations?.assignAll(integrations);

    if (authUser != null) {
      authUserStore.editUserData(authUser);
    }

    final List<SOCIAL_SOURCE> integrationsAfterUnlink = [];

    for (var element in authUserStore.loggedUser!.integrations!) {
      if (hasIntegration(element.source)) {
        integrationsAfterUnlink.add(element.source!);
      }
    }
    currentIntegrations$.assignAll(integrationsAfterUnlink);
  }
}
