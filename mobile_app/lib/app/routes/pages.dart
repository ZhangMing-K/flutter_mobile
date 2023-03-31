import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/account/modules/payment-methods/bindings/payment_methods_binding.dart';
import 'package:iris_mobile/app/modules/account/modules/payment-methods/payment_methods.dart';
import 'package:iris_mobile/app/modules/account_portfolios/account_portfolios.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/bindings/analytics_order_flow_binding.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/views/analytics_order_flow.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-popular/bindings/analytics_popular_binding.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-popular/views/analytics_popular.dart';
import 'package:iris_mobile/app/modules/auto_pilot/auto_pilot.dart';
import 'package:iris_mobile/app/modules/auto_pilot/bindings/autopilot_binding.dart';
import 'package:iris_mobile/app/modules/deactivate/deactivate.dart';
import 'package:iris_mobile/app/modules/feed/modules/user_stories/views/user_stories_stories_view.dart';
import 'package:iris_mobile/app/modules/institution/connect_institution/bindings/connect_institution_binding.dart';
import 'package:iris_mobile/app/modules/institution/connect_institution/connect_institution.dart';
import 'package:iris_mobile/app/modules/institution/institution_connect_landing/bindings/institution_connect_landing_binding.dart';
import 'package:iris_mobile/app/modules/institution/institution_connect_landing/views/institution_connect_landing.dart';
import 'package:iris_mobile/app/modules/institution/select_institution/bindings/select_institution_binding.dart';
import 'package:iris_mobile/app/modules/institution/select_institution/view/select_institution_mobile.dart';
import 'package:iris_mobile/app/modules/leaderboard/bindings/leaderboard_binding.dart';
import 'package:iris_mobile/app/modules/leaderboard/leaderboard.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/build_your_community/bindings/build_your_community_binding.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/build_your_community/views/build_your_community.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/contacts_permission/bindings/contacts_permission_binding.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/contacts_permission/views/contacts_permission.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/enter_useremail/bindings/enter_useremail_binding.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/enter_useremail/views/enter_useremail.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/enter_username/bindings/enter_username_binding.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/enter_username/views/enter_username.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/invited_by/bindings/invited_by_binding.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/invited_by/views/invited_by.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/onboading_final/bindings/onboading_final_binding.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/onboading_final/views/onboading_final.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/phone_number_picker/bindings/phone_number_picker_binding.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/phone_number_picker/views/phone_number_picker.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/phone_number_verify/bindings/phone_number_verify_binding.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/phone_number_verify/views/phone_number_verify.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/picture_and_full_name/bindings/picture_and_full_name_binding.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/picture_and_full_name/views/picture_and_full_name.dart';
import 'package:iris_mobile/app/modules/profile/middlewares/profile_middleware.dart';
import 'package:iris_mobile/app/modules/referrals/referrals.dart';
import 'package:iris_mobile/app/modules/saved_feed/bindings/saved_feed_binding.dart';
import 'package:iris_mobile/app/modules/saved_feed/saved_feed.dart';
import 'package:iris_mobile/app/modules/search/bindings/search_binding.dart';
import 'package:iris_mobile/app/modules/search/search.dart';
import 'package:iris_mobile/app/modules/settings/settings.dart';
import 'package:iris_mobile/app/modules/splashscreen/bindings/splashscreen_binding.dart';
import 'package:iris_mobile/app/modules/splashscreen/middleware/splashscreen_middleware.dart';
import 'package:iris_mobile/app/modules/splashscreen/views/splashscreen_view.dart';
import 'package:iris_mobile/app/modules/story/bindings/story_binding.dart';
import 'package:iris_mobile/app/modules/story/single_user_stories_screen.dart';
import 'package:iris_mobile/app/modules/welcome/welcome.dart';

