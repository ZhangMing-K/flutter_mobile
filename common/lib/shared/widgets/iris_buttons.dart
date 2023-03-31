import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

enum ButtonFollowType {
  none,
  me,
  following,
  pending,
  follow,
  viewProfile,
  message
}

enum FOLLOWING_ACTION { MESSAGE, OPTIONS, VIEW_PROFILE, NONE }

class _AutoPilotButton extends IrisButton {
  const _AutoPilotButton({this.customAction}) : super();
  final VoidCallback? customAction;

  @override
  Widget build(BuildContext context) {
    final scaleFactor = context.textScaleFactor;

    return SizedBox(
      height: height * scaleFactor,
      width: width * scaleFactor,
      child: Material(
        child: OutlinedButton(
          onPressed: () {
            if (customAction != null) {
              customAction?.call();
            } else {
              Get.dialog(const _AutopilotDialog());
            }
          },
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              enableFeedback: true,
              padding: const EdgeInsets.all(0)),
          child: Center(
            child: Image.asset(
              Images.autopilotIcon,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class IrisButton extends StatelessWidget {
  const IrisButton(
      {Key? key, this.height = 44, this.width = 44, this.onPress, this.child})
      : super(key: key);

  final double height;
  final double width;
  final Function()? onPress;
  final Widget? child;

  factory IrisButton.autopilot({VoidCallback? customAction}) {
    return _AutoPilotButton(customAction: customAction);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).cardColor),
      child: Material(
        child: InkWell(
          onTap: onPress,
          child: child ?? Container(),
        ),
      ),
    );
  }
}

class _AutopilotDialog extends StatelessWidget {
  const _AutopilotDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: AutopilotLogo(),
            ),
            const SizedBox(height: 26),
            Text(
              TextValues.AutopilotDialogTitle,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              TextValues.AutopilotDialogBody,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: const Color(0xff9e9e9e)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  /*TODO go to typeform */
                },
                child: const Text('Download Autopilot'))
          ],
        ),
      ),
    );
  }
}

class IrisFollowButton extends StatelessWidget {
  final double width;
  final double height;
  final bool includeFollowingOptions;
  final Rx<User> user$;
  final Function(FollowRequest)? onFollow;
  final Function(bool)? onPermission;
  final Function? onStopFollowing;
  final FOLLOWING_ACTION followingAction;
  final VoidCallback? customAction;

  const IrisFollowButton({
    Key? key,
    this.width = 100,
    this.height = 30,
    required this.user$,
    this.includeFollowingOptions = false,
    this.onFollow,
    this.onStopFollowing,
    this.followingAction = FOLLOWING_ACTION.MESSAGE,
    this.customAction,
    this.onPermission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // dsds
      height: IrisScreenUtil.dWidth(height, scale: context.textScaleFactor),
      constraints: BoxConstraints(minWidth: IrisScreenUtil.dWidth(width)),
      child: GetX<IrisFollowButtonController>(
        global: false,
        init: IrisFollowButtonController(
          authUserStore: Get.find(),
          followService: Get.find(),
          collectionService: Get.find(),
          // inboxController: Get.find(),
        ),
        builder: (controller) {
          final type = controller.getButtonType(user$, followingAction);

          switch (type) {
            case ButtonFollowType.message:
              return MessageButtonWidget(
                  onPressed: () => controller.onMessage(user$));

            case ButtonFollowType.viewProfile:
              return ViewProfileButtonWidget(
                user: user$.value,
                customAction: customAction,
              );

            case ButtonFollowType.follow:
              return IrisFollowButtonWidget(
                onPressed: () async {
                  final followRequest = await controller.follow(user$);
                  final isPermissionGranted =
                      await controller.askForUserNotifications(user$);
                  if (onFollow != null) {
                    onFollow!(followRequest);
                  }
                  onPermission?.call(isPermissionGranted);
                },
              );

            case ButtonFollowType.pending:
              return const PendingButtonWidget();

            case ButtonFollowType.following:
              return IrisFollowingButtonWidget(
                followingAction: followingAction,
                onPressed: () => controller.onTapFollowing(
                    context, user$, followingAction, onPermission),
              );

            case ButtonFollowType.me:
              return const MeButtonWidget();
            case ButtonFollowType.none:
              return const Text('');
          }
        },
      ),
    );
  }
}

