import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../iris_buttons.dart';
import 'reacted_by_slideup_controller.dart';

//TODO: Change weird c to controller
class ReactedBySlideup extends StatelessWidget {
  final ScrollController? scrollController;
  final TextModel? text;
  final ReactedBySlideupController c;
  const ReactedBySlideup(
      {Key? key, required this.text, required this.c, this.scrollController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
        ),
        child: Obx(() {
          return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
                child: IrisListView(
              controller: scrollController,
              loadMore: () async {
                c.getReactions();
              },
              itemCount: c.reactions.length,
              builder: (BuildContext context, index) {
                final reaction = c.reactions[index];
                return userRow(reaction: reaction);
              },
            ))
          ]);
        }));
  }

  Widget userRow({required Reaction reaction}) {
    return Builder(builder: (context) {
      return Container(
        // height: 100,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();

            reaction.user!.routeToProfile();
            Navigator.pop(context);
          },
          child: Row(
            children: [
              AbsorbPointer(
                child: UserImage(
                  user: reaction.user!,
                  radius: 20,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              AbsorbPointer(
                child: UserName(
                  user: reaction.user,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (reaction.user?.authUserFollowInfo?.followStatus != null)
                      IrisFollowButton(
                        user$: Rx(reaction.user!),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
