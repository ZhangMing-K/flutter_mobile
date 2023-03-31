import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/routes/pages.dart';

class StoryUserInfoHeader extends StatelessWidget {
  const StoryUserInfoHeader({
    Key? key,
    required this.user,
    required this.text,
  }) : super(key: key);
  final User user;
  final Rx<TextModel> text;

  Widget userInfo(BuildContext context) {
    final String timeAgo = text.value.dateFromAbb;
    final id = uuid.v4();
    final scaleFactor = context.textScaleFactor;
    return GestureDetector(
        onTap: () {
          user.routeToProfile(id);
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: context.theme.scaffoldBackgroundColor,
          height: 40 * scaleFactor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AbsorbPointer(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UserImage(
                      radius: 15,
                      user: user,
                      id: id,
                      showStories: false,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            UserName(
                              user: user,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              timeAgo,
                              style: TextStyle(
                                  color: context.theme.colorScheme.secondary
                                      .withOpacity(0.8),
                                  fontSize: 12),
                            ),
                            // if (user.traderPercentile != null)
                            //   Text(
                            //     ' - '
                            //     '${user.traderPercentile} trader percentile',
                            //     style: TextStyle(
                            //         fontSize: 12,
                            //         color: context.theme.colorScheme.secondary
                            //             .withOpacity(0.8)),
                            //   ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                color: context.theme.colorScheme.secondary,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return userInfo(context);
  }
}