import '../modules/account/account.dart';
import '../modules/account/binding/account_binding.dart';
import '../modules/account/modules/notification_settings.dart/bindings/notification_settings_bindings.dart';
import '../modules/account/modules/notification_settings.dart/notification_settings.dart';
import '../modules/deactivate/deactivate_binding.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile.dart';
import '../modules/explore_friends/bindings/explore_friends_binding.dart';
import '../modules/explore_friends/explore_friends.dart';
import '../modules/explorer/bindings/explorer_binding.dart';
import '../modules/explorer/explorer.dart';
import '../modules/feed/bindings/feed_binding.dart';
import '../modules/feed/bindings/user_story_binding.dart';
import '../modules/feed/feed.dart';
import '../modules/feed/modules/home/views/home_screen.dart';
import '../modules/feed/modules/text/text.dart';
import '../modules/focused_feed/bindings/focused_feed_binding.dart';
import '../modules/focused_feed/focused_feed.dart';
import '../modules/inbox/bindings/inbox_binding.dart';
import '../modules/inbox/inbox.dart';
import '../modules/inbox/modules/chat/bindings/chat_binding.dart';
import '../modules/inbox/modules/chat/views/chat_view.dart';
import '../modules/inbox/modules/group_details/group_details_screen.dart';
import '../modules/login/login.dart';
import '../modules/mfa_contact_connect/bindings/mfa_contact_connect_binding.dart';
import '../modules/mfa_contact_connect/mfa_contact_connect.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/notification.dart';
import '../modules/onboarding/modules/user_experience/bindings/user_experience_binding.dart';
import '../modules/onboarding/modules/user_experience/views/user_experience.dart';
import '../modules/pending_invites/bindings/pending_invites_binding.dart';
import '../modules/pending_invites/pending_invites.dart';
import '../modules/portfolio/bindings/portfolio_binding.dart';
import '../modules/portfolio/portfolio.dart';
import '../modules/portfolio_search/bindings/portfolio_search_binding.dart';
import '../modules/portfolio_search/search.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/profile.dart';
import '../modules/profile_search/bindings/profile_search_binding.dart';
import '../modules/profile_search/profile_search.dart';
import '../modules/top_movers/bindings/top_movers_binding.dart';
import '../modules/top_movers/top_movers.dart';
import '../modules/workspaces/bindings/workspaces_bindings.dart';
import '../modules/workspaces/workspaces.dart';

export 'package:iris_common/iris_common.dart';

class Routes {
  static const initial = Paths.SplashScreen;

