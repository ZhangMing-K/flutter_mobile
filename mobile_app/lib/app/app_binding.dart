import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iris_common/iris_common.dart';

import 'app_controller.dart';

class AppBinding {
  static Future<void> initServices({bool isTest = false}) async {
    //  Get.put(KeyboardListenerController());
    await Firebase.initializeApp();
    await Hive.initFlutter();

    // final hiveStorage = Get.put(HiveStorage());

    Get.lazyPut(() => KeyChainService(secureStorage: Get.find()));
    Get.lazyPut<IStorage>(() => Storage(secure: Get.find()));

    final deeplinkService = Get.put(DeeplinkService());

    Get.lazyPut(
      () => AuthService(
        iGraphqlProvider: Get.find(),
        keyChainService: Get.find(),
        deeplinkService: Get.find(),
      ),
    );

    final authUserStore = Get.put<IAuthUserService>(
      AuthUserService(
        // iGraphqlProvider: Get.find(),
        prefs: Get.find(),
        // pushNotificationService: Get.find(),
        irisEvent: Get.find<IrisEvent>(),
      ),
    );

    await authUserStore.init();

    Get.lazyPut<IGraphqlProvider>(
        () => GraphqlProvider(authUserStore: Get.find()));

    Get.put(PushNotificationService(
        iGraphqlProvider: Get.find(), authService: Get.find()));

    Get.put<IrisCacheInterface>(IrisCache(storage: Get.find()));
    Get.put(BaseRepository(cache: Get.find(), graphqlProvider: Get.find()));

    final IStorage database = Get.find();

    final connectivity = Get.put(IrisConnectivity());
    await connectivity.init();

    // hiveStorage.init();
    await database.init();

    await deeplinkService.handleDynamicLinks();

    Get.put(IrisImageCacheManager());

    Get.put(FollowService(iGraphqlProvider: Get.find()));
    Get.put(LeaderboardService());

    Get.put(NotificationService());
    Get.put(PortfolioService());

    Get.put(ReactionService());
    Get.put(PurcahseItemService());
    Get.put(SearchService());
    Get.put(StorageService());
    Get.put(UserService(
      iGraphqlProvider: Get.find(),
    ));
    Get.put(MfaContactService(
      authUserStore: Get.find(),
      iGraphqlProvider: Get.find(),
    ));
    Get.put(InstitutionService());

    Get.put(AssetService());
    Get.put(LocalAuthenticationService());
    Get.put(TradeAnalysisService());
    Get.put(FlagService());

    Get.put(UserContactService());
    Get.put(JediUserService());
    Get.put(SocialService());
    Get.put(UserRelationSerivce());
    Get.put(WorkspaceService());

    /// emit events to Rx from Workers
    Get.put(Events(), permanent: true);
    Get.put(CollectionService(iGraphqlProvider: Get.find()));
    Get.put(TextService(iGraphqlProvider: Get.find()));

    Get.put(AppController(
        storage: Get.find(),
        pushNotificationService: Get.find(),
        authUserStore: Get.find()));

    Get.put(BaseController());

    Get.put(SnackBarService());

    debugPrint('All services started...');
  }

  static Future<void> registerEventsDependencies() async {
    // inject implementation of SecureStorage
    Get.put<ISecureStorage>(SecureStorage());

    Get.lazyPut(() =>
        EventIGraphqlProvider(graphqlUrl: ENV.IRIS_EVENT_GRAPHQL_API_URL));
    Get.put<IrisEventService>(IrisEventService());
    Get.put(IrisEvent(
        eventIGraphqlProvider: Get.find(), irisEventService: Get.find()));
    Get.put(IrisErrorReport(
      irisEvent: Get.find<IrisEvent>(),
    ));
  }
}
