import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';


enum BubbleStatus { none, loading, sent, delivered, seen }

class IrisBubble extends StatelessWidget {
  const IrisBubble({
    Key? key,
    required this.isLast,
    required this.type,
    required this.status,
    required this.text,
    this.name = 'You',
    required this.avatar,
    required this.reactionButton,
    required this.showReactionContainer,
    required this.onDoubleTapMessage,
    this.cancelBubbleGestures = false,
    this.isSender = true,
    this.isSharedText = false,
    this.isMessageAllEmojis = false,
    this.bubbleColor = IrisColor.primaryColor,
    this.color = const Color(0xff333333),
    this.textStyle = const TextStyle(fontSize: 16),
    this.showAvatar = true,
    this.showName = true,
    this.maxWidth = 0.6,
    this.avatarPadding = false,
    this.uniformBubbleMargin = false,
    this.isAttachment = false,
  }) : super(key: key);

  final bool isLast;
  final bool isMessageAllEmojis;
  final bool isSharedText;
  final bool
      uniformBubbleMargin; //this is mainly for shared text to make the bubble unifor
  double get bubbleMargin {
    if (isAttachment) {
      return 0;
    }
    if (uniformBubbleMargin) {
      // return 7;
      return 0;
    }
    return 14;
  }

  double get otherBubbleMargin {
    if (isAttachment) {
      return 0;
    }
    if (uniformBubbleMargin) {
      return 0;
    }
    return 7;
  }

  final Widget avatar;
  final bool isSender;
  final Widget text;
  final Color color;
  final Color bubbleColor;
  final TextStyle textStyle;
  final BubbleStatus status;
  final String name;
  final bool showAvatar;
  final bool showName;
  final IrisBubbleType type;
  final double maxWidth;
  final bool avatarPadding;
  final Widget reactionButton;
  final bool showReactionContainer;

  final VoidCallback onDoubleTapMessage;
  final bool cancelBubbleGestures;

  final bool isAttachment;

  bool get hasStatus => false; // status != BubbleStatus.none;

  IconData get iconTick {
    if (status == BubbleStatus.sent) {
      return Icons.done;
    } else if (status == BubbleStatus.loading) {
      return Icons.alarm;
    } else {
      return Icons.done_all;
    }
  }

  Color get senderColor {
    return !isSharedText && isMessageAllEmojis
        ? Colors.transparent
        : iconTick == Icons.alarm
            ? IrisColor.irisBlueDark
            : IrisColor.irisBlue;
  }

  // IconData get iconTick {
  //   if (status == BubbleStatus.sent) {
  //     return Icons.done;
  //   } else if (status == BubbleStatus.loading) {
  //     return Icons.alarm;
  //   } else {
  //     return Icons.done_all;
  //   }
  // }

  Color get tickColor =>
      status == BubbleStatus.seen ? Colors.green : Colors.white;

