import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../notifiers/profile_summary_notifier.dart';

class ProfileSummaryHeader extends StatelessWidget {
  const ProfileSummaryHeader({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileSummaryController controller;

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      //final user = state.value;
      return Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Row(
          children: [
            Obx(() {
              final user = state!.value;
              return UserImage(
                user: user,
                showFullScreen: true,
                id: controller.heroTag,
                radius: 30,
                afterStories: () {
                  //TODO connect back to a controller
                  controller.markNoUnSeenStories();
                },
              );
            }),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Obx(() {
                final user = state!.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserName(
                      user: user,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      heroTag: controller.heroTag,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    _UserSubtitle(user: user)
                  ],
                );
              }),
            )
          ],
        ),
      );
    });
  }
}

class _UserSubtitle extends StatefulWidget {
  const _UserSubtitle({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<_UserSubtitle> createState() => _UserSubtitleState();
}

class _UserSubtitleState extends State<_UserSubtitle>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _UserSubtitle oldWidget) {
    //TODO connect a controller (if needed. Animations can usually be kept in and triggered by ephemeral widget state)
    // if (!widget.controller.status.isLoading) {
    // _animationController.forward();
    // }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var subTitleTheme = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontWeight: FontWeight.bold, color: const Color(0xff7a7a7a));
    var subTitleWhite = subTitleTheme?.copyWith(
        color: Theme.of(context).colorScheme.onBackground);
    return FadeTransition(
      opacity: _animation,
      child: Wrap(
        children: [
          if (widget.user.username != null)
            Text(
              '@${widget.user.username} - ',
              style: subTitleTheme,
            ),
          Text(
            '${widget.user.followStats?.numberOfFollowers.compactNumber() ?? 0}',
            style: subTitleWhite,
          ),
          Text(
            ' Followers',
            style: subTitleTheme,
          ),
          //TODO waiting on the backend to add this to the user
          // Text(
          //   '${user$.value.numberOfAutopilots} - ',
          //   style: subTitleTheme,
          // ),
          // Text(
          //   ' Autopilots',
          //   style: subTitleTheme,
          // ),
        ],
      ),
    );
  }
}
