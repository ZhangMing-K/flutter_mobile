import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/modules/user_stories/controllers/user_stories_you_controller.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/contacts_permission/controllers/contacts_permission_controller.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/invited_by/controllers/invited_by_controller.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/picture_and_full_name/controllers/picture_and_full_name_controller.dart';

import '../controllers/feed_controller.dart';
import '../modules/posts/controllers/following_feed_controller.dart';
import '../modules/posts/controllers/posts_controller.dart';
import '../modules/text/text_controller.dart';
import '../modules/user_stories/controllers/user_stories_user_controller.dart';

class FeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IFeedRepository>(FeedRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));

    Get.put<INotificationRepository>(NotificationRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));

    Get.put<ISearchRepository>(SearchRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));

    Get.put<IProfileRepository>(ProfileRepository(remoteProvider: Get.find()));

    Get.put<IAssetViewRepository>(AssetViewRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));
    Get.put(
      SearchRepository(
        remoteProvider: Get.find(),
        repository: Get.find(),
      ),
    );
    // Get.put(WhoToFollowController(repository: Get.find(), storage: Get.find()));

    Get.put(PictureAndFullNameController(
      authUserStore: Get.find(),
      searchRepository: Get.find(),
      storageService: Get.find(),
      userService: Get.find(),
      authService: Get.find(),
    ));
    Get.put(ContactsPermissionController());
    Get.put(InvitedByController(userContactService: Get.find()));

    // Get.put(AssetStoriesAssetController(
    //   repository: Get.find(),
    //   authUserStore: Get.find(),
    // ));
    Get.put(UserStoriesUserController(
        repository: Get.find(), authUserStore: Get.find()));
    Get.put(UserStoriesYouController(
        repository: Get.find(), authUserStore: Get.find()));
    Get.put(
      PostsController(
        repository: Get.find(),
        //     assetStoriesController: Get.find(),
        irisEvent: Get.find(), storage: Get.find(),
        searchRepository: Get.find(),
      ),
    );

    Get.put(FollowingFeedController(
        repository: Get.find(),
        searchRepository: Get.find(),
        userStoriesController: Get.find()));
    Get.put(UpdateCheckerService());

    Get.put(
        BottomNavBarController(authUserStore: Get.find(), storage: Get.find()));

    Get.put(FeedController(
        newPostsController: Get.find(),
        homeController: Get.find(),
        repository: Get.find(),
        authUserStore: Get.find(),
        irisEvent: Get.find(),
        updateChecker: Get.find(),
        pushNotificationService: Get.find(),
        userStoryController: Get.find(),
        //  assetStoriesAssetController: Get.find(),
        secureStorage: Get.put(SecureStorage())));

    Get.create(() => TextController());
  }
}