  @override
  Widget build(BuildContext context) {
    final textScale = context.textScaleFactor;
    return Container(
      // color: context.theme.scaffoldBackgroundColor,
      margin: EdgeInsets.only(top: showReactionContainer ? 15 : 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isSender)
            Visibility(
              visible: showAvatar,
              child: avatar,
              replacement: Visibility(
                visible: avatarPadding,
                child: CircleAvatar(
                  radius: (14 + baseRingNumber(14)) *
                      context
                          .textScaleFactor, // to match the size with userImage
                  backgroundColor: Colors.transparent,
                ), // this is equivalent to the user avatar
              ),
            ),
          if (!avatarPadding) const SizedBox(width: 6),
          if (avatarPadding) const SizedBox(width: 6),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  !isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Visibility(
                  visible: !isSender && showName,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 1, left: 16),
                    child: Text(
                      name,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Colors.grey.shade400),
                      textAlign: isSender ? TextAlign.right : TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Align(
                  alignment: isSender ? Alignment.topRight : Alignment.topLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      //  overflow: Overflow.visible,
                      children: [
                        GestureDetector(
                          onDoubleTap:
                              cancelBubbleGestures ? null : onDoubleTapMessage,
                          child: CustomPaint(
                            painter: IrisBubblePainter(
                              color: isAttachment || uniformBubbleMargin
                                  ? Colors.transparent
                                  : isSender
                                      ? senderColor
                                      : color,
                              isSender: isSender,
                              type: type,
                              isAttachment: isAttachment,
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width *
                                    maxWidth,
                                // maxWidth: MediaQuery.of(context).size.width
                              ),
                              margin: isSender
                                  ? hasStatus
                                      ? EdgeInsets.fromLTRB(
                                          otherBubbleMargin * textScale,
                                          otherBubbleMargin * textScale,
                                          bubbleMargin * textScale,
                                          otherBubbleMargin * textScale)
                                      : EdgeInsets.fromLTRB(
                                          bubbleMargin * textScale,
                                          otherBubbleMargin * textScale,
                                          bubbleMargin * textScale,
                                          otherBubbleMargin * textScale)
                                  : EdgeInsets.fromLTRB(
                                      bubbleMargin * textScale,
                                      otherBubbleMargin * textScale,
                                      bubbleMargin * textScale,
                                      otherBubbleMargin * textScale),
                              child: DefaultTextStyle(
                                textAlign: TextAlign.left,
                                style:
                                    DefaultTextStyle.of(context).style.copyWith(
                                          fontWeight: FontWeight.w300,
                                        ),
                                child: text,
                              ),

                              // Stack(
                              //   children: <Widget>[
                              //     Padding(
                              //       padding: hasStatus
                              //           ? EdgeInsets.only(
                              //               right: 20,
                              //               left: 4,
                              //               top: 0,
                              //               bottom: 0,
                              //             )
                              //           : EdgeInsets.only(
                              //               top: 0,
                              //               bottom: 0,
                              //               left: 0,
                              //               right: 0,
                              //             ),
                              //       child:
                              //     ),
                              //     // Visibility(
                              //     //   visible: hasStatus,
                              //     //   child: Positioned(
                              //     //     bottom: 0,
                              //     //     right: 0,
                              //     //     child: Padding(
                              //     //       padding: const EdgeInsets.only(bottom: 3.0),
                              //     //       child: Icon(
                              //     //         iconTick,
                              //     //         size: 18,
                              //     //         color: tickColor,
                              //     //       ),
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //   ],
                              // ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: isSender ? -30 : null,
                          top: -13,
                          right: !isSender ? -30 : null,
                          child: SizedBox(
                            height: 48,
                            width: 41,
                            child: ReactionButtonContainer(
                              isSender: isSender,
                              showIndicator: showReactionContainer,
                              bubbleColor: bubbleColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.theme.scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.all(1),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: bubbleColor,
                                  child: reactionButton,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (isSender) avatar,
        ],
      ),
    );
  }
}

enum IrisBubbleType {
  top,
  middle,
  bottom,
  topAndBottom,
}

class IrisBubblePainter extends CustomPainter {
  IrisBubblePainter({
    required this.color,
    required this.isSender,
    required this.type,
    required this.isAttachment,
  });
  final Color color;
  final bool isSender;
  final IrisBubbleType type;
  final bool isAttachment;

  @override
  void paint(Canvas canvas, Size size) {
    final Color startingColor = lightenColor(color, .05);
    final Color endingColor = color;
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(size.width, size.height),
        [
          startingColor,
          endingColor,
        ],
      );
// paint.blendMode;
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height),
            const Radius.circular(17)),
        paint);

    if (type == IrisBubbleType.bottom || type == IrisBubbleType.topAndBottom) {
      if (!isSender) {
        final nip = Path()
          ..moveTo(8, size.height - 7)
          ..quadraticBezierTo(0, size.height + 0, -8, size.height - 1)
          ..quadraticBezierTo(-1, size.height - 3, 0, size.height - 20);
        canvas.drawPath(nip, paint);
      } else {
        final nip = Path()
          ..moveTo(
              size.width - 8,
              size.height -
                  7) //1->has t be an 8 or the middle divit will cut off 2->How big the divit is in the middle
          ..quadraticBezierTo(
              size.width + 0,
              size.height + 0,
              size.width + 8,
              size.height -
                  1) //1->dont touch not helpful 2-> this mkaes the nip vertically shorter,3-> makes it horizontally longer
          ..quadraticBezierTo(size.width - 1, size.height - 3, size.width + 0,
              size.height - 20);
        canvas.drawPath(nip, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ReactionButtonContainer extends StatefulWidget {
  const ReactionButtonContainer({
    Key? key,
    required this.showIndicator,
    required this.isSender,
    this.bubbleColor = IrisColor.primaryColor,
    required this.child,
  }) : super(key: key);

  final bool showIndicator;
  final bool isSender;
  final Color bubbleColor;
  final Widget child;

  @override
  _ReactionButtonContainerState createState() =>
      _ReactionButtonContainerState();
}

class _ReactionButtonContainerState extends State<ReactionButtonContainer>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;

  late Animation<double> _indicatorSpaceAnimation;

  late Animation<double> _smallBubbleAnimation;
  late Animation<double> _mediumBubbleAnimation;
  late Animation<double> _largeBubbleAnimation;

  late AnimationController _repeatingController;

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(
      begin: 0.0,
      end: 60.0,
    ));

    _smallBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    );
    _mediumBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    );
    _largeBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _repeatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (widget.showIndicator) {
      _showIndicator();
    }
  }

  @override
  void didUpdateWidget(ReactionButtonContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showIndicator != oldWidget.showIndicator) {
      if (widget.showIndicator) {
        _showIndicator();
      } else {
        _hideIndicator();
      }
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    _repeatingController.dispose();
    super.dispose();
  }

  void _showIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 750)
      ..forward();
    _repeatingController.repeat();
  }

  void _hideIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 150)
      ..reverse();
    _repeatingController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _indicatorSpaceAnimation,
      builder: (context, child) {
        return SizedBox(
          height: _indicatorSpaceAnimation.value,
          child: child,
        );
      },
      child: Stack(
        children: [
          _buildAnimatedBubble(
            animation: _largeBubbleAnimation,
            padding: 2.5,
            bottom: 5,
            bubble: widget.child,
          ),
          _buildAnimatedBubble(
            animation: _mediumBubbleAnimation,
            padding: 4,
            bottom: 4,
            bubble: _buildCircleBubble(10),
          ),
          _buildAnimatedBubble(
            animation: _smallBubbleAnimation,
            padding: 1,
            bottom: 0,
            bubble: _buildCircleBubble(5),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBubble({
    required Animation<double> animation,
    required double padding,
    required double bottom,
    required Widget bubble,
  }) {
    return Positioned(
      left: widget.isSender ? padding : null,
      bottom: bottom,
      right: !widget.isSender ? padding : null,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.scale(
            scale: animation.value,
            alignment: Alignment.bottomLeft,
            child: child,
          );
        },
        child: bubble,
      ),
    );
  }

  Widget _buildCircleBubble(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.bubbleColor,
      ),
    );
  }
}
