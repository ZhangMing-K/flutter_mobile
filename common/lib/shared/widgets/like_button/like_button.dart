import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:unicons/unicons.dart';

class LikeButton extends StatelessWidget {
  final Rx<TextModel?>? text$;

  final double height;
  final bool showIcon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final ValueChanged<String?>? onPressed;
  final bool showNumber;
  final AnimationController? animationController;
  final Alignment reactionPosition;
  final bool showReactions;
  final Color? unselectedColor;
  final bool isExpanded;
  final bool hasCircle;
  final bool isBubble;

  const LikeButton({
    Key? key,
    required this.text$,
    this.height = 20,
    this.showIcon = true,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.onPressed,
    this.showNumber = false,
    this.animationController,
    this.reactionPosition = Alignment.bottomRight,
    this.showReactions = false,
    this.unselectedColor,
    this.isExpanded = true,
    this.hasCircle = false,
    this.isBubble = false,
  }) : super(key: key);

  Widget bounceButton(Widget child) {
    return IrisBounceEffect(
        duration: const Duration(milliseconds: 100), child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      ///disable reactions
      visible: false, //showReactions,
      replacement: GestureDetector(
        child: bounceButton(hasCircle
            ? Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: context.theme.backgroundColor,
                    borderRadius: BorderRadius.circular(40)),
                child: oldButton())
            : oldButton()),
        onTap: () {
          onPressed!('Like');
        },
      ),
      child:
          Container(), // We used to have a set of reaction buttons (angry, sad, happy, etc. but they have not been used, and since seem to have been deleted
    );
  }

  Widget thumbUpButton() {
    return Obx(
      () {
        return Visibility(
          visible: text$!.value!.authUserReaction == null,
          child: Builder(builder: (context) {
            return Icon(
              UniconsLine.thumbs_up,
              color: unselectedColor ??
                  context.theme.colorScheme.secondary.withOpacity(.8),
              size: height,
            );
          }),
          replacement: reactedIcon(),
        );
      },
    );
  }

  Widget oldButton() {
    return Obx(
      () {
        return Row(
          mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon)
              Row(
                children: [
                  if (!isBubble)
                    TouchableArea(
                      child: thumbUpButton(),
                    )
                  else
                    thumbUpButton(),
                  if (showNumber)
                    Text(text$!.value!.numberOfReactions.toString(),
                        style: const TextStyle(color: Colors.white)),
                ],
              ),
            if (text$!.value!.textType == TEXT_TYPE.COMMENT)
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  // 'Like',
                  '',
                  style: TextStyle(
                    color: color ?? Colors.white,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget reactedIcon() {
    final authReaction = text$!.value!.authUserReaction;
    if (authReaction == null) return Container();

    if (authReaction.reactionKind == REACTION_KIND.LIKE) {
      return Icon(
        IrisIcon.like,
        color: color,
        size: height,
      );
    } else if (authReaction.reactionKind == REACTION_KIND.HAHA) {
      return reaction(icon: 'haha.png', height: 20);
    } else if (authReaction.reactionKind == REACTION_KIND.SAD) {
      return reaction(icon: 'sad.png', height: 20);
    } else if (authReaction.reactionKind == REACTION_KIND.ANGRY) {
      return reaction(icon: 'angry.png', height: 20);
    } else if (authReaction.reactionKind == REACTION_KIND.WOW) {
      return reaction(icon: 'wow.png', height: 20);
    } else {
      return Icon(
        IrisIcon.like,
        color: color,
        size: height,
      );
    }
  }

  Widget reaction({required String icon, double height = 40}) {
    return Image.asset(
      'assets/emoji/' + icon,
      height: height,
      fit: BoxFit.cover,
    );
  }

  Widget thumb({required IconData icon}) {
    return
        // IrisBounceButton(
        //   duration: Duration(milliseconds: 100),
        //   controller: animationController,
        //   onPressed: onPressed,
        //   child:
        Icon(
      icon,
      size: height, color: IrisColor.analogousColor, //IrisColor.primaryColor,
      // ),
    );
  }
}