class IrisFollowButtonController extends GetxController {
  final FollowService followService;
  final CollectionService collectionService;
  final IAuthUserService authUserStore;
  final INotificationRepository notificationRepository =
      Get.find<INotificationRepository>();

  int userKey = 0;
  IrisFollowButtonController({
    required this.followService,
    required this.collectionService,
    required this.authUserStore,
  });

  Future<bool> askForUserNotifications(Rx<User> user) async {
    // final int userKey = user.value.userKey!;
    // final String firstName = user.value.firstName!;
    bool shouldSetNotification = false;
    // await Get.dialog(CupertinoAlertDialog(
    //   title: Text('Want to get notified when $firstName makes a trade?'),
    //   content: const Text(
    //       'Turn on trade and post notifications to know exactly when and what they trade.'),
    //   actions: [
    //     CupertinoDialogAction(
    //       child: const Text('Not now'),
    //       onPressed: () {
    //         Get.back();
    //       },
    //     ),
    //     CupertinoDialogAction(
    //       child: const Text('Turn on'),
    //       onPressed: () async {
    final isGranted = await NotificationPermission.getNotificationPermission();
    if (isGranted) {
      shouldSetNotification = true;
    }
    //         Get.back();
    //       },
    //     ),
    //   ],
    // ));
    return shouldSetNotification;
  }

  Future<FollowRequest> follow(Rx<User> user) async {
    user.value = user.value.copyWith(
        authUserFollowInfo:
            const AuthUserFollowInfo(followStatus: FOLLOW_STATUS.PENDING));
    userKey = user.value.userKey!;
    final followRequest =
        await followService.follow(userKey: user.value.userKey!);
    user.value = user.value.copyWith(
        authUserFollowInfo: followRequest!.accountUser!.authUserFollowInfo);
    return followRequest;
  }

  List<PANNEL_ITEMS> followerPannelItems(User user) {
    return [
      PANNEL_ITEMS.STOP_FOLLOWING,
      if (user.authUserRelation?.hideAt == null)
        PANNEL_ITEMS.HIDE
      else
        PANNEL_ITEMS.UNHIDE
    ];
  }

  List<PANNEL_ITEMS> fPannelItems(User user) {
    return user.authUserRelation?.hideAt == null
        ? [PANNEL_ITEMS.STOP_FOLLOWING, PANNEL_ITEMS.HIDE]
        : [PANNEL_ITEMS.STOP_FOLLOWING, PANNEL_ITEMS.UNHIDE];
  }

  ButtonFollowType getButtonType(
      Rx<User> user, FOLLOWING_ACTION followingAction) {
    if (followingAction == FOLLOWING_ACTION.MESSAGE &&
        (user.value.userPrivacyType == USER_PRIVACY_TYPE.PUBLIC ||
            user.value.authUserFollowInfo?.followStatus ==
                FOLLOW_STATUS.APPROVED)) {
      return ButtonFollowType.message;
    } else if (followingAction == FOLLOWING_ACTION.VIEW_PROFILE &&
        user.value.authUserFollowInfo!.followStatus == FOLLOW_STATUS.APPROVED) {
      return ButtonFollowType.viewProfile;
    } else if (user.value.authUserFollowInfo?.followStatus ==
        FOLLOW_STATUS.PENDING) {
      return ButtonFollowType.pending;
    } else if (user.value.authUserFollowInfo?.followStatus ==
        FOLLOW_STATUS.APPROVED) {
      return ButtonFollowType.following;
    } else if (user.value.authUserFollowInfo?.followStatus ==
        FOLLOW_STATUS.ME) {
      return ButtonFollowType.me;
    } else if (followingAction == FOLLOWING_ACTION.MESSAGE &&
        (user.value.userPrivacyType == USER_PRIVACY_TYPE.PUBLIC ||
            user.value.authUserFollowInfo?.followStatus == null)) {
      return ButtonFollowType.follow;
    } else if (user.value.authUserFollowInfo?.followStatus ==
        FOLLOW_STATUS.NOT_FOLLOWING) {
      return ButtonFollowType.follow;
    } else {
      return ButtonFollowType.none;
    }
  }

