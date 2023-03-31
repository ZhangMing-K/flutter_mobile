import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'reacted_by_controller.dart';

//TODO:Refactor this for God's sake
class ReactedBy extends StatelessWidget {
  ReactedBy(
      {Key? key, required this.text$, this.fontSize = 12, this.isVideo = false})
      : super(key: key) {
    c.text$ = text$;
  }

  Rx<TextModel?>? text$;
  final bool isVideo;

  //TODO: Change to GetWidget
  ReactedByController c = ReactedByController();
  final IAuthUserService authUserStore = Get.find();
  double fontSize;

  @override
  build(BuildContext context) {
    //c.initContext(context: context);
    return Obx(() {
      final t = text$!.value!;
      if (t.numberOfReactions == 0 || t.numberOfReactions == null) {
        return Container();
      }

      if (t.textType == TEXT_TYPE.COMMENT) {
        String likeText = '';
        if (t.numberOfReactions! == 1) {
          likeText = ' 1 prop';
        } else if (t.numberOfReactions! > 1) {
          likeText = ' ${t.numberOfReactions!} props';
        }
        return Builder(builder: (context) {
          return InkWell(
            onTap: () => c.onTap(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: RichText(
                    textScaleFactor: context.textScaleFactor,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: fontSize,
                        color: isVideo
                            ? context.theme.backgroundColor
                            : context.theme.colorScheme.secondary
                                .withOpacity(0.7),
                      ),
                      children: [
                        TextSpan(
                          text: likeText,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: IrisColor.dateFromColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      }

      return Builder(builder: (context) {
        final reactions = t.reactions;
        String name = '';
        if (reactions != null && reactions.isNotEmpty) {
          name = reactions[0].user?.fullName ?? '';
        }
        return InkWell(
          onTap: () => c.onTap(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: RichText(
                  textScaleFactor: context.textScaleFactor,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: fontSize,
                      color: isVideo
                          ? context.theme.backgroundColor
                          : context.theme.colorScheme.secondary
                              .withOpacity(0.7),
                    ),
                    children: [
                      if (t.authUserReaction != null)
                        TextSpan(
                          text: 'You',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colorScheme.secondary,
                          ),
                        )
                      else if (t.reactions != null)
                        TextSpan(
                          text: name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                      if (t.numberOfReactions! > 1)
                        const TextSpan(
                          text: ' and',
                        ),
                      if (t.numberOfReactions == 2)
                        TextSpan(
                          text: ' 1 other',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colorScheme.secondary,
                          ),
                        )
                      else if (t.numberOfReactions! > 2)
                        TextSpan(
                          text: ' ${t.numberOfReactions! - 1} others',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                      const TextSpan(
                        text: ' gave props',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