  static final List<GetPage> pages = [
    // GetPage(
    //   name: Paths.Root,
    //   page: () => const RootScreen(),
    //   participatesInRootNavigator: true,
    //   popGesture: true,
    //   bindings: [
    //     RootBinding(),
    //     // ExplorerBinding(),
    //     FeedBinding(),
    //     InboxBinding(),
    //     AssetViewBinding()
    //   ],
    //   //preventDuplicateHandlingMode: PreventDuplicateHandlingMode.DoNothing,
    //   children: [
    GetPage(
      name: Paths.EditProfile,
      page: () => const EditProfileScreen(),
      bindings: [EditProfileBinding()],
      transition: Transition.downToUp,
      showCupertinoParallax: false,
    ),

    GetPage(
      name: Paths.AnalyticsPopular,
      page: () => const AnalyticsPopularScreen(),
      bindings: [AnalyticsPopularBinding()],
      transition: Transition.cupertino,
    ),
    // GetPage(
    //   name: Paths.AnalyticsStreaks,
    //   page: () => const AnalyticsStreaksScreen(),
    //   bindings: [AnalyticsStreaksBinding()],
    //   transition: Transition.cupertino,
    // ),
    GetPage(
      name: Paths.AnalyticsOrderFlow,
      page: () => const AnalyticsOrderFlowScreen(),
      bindings: [AnalyticsOrderFlowBinding()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.Workspaces.createPath([':workspace']),
      page: () => const WorkspacesScreen(),
      bindings: [WorkspacesBinding()],
    ),
    GetPage(
      name: Paths.MfaContactConnect,
      page: () => const MfaContactConnectScreen(),
      bindings: [MfaContactConnectBinding()],
    ),
    GetPage(
      name: Paths.ExploreFriends,
      page: () => const ExploreFriendsScreen(),
      bindings: [ExploreFriendsBinding()],
    ),
    GetPage(
      name: Paths.LoginPhone,
      page: () => const LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: Paths.PendingInvites,
      page: () => const PendingInvitesScreen(),
      bindings: [PendingInvitesBinding()],
    ),

    GetPage(
      name: Paths.UserExperience,
      page: () => const UserExperienceScreen(),
      bindings: [UserExperienceBinding()],
    ),

    GetPage(
      name: Paths.FocusedFeed,
      page: () => const FocusedFeedScreen(),
      bindings: [FocusedFeedBinding()],
    ),
    GetPage(
        name: Paths.SavedFeed,
        page: () => const SavedFeedScreen(),
        bindings: [SavedFeedBinding()]),

    GetPage(
      name: Paths.NotificationSettings,
      page: () => const NotificationSettingsScreen(),
      bindings: [NotificationSettingsBinding()],
    ),
    GetPage(
      name: Paths.PaymentMethods,
      page: () => const PaymentMethodsScreen(),
      bindings: [PaymentMethodsBinding()],
    ),
    GetPage(
      name: Paths.UserSingleStory,
      page: () => const SingleUserStoriesScreen(),
      bindings: [
        StoryBinding(),
        ProfileBinding(),
      ],
      showCupertinoParallax: false,
      opaque: false,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: Paths.UserStory,
      opaque: false,
      page: () => const UserStoriesStoriesScreen(),
      binding: UserStoryBinding(),
      showCupertinoParallax: false,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    // GetPage(
    //     name: Paths.IrisGoldSettingsPreview,
    //     page: () => const IrisGoldSettingsScreen(),
    //     bindings: [IrisGoldSettingsBinding()],
    //     middlewares: [IrisGoldSettingsMiddleware()]),
    // GetPage(
    //   name: Paths.IrisGoldSettingsChoose,
    //   page: () => const IrisGoldSettingsChooseScreen(),
    //   bindings: [IrisGoldSettingsBinding()],
    // ),

    // GetPage(
    //   name: Paths.IrisGoldSettingsLoading,
    //   page: () => const IrisGoldSettingsLoadingScreen(),
    //   bindings: [IrisGoldSettingsBinding()],
    // ),

    // GetPage(
    //     name: Paths.IrisGoldOptionsOverview,
    //     page: () => const IrisGoldOptionsScreen(),
    //     bindings: [IrisGoldOptionsBinding()],
    //     middlewares: [IrisGoldOptionsMiddleware()]),
    // GetPage(
    //   name: Paths.IrisGoldOptionsChoose,
    //   page: () => const IrisGoldOptionsChooseScreen(),
    //   bindings: [IrisGoldOptionsBinding()],
    // ),

    // GetPage(
    //   name: Paths.IrisGoldOptionsConfirmation,
    //   page: () => const IrisGoldOptionsConfirmationScreen(),
    //   bindings: [IrisGoldOptionsBinding()],
    // ),

    GetPage(
      name: Paths.PhoneNumberPicker,
      page: () => const PhoneNumberPickerScreen(),
      bindings: [PhoneNumberPickerBinding()],
    ),

    GetPage(
      name: Paths.PhoneNumberVerify,
      page: () => const PhoneNumberVerifyScreen(),
      bindings: [PhoneNumberVerifyBinding()],
    ),

    GetPage(
      name: Paths.PictureAndNamePicker,
      page: () => const PictureAndFullNameScreen(),
      bindings: [PictureAndFullNameBinding()],
    ),

    GetPage(
      name: Paths.EnterUsername,
      page: () => const EnterUsernameScreen(),
      bindings: [EnterUsernameBinding()],
    ),

    GetPage(
      name: Paths.EnterUseremail,
      page: () => const EnterUseremailScreen(),
      binding: EnterUseremailBinding(),
    ),

    //************************************ */
    //************************************ */
    //* PORTFOLIO / INSTITUTION CONNECT ** */
    //************************************ */
    //************************************ */

    //***** first step to connecting institution
    GetPage(
      name: Paths.InstitutionConnectLanding,
      page: () => const InstitutionConnectLandingScreen(),
      bindings: [InstitutionConnectLandingBinding()],
    ),
    //***** second step select institution
    GetPage(
      name: Paths.SelectInstitution,
      page: () => const SelectInstitutionScreen(),
      bindings: [SelectInstitutionBinding()],
    ),
    //***** third step connect the actual institution
    GetPage(
      name: Paths.ConnectInstitution.createPath([':institutionName']),
      page: () => const ConnectInstitutions(),
      bindings: [ConnectInstitutionsBinding()],
    ),
    GetPage(
      name: Paths.ConnectInstitution.createPath(
          [':institutionName', ':portfolioKey']),
      page: () => const ConnectInstitutions(),
      bindings: [ConnectInstitutionsBinding()],
    ),
    //************************************ */
    //end ********************************
    //************************************ */

    GetPage(
      name: Paths.InvitedBy,
      page: () => const InvitedByScreen(),
      bindings: [InvitedByBinding()],
    ),

    GetPage(
      name: Paths.OnboardingFinal,
      page: () => const OnboardingFinalScreen(),
      bindings: [OnboardingFinalBinding()],
    ),

    GetPage(
      name: Paths.ContactsPermission,
      page: () => const ContactsPermissionScreen(),
      bindings: [ContactsPermissionBinding()],
    ),
    GetPage(
      name: Paths.BuildYourCommunity,
      page: () => const BuildYourCommunityScreen(),
      bindings: [BuildYourCommunityBinding()],
    ),

    GetPage(
      name: Paths.SplashScreen,
      page: () => const SplashScreenView(),
      bindings: [SplashScreenBinding()],
      middlewares: [
        SplashScreenMiddleware(),
      ],
    ),

    GetPage(
      name: Paths.Leaderboard,
      page: () => const LeaderboardScreen(),
      bindings: [LeaderboardBinding()],
    ),
    GetPage(
      name: Paths.TopMovers,
      page: () => const TopMoversScreen(),
      bindings: [TopMoversBinding()],
    ),

    GetPage(
      name: Paths.Text.createPath([':textKey']),
      page: () => const TextScreen(),
      //gestureWidth: (context) => context.width / 2.5,
      // Note: have to remove transition otherwise it will break full screen widget dismissing feature
      // transition: Transition.noTransition,
      // transitionDuration: Duration(milliseconds: 0),
    ),
    GetPage(
      name: Paths.Search,
      page: () => const SearchScreen(),
      bindings: [SearchBinding()],
    ),
    GetPage(
      name: Paths.GroupDetails.createPath([':collectionKey']),
      page: () => const GroupDetailsScreen(),
    ),
    GetPage(
      // name: Paths.ProfileSearch.createPath([':profileUserKey', ':selectedTab']),
      name: Paths.ProfileSearch,
      page: () => const ProfileSearchScreen(),
      bindings: [ProfileSearchBinding()],
    ),
    GetPage(
      name: Paths.PortfolioSearch.createPath([':portfolioKey']),
      page: () => const PortfolioSearchScreen(),
      bindings: [PortfolioSearchBinding()],
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: Paths.Portfolio.createPath([':portfolioKey']),
      page: () => const PortfolioScreen(),
      bindings: [PortfolioBinding()],
    ),
    GetPage(
      name: Paths.Welcome.createPath([':auto']),
      page: () => const WelcomeScreen(),
      //  fullscreenDialog: true,
    ),

    GetPage(
      name: Paths.Settings,
      page: () => const SettingsScreen(),

      //fullscreenDialog: true
    ),
    GetPage(
      name: Paths.Account,
      page: () => const AccountScreen(),
      bindings: [AccountBinding()],
    ),
    GetPage(
      name: Paths.AccountPortfolios,
      page: () => const AccountPortfoliosScreen(),
    ),
    GetPage(
        name: Paths.Deactivate,
        page: () => const DeactivateScreen(),
        bindings: [DeactivateBinding()]),

    GetPage(
      name: Paths.Login.createPath([':auto']),
      page: () => const LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: Paths.Referrals,
      page: () => ReferralsScreen(),
    ),

    GetPage(
      name: Paths.Feed,
      popGesture: true,
      participatesInRootNavigator: true,
      bindings: [
        // ExplorerBinding(),
        FeedBinding(),
        InboxBinding(),
        ProfileBinding(),
        // AssetViewBinding()
      ],
      page: () => const FeedScreen(),
      // transition: Transition.noTransition,
      // transitionDuration: const Duration(milliseconds: 0),
      // preventDuplicateHandlingMode: PreventDuplicateHandlingMode.DoNothing,
      children: [
        GetPage(
          name: Paths.Home,
          page: () => const HomeScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 0),
          // reverseTransitionDuration: const Duration(milliseconds: 300),
          children: [
            GetPage(
              name: Paths.Profile,
              page: () => const ProfileScreen(),
              bindings: [ProfileBinding()],
              middlewares: [ProfileMiddleware()],
            ),
            GetPage(
              name: Paths.Explore,
              gestureWidth: (_) => 30,
              page: () => const ExplorerScreen(),
              bindings: [ExplorerBinding(), LeaderboardBinding()],
            ),
            GetPage(
              name: Paths.Notifications,
              page: () => const NewNotificationScreen(),
              bindings: [NotificationBinding()],
            ),
            GetPage(
              name: Paths.MessageCollection.createPath([':collectionKey']),
              page: () => const ChatScreen(),
              bindings: [
                InboxBinding(),
                ChatBinding(),
              ],
            ),
            GetPage(
              name: Paths.Inbox,
              page: () => const InboxScreen(),
              bindings: [
                InboxBinding(),
              ],
            ),
          ],
        ),
        GetPage(
          opaque: false,
          name: Paths.Explore,
          page: () => const ExplorerScreen(),
          bindings: [ExplorerBinding(), LeaderboardBinding()],
          transition: Transition.noTransition,
          transitionDuration: const Duration(milliseconds: 0),
        ),
        GetPage(
          name: Paths.AutoPilotNav,
          page: () => const AutoPilotScreen(),
          binding: AutoPilotBinding(),
          transition: Transition.noTransition,
          transitionDuration: const Duration(milliseconds: 0),
        ),
        GetPage(
          name: Paths.Notifications,
          page: () => const NewNotificationScreen(),
          bindings: [NotificationBinding()],
          transition: Transition.noTransition,
          transitionDuration: const Duration(milliseconds: 0),
        ),
        GetPage(
          name: Paths.AnalyticsMenu,
          page: () => const AnalyticsOrderFlowScreen(),
          bindings: [AnalyticsOrderFlowBinding()],
          transition: Transition.noTransition,
          transitionDuration: const Duration(milliseconds: 0),
        ),
        GetPage(
          name: Paths.MyProfile,
          page: () => const ProfileScreen(),
          // popGesture: true,
          transition: Transition
              .noTransition, // without noTransition, the hero animation doesn't work properly
          bindings: [ProfileBinding()],
          middlewares: [ProfileMiddleware()],
          transitionDuration: const Duration(milliseconds: 0),
        ),
      ],
    ),
  ];

  const Routes._();
}