  Future<void> onMessage(Rx<User> user) async {
    final Collection? collection = await collectionService
        .privateMessageCollectionFindOrCreate(userKey: user.value.userKey);

    if (collection == null) {
      Get.snackbar(
        'Error', // title
        'Something wrong creating chat !',
        colorText: Colors.red,
        shouldIconPulse: true,
        barBlur: 20,
        isDismissible: true,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    final Rx<TextModel> text = TextModel(
            textCreateId: DateTime.now().millisecondsSinceEpoch,
            //This is so we can locate it later
            value: '',
            textType: TEXT_TYPE.MESSAGE,
            collection: collection,
            user: authUserStore.loggedUser,
            //user: collection.currentUsers!.first,
            orderedCreatedAt: DateTime.now())
        .obs;

    final args = ChatArgs(
      encryptionCode: collection.collectionGuardedInfo?.encryptionCode ?? '',
      avatarUrl: user.value.profilePictureUrl ?? '',
      chatname: (collection.collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE
              ? user.value.fullName
              : collection.name) ??
          '',
      id: uuid.v4(),
      message: text,
    );

    await Get.toNamed(
      Paths.Feed +
          Paths.Home +
          Paths.MessageCollection.createPath([collection.collectionKey]),
      arguments: args,
      id: 1,
    );
  }

  void onTapFollowing(BuildContext context, Rx<User> user,
      FOLLOWING_ACTION followingAction, Function? onPermission) {
    if (user.value.authUserFollowInfo!.followStatus == FOLLOW_STATUS.APPROVED) {
      if (followingAction == FOLLOWING_ACTION.OPTIONS) {
        FollowerView.openPannel(
            userKey: user.value.userKey,
            context: context,
            pannelActions: followerPannelItems(user.value),
            refreshParent: (
                {FOLLOW_ACTION actionType = FOLLOW_ACTION.REMOVE,
                int? portfolioKey,
                UserRelation? authUserRelation,
                int? userKey}) {
              if (actionType == FOLLOW_ACTION.REMOVE) {
                user.value = user.value.copyWith(
                    authUserFollowInfo: const AuthUserFollowInfo(
                        followStatus: FOLLOW_STATUS.NOT_FOLLOWING));
                onPermission?.call(false);
              }

              return;
            });
      }
    }
  }
}

class IrisFollowButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const IrisFollowButtonWidget({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        backgroundColor: MaterialStateProperty.all<Color>(
            context.theme.custom.colorScheme.primaryBlue),
        enableFeedback: true,
      ),
      onPressed: onPressed,
      child: Text(
        'Follow',
        style: TextStyle(
            color: Colors.white, fontSize: IrisScreenUtil.dFontSize(14)),
      ),
    );
  }
}

class IrisFollowingButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final FOLLOWING_ACTION followingAction;

  const IrisFollowingButtonWidget({
    Key? key,
    required this.onPressed,
    required this.followingAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Following',
            style: TextStyle(
                color: context.theme.colorScheme.secondary,
                fontSize: IrisScreenUtil.dFontSize(14)),
          ),
          if (followingAction == FOLLOWING_ACTION.OPTIONS)
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: context.theme.colorScheme.secondary,
            ),
        ],
      ),
    );
  }
}

class IrisMessageButtonController extends GetxController {
  // final InboxController inboxController;

  final CollectionService collectionService;

  IrisMessageButtonController({
    // required this.inboxController,
    required this.collectionService,
  });
}

class MeButtonWidget extends StatelessWidget {
  const MeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(
        'Me',
        style: TextStyle(color: context.theme.colorScheme.secondary),
      ),
      onPressed: () {},
    );
  }
}

class MessageButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const MessageButtonWidget({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          enableFeedback: true,
        ),
        child: Text('Message',
            style: TextStyle(
                color: context.theme.colorScheme.secondary,
                fontSize: IrisScreenUtil.dFontSize(14))));
  }
}

class PendingButtonWidget extends StatelessWidget {
  const PendingButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(
        'Pending',
        style: TextStyle(
            color: context.theme.colorScheme.secondary,
            fontSize: IrisScreenUtil.dFontSize(14)),
      ),
      onPressed: () {},
    );
  }
}

class ViewProfileButtonWidget extends StatelessWidget {
  final User user;
  final VoidCallback? customAction;

  const ViewProfileButtonWidget(
      {Key? key, required this.user, this.customAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(
        'View Profile',
        style: TextStyle(color: context.theme.colorScheme.secondary),
      ),
      onPressed: () {
        user.routeToProfile();
        if (customAction != null) {
          customAction!();
        }
      },
    );
  }
}
