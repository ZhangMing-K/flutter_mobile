import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// class IrisReactionsWidget extends StatefulWidget {
//   @override
//   IrisReactionsWidgetState createState() => IrisReactionsWidgetState();

//   IrisReactionsWidget({
//     Key? key,
//     required this.reactions,
//     required this.prefix,
//     required this.onReacted,
//     required this.dragSpace,
//     this.dragStart = 0.0,
//     this.suffix,
//     this.spacing = 10.0,
//     this.containerWidth = 250.0,
//     required this.isReacted,
//     required this.color,
//     // this.childAnchor = Alignment.topLeft,
//     this.overlayAnchor = Alignment.bottomLeft,
//   })  : childAnchor = overlayAnchor == Alignment.bottomLeft
//             ? Alignment.topLeft
//             : Alignment.topRight,
//         super(key: key);

//   final List<IrisReaction> reactions;
//   final Widget prefix;
//   final Widget? suffix;
//   final double dragSpace;
//   final double dragStart;
//   final Alignment childAnchor;
//   final Alignment overlayAnchor;
//   final Function(IrisReaction) onReacted;
//   final double spacing;
//   final double containerWidth;
//   final Color color;
//   final bool isReacted;
// }

// class IrisReactionsWidgetState extends State<IrisReactionsWidget>
//     with TickerProviderStateMixin {
//   int durationAnimationBox = 500;
//   int durationAnimationBtnLongPress = 150;
//   int durationAnimationBtnShortPress = 500;
//   int durationAnimationIconWhenDrag = 150;
//   int durationAnimationIconWhenRelease = 1000;

//   late AnimationController animControlBtnLongPress, animControlBox;
//   late Animation zoomIconLikeInBtn, tiltIconLikeInBtn, zoomTextLikeInBtn;
//   late Animation fadeInBox;
//   late Animation moveRightGroupIcon;
//   late Animation pushIconLikeUp;
//   late Animation zoomIconLike;

//   late AnimationController animControlBtnShortPress;
//   late Animation zoomIconLikeInBtn2, tiltIconLikeInBtn2;

//   late AnimationController animControlIconWhenDrag;
//   late AnimationController animControlIconWhenDragInside;
//   late AnimationController animControlIconWhenDragOutside;
//   late Animation zoomIconChosen, zoomIconNotChosen;
//   late Animation zoomIconWhenDragOutside;
//   late Animation zoomIconWhenDragInside;
//   late Animation zoomBoxIcon;

//   late AnimationController animControlIconWhenRelease;
//   late Animation zoomIconWhenRelease, moveUpIconWhenRelease;
//   late Animation moveLeftIconLikeWhenRelease,
//       moveLeftIconLoveWhenRelease,
//       moveLeftIconHahaWhenRelease,
//       moveLeftIconWowWhenRelease,
//       moveLeftIconSadWhenRelease,
//       moveLeftIconAngryWhenRelease;

//   Duration durationLongPress = Duration(milliseconds: 250);
//   late Timer holdTimer;
//   bool isLongPress = false;
//   bool isLiked = false;

//   int whichIconUserChoose = 0;

//   int currentIconFocus = -1;
//   int previousIconFocus = 0;
//   bool isDragging = false;
//   bool isJustDragInside = true;

//   @override
//   void initState() {
//     super.initState();

//     _configureAnimationBtnLike();
//     _configureAnimationBoxAndIcons();
//     _configureAnimationIconWhenDrag();
//     _configureAnimationIconWhenDragOutside();
//     _configureAnimationIconWhenDragInside();
//     _configureAnimationIconWhenRelease();
//     animControlBox.forward();
//   }

//   void _configureAnimationBtnLike() {
//     animControlBtnLongPress = AnimationController(
//         vsync: this,
//         duration: Duration(milliseconds: durationAnimationBtnLongPress));
//     zoomIconLikeInBtn =
//         Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);
//     tiltIconLikeInBtn =
//         Tween(begin: 0.0, end: 0.2).animate(animControlBtnLongPress);
//     zoomTextLikeInBtn =
//         Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);

//     zoomIconLikeInBtn.addListener(_update);
//     tiltIconLikeInBtn.addListener(_update);
//     zoomTextLikeInBtn.addListener(_update);

//     animControlBtnShortPress = AnimationController(
//         vsync: this,
//         duration: Duration(milliseconds: durationAnimationBtnShortPress));
//     zoomIconLikeInBtn2 =
//         Tween(begin: 1.0, end: 0.2).animate(animControlBtnShortPress);
//     tiltIconLikeInBtn2 =
//         Tween(begin: 0.0, end: 0.8).animate(animControlBtnShortPress);

//     zoomIconLikeInBtn2.addListener(_update);
//     tiltIconLikeInBtn2.addListener(_update);
//   }

//   void _update() {
//     setState(() {});
//   }

//   void _configureAnimationBoxAndIcons() {
//     animControlBox = AnimationController(
//         vsync: this, duration: Duration(milliseconds: durationAnimationBox));

//     moveRightGroupIcon = Tween(begin: 0.0, end: 10.0).animate(
//       CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 1.0)),
//     );
//     moveRightGroupIcon.addListener(_update);

//     fadeInBox = Tween(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: animControlBox, curve: Interval(0.7, 1.0)),
//     );
//     fadeInBox.addListener(_update);

//     pushIconLikeUp = Tween(begin: 10.0, end: 15.0).animate(
//       CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
//     );
//     zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
//     );

//     pushIconLikeUp.addListener(_update);
//     zoomIconLike.addListener(_update);
//   }

//   void _configureAnimationIconWhenDrag() {
//     animControlIconWhenDrag = AnimationController(
//         vsync: this,
//         duration: Duration(milliseconds: durationAnimationIconWhenDrag));

//     zoomIconChosen =
//         Tween(begin: 1.0, end: 1.8).animate(animControlIconWhenDrag);
//     zoomIconNotChosen =
//         Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDrag);
//     zoomBoxIcon =
//         Tween(begin: 50.0, end: 40.0).animate(animControlIconWhenDrag);

//     zoomIconChosen.addListener(_update);
//     zoomIconNotChosen.addListener(_update);
//     zoomBoxIcon.addListener(_update);
//   }

//   void _configureAnimationIconWhenDragOutside() {
//     animControlIconWhenDragOutside = AnimationController(
//         vsync: this,
//         duration: Duration(milliseconds: durationAnimationIconWhenDrag));
//     zoomIconWhenDragOutside =
//         Tween(begin: 0.8, end: 1.0).animate(animControlIconWhenDragOutside);
//     zoomIconWhenDragOutside.addListener(_update);
//   }

//   void _configureAnimationIconWhenDragInside() {
//     animControlIconWhenDragInside = AnimationController(
//         vsync: this,
//         duration: Duration(milliseconds: durationAnimationIconWhenDrag));
//     zoomIconWhenDragInside =
//         Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDragInside);
//     zoomIconWhenDragInside.addListener(_update);
//     animControlIconWhenDragInside.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         isJustDragInside = false;
//       }
//     });
//   }

//   void _configureAnimationIconWhenRelease() {
//     animControlIconWhenRelease = AnimationController(
//         vsync: this,
//         duration: Duration(milliseconds: durationAnimationIconWhenRelease));

//     zoomIconWhenRelease = Tween(begin: 1.8, end: 0.0).animate(CurvedAnimation(
//         parent: animControlIconWhenRelease, curve: Curves.decelerate));

//     moveUpIconWhenRelease = Tween(begin: 180.0, end: 0.0).animate(
//         CurvedAnimation(
//             parent: animControlIconWhenRelease, curve: Curves.decelerate));

//     moveLeftIconLikeWhenRelease = Tween(begin: 20.0, end: 10.0).animate(
//         CurvedAnimation(
//             parent: animControlIconWhenRelease, curve: Curves.decelerate));
//     moveLeftIconLoveWhenRelease = Tween(begin: 68.0, end: 10.0).animate(
//         CurvedAnimation(
//             parent: animControlIconWhenRelease, curve: Curves.decelerate));
//     moveLeftIconHahaWhenRelease = Tween(begin: 116.0, end: 10.0).animate(
//         CurvedAnimation(
//             parent: animControlIconWhenRelease, curve: Curves.decelerate));
//     moveLeftIconWowWhenRelease = Tween(begin: 164.0, end: 10.0).animate(
//         CurvedAnimation(
//             parent: animControlIconWhenRelease, curve: Curves.decelerate));
//     moveLeftIconSadWhenRelease = Tween(begin: 212.0, end: 10.0).animate(
//         CurvedAnimation(
//             parent: animControlIconWhenRelease, curve: Curves.decelerate));
//     moveLeftIconAngryWhenRelease = Tween(begin: 260.0, end: 10.0).animate(
//         CurvedAnimation(
//             parent: animControlIconWhenRelease, curve: Curves.decelerate));

//     zoomIconWhenRelease.addListener(_update);
//     moveUpIconWhenRelease.addListener(_update);

//     moveLeftIconLikeWhenRelease.addListener(_update);
//     moveLeftIconLoveWhenRelease.addListener(_update);
//     moveLeftIconHahaWhenRelease.addListener(_update);
//     moveLeftIconWowWhenRelease.addListener(_update);
//     moveLeftIconSadWhenRelease.addListener(_update);
//     moveLeftIconAngryWhenRelease.addListener(_update);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     animControlBtnLongPress.dispose();
//     animControlBox.dispose();
//     animControlIconWhenDrag.dispose();
//     animControlIconWhenDragInside.dispose();
//     animControlIconWhenDragOutside.dispose();
//     animControlIconWhenRelease.dispose();
//     animControlBtnShortPress.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       // mainAxisSize: MainAxisSize.min,
//       children: [
//         GestureDetector(
//           onHorizontalDragEnd: onHorizontalDragEndBoxIcon,
//           onHorizontalDragUpdate: onHorizontalDragUpdateBoxIcon,
//           child: Stack(
//             alignment: Alignment.bottomCenter,
//             children: <Widget>[
//               Container(
//                 height: 30,
//                 color: Colors.red,
//               ),
//               if (widget.reactions.isNotEmpty) _backgroudBoxBuilder(),
//               _reactionsBuilder(),
//             ],
//           ),

//           // CustomOverlayEntry(
//           //   visible: true,
//           //   overlayAnchor: widget.overlayAnchor,
//           //   childAnchor: widget.childAnchor,
//           //   overlay: Padding(
//           //     padding: EdgeInsets.only(bottom: widget.spacing),
//           //     child: Container(
//           //       child: Stack(
//           //         alignment: Alignment.bottomCenter,
//           //         children: <Widget>[
//           //           if (widget.reactions.isNotEmpty) _backgroudBoxBuilder(),
//           //           _reactionsBuilder(),
//           //         ],
//           //       ),
//           //     ),
//           //   ),
//           //   child: _reactionButtonBuilder(),
//           // ),
//         ),
//       ],
//     );
//   }

//   Widget _backgroudBoxBuilder() {
//     return Opacity(
//       opacity: fadeInBox.value,
//       child: Container(
//         decoration: BoxDecoration(
//           color: widget.color,
//           borderRadius: BorderRadius.circular(30.0),
//           border: Border.all(color: Color(0xffe0e0e0), width: 0.3),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey,
//               blurRadius: 5.0,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         width: widget.containerWidth,
//         height: 50.0,
//         margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
//       ),
//     );
//   }

//   Widget _reactionsBuilder() {
//     return Container(
//       width: widget.containerWidth,
//       margin: EdgeInsets.only(
//         left: moveRightGroupIcon.value,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: <Widget>[
//           for (int i = 0; i < widget.reactions.length; i++)
//             Transform.scale(
//               scale: isDragging
//                   ? (currentIconFocus == i
//                       ? zoomIconChosen.value
//                       : (previousIconFocus == i
//                           ? zoomIconNotChosen.value
//                           : isJustDragInside
//                               ? zoomIconWhenDragInside.value
//                               : 0.8))
//                   : zoomIconLike.value,
//               child: Container(
//                 margin: EdgeInsets.only(bottom: pushIconLikeUp.value),
//                 width: 40.0,
//                 height: currentIconFocus == i ? 70.0 : 40.0,
//                 child: Column(
//                   children: <Widget>[
//                     if (currentIconFocus == i)
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.0),
//                             color: Colors.black.withOpacity(0.6)),
//                         padding: EdgeInsets.only(
//                             left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
//                         margin: EdgeInsets.only(bottom: 8.0),
//                         child: Text(
//                           '${widget.reactions[i].name}',
//                           style: TextStyle(fontSize: 8.0, color: Colors.white),
//                         ),
//                       ),
//                     widget.reactions[i].reaction,
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _reactionButtonBuilder() {
//     return GestureDetector(
//       onTapDown: onTapDownBtn,
//       onTapUp: onTapUpBtn,
//       onTap: onTapBtn,
//       child: Center(
//         child: Row(
//           children: [
//             Transform.scale(
//               scale: !isLongPress
//                   ? _handleOutputRangeZoomInIconLike(zoomIconLikeInBtn2.value)
//                   : zoomIconLikeInBtn.value,
//               child: Transform.rotate(
//                 angle: !isLongPress
//                     ? _handleOutputRangeTiltIconLike(tiltIconLikeInBtn2.value)
//                     : tiltIconLikeInBtn.value,
//                 child: widget.prefix,
//               ),
//             ),
//             if (widget.suffix != null)
//               SizedBox(
//                 width: 5.0,
//               ),
//             widget.suffix ?? Container(),
//           ],
//         ),
//       ),
//     );
//   }

//   void onHorizontalDragEndBoxIcon(DragEndDetails dragEndDetail) {
//     isDragging = false;
//     isJustDragInside = true;
//     previousIconFocus = 0;
//     currentIconFocus = 0;

//     onTapUpBtn(null);
//   }

//   void onHorizontalDragUpdateBoxIcon(DragUpdateDetails dragUpdateDetail) {
//     if (!isLongPress) return;
//     if (dragUpdateDetail.localPosition.dy >= -100 &&
//         dragUpdateDetail.localPosition.dy <= 100) {
//       isDragging = true;

//       if (isJustDragInside && !animControlIconWhenDragInside.isAnimating) {
//         animControlIconWhenDragInside.reset();
//         animControlIconWhenDragInside.forward();
//       }

//       var _a = widget.dragStart;
//       var _b = _a + widget.dragSpace;

//       for (int i = 1; i <= widget.reactions.length; i++) {
//         if (dragUpdateDetail.globalPosition.dx >= _a &&
//             dragUpdateDetail.globalPosition.dx < _b) {
//           if (currentIconFocus != (i - 1)) {
//             _handleWhenDragBetweenIcon(i - 1);
//           }
//         }

//         _a = _b;
//         _b = _a + widget.dragSpace;
//       }
//     } else {
//       whichIconUserChoose = 0;
//       previousIconFocus = 0;
//       currentIconFocus = 0;
//       isJustDragInside = true;

//       if (isDragging) {
//         isDragging = false;
//         animControlIconWhenDragOutside.reset();
//         animControlIconWhenDragOutside.forward();
//       }
//     }
//   }

//   void _handleWhenDragBetweenIcon(int currentIcon) {
//     whichIconUserChoose = currentIcon;
//     previousIconFocus = currentIconFocus;
//     currentIconFocus = currentIcon;
//     animControlIconWhenDrag.reset();
//     animControlIconWhenDrag.forward();
//   }

//   void onTapDownBtn(TapDownDetails tapDownDetail) {
//     holdTimer = Timer(durationLongPress, () {
//       _showBox();
//     });
//   }

//   void onTapUpBtn(TapUpDetails? tapUpDetail) {
//     if (isLongPress) {
//       if (widget.reactions.isNotEmpty)
//         widget.onReacted(widget.reactions[whichIconUserChoose]);
//       currentIconFocus = -1;
//     }
//     Timer(Duration(milliseconds: durationAnimationBox), () {
//       isLongPress = false;
//     });

//     holdTimer.cancel();

//     animControlBtnLongPress.reverse();

//     _setReverseValue();
//     animControlBox.reverse();

//     animControlIconWhenRelease.reset();
//     animControlIconWhenRelease.forward();
//   }

//   void onTapBtn() {
//     if (!isLongPress) {
//       if (whichIconUserChoose == 0) {
//         isLiked = !isLiked;
//         whichIconUserChoose = 1;
//       } else {
//         whichIconUserChoose = 0;
//       }
//       if (isLiked) {
//         animControlBtnShortPress.forward();
//       } else {
//         animControlBtnShortPress.reverse();
//       }
//       if (widget.reactions.isNotEmpty) {
//         if (widget.isReacted)
//           widget.onReacted(IrisReaction(name: null, reaction: Container()));
//         else
//           widget.onReacted(widget.reactions.first);
//       }
//     }
//   }

//   double _handleOutputRangeZoomInIconLike(double value) {
//     if (value >= 0.8) {
//       return value;
//     } else if (value >= 0.4) {
//       return 1.6 - value;
//     } else {
//       return 0.8 + value;
//     }
//   }

//   double _handleOutputRangeTiltIconLike(double value) {
//     if (value <= 0.2) {
//       return value;
//     } else if (value <= 0.6) {
//       return 0.4 - value;
//     } else {
//       return -(0.8 - value);
//     }
//   }

//   void _showBox() {
//     isLongPress = true;

//     animControlBtnLongPress.forward();

//     _setForwardValue();
//     animControlBox.forward();
//   }

//   void _setReverseValue() {
//     pushIconLikeUp = Tween(begin: 10.0, end: 15.0).animate(
//       CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
//     );
//     zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
//     );
//   }

//   void _setForwardValue() {
//     pushIconLikeUp = Tween(begin: 10.0, end: 15.0).animate(
//       CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
//     );
//     zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
//     );
//   }
// }

// class IrisReaction {
//   final String? name;
//   final Widget reaction;

//   IrisReaction({
//     required this.name,
//     required this.reaction,
//   });
// }

class CustomOverlay extends StatefulWidget {
  const CustomOverlay({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _CustomOverlayState createState() => _CustomOverlayState();
}

class _CustomOverlayState extends State<CustomOverlay> {
  final _overlayLink = _OverlayLink();

  @override
  Widget build(BuildContext context) {
    return _CustomOverlayLinkScope(
      overlayLink: _overlayLink,
      child: _CustomOverlayTheater(
        overlayLink: _overlayLink,
        child: widget.child,
      ),
    );
  }
}

class _OverlayLink {
  _RenderCustomOverlayTheater? theater;
  BoxConstraints? get constraints => theater?.constraints;

  final Set<RenderBox> overlays = {};
}

class _CustomOverlayLinkScope extends InheritedWidget {
  const _CustomOverlayLinkScope({
    Key? key,
    required _OverlayLink overlayLink,
    required Widget child,
  })  : _overlayLink = overlayLink,
        super(key: key, child: child);

  final _OverlayLink _overlayLink;

  @override
  bool updateShouldNotify(_CustomOverlayLinkScope oldWidget) {
    return oldWidget._overlayLink != _overlayLink;
  }
}

class _CustomOverlayTheater extends SingleChildRenderObjectWidget {
  const _CustomOverlayTheater({
    Key? key,
    required _OverlayLink overlayLink,
    required Widget child,
  })  : _overlayLink = overlayLink,
        super(key: key, child: child);

  final _OverlayLink _overlayLink;

  @override
  _RenderCustomOverlayTheater createRenderObject(BuildContext context) {
    return _RenderCustomOverlayTheater(_overlayLink);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderCustomOverlayTheater renderObject,
  ) {
    renderObject.overlayLink = _overlayLink;
  }
}

class _RenderCustomOverlayTheater extends RenderProxyBox {
  _RenderCustomOverlayTheater(this._overlayLink) {
    _overlayLink.theater = this;
  }

  _OverlayLink _overlayLink;
  _OverlayLink get overlayLink => _overlayLink;
  set overlayLink(_OverlayLink value) {
    if (_overlayLink != value) {
      assert(
        value.theater == null,
        'overlayLink already assigned to another overlay',
      );
      _overlayLink.theater = null;
      _overlayLink = value;
      value.theater = this;
    }
  }

  @override
  void markNeedsLayout() {
    for (final overlay in overlayLink.overlays) {
      overlay.markNeedsLayout();
    }
    super.markNeedsLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    for (var i = overlayLink.overlays.length - 1; i >= 0; i--) {
      final overlay = overlayLink.overlays.elementAt(i);

      context.paintChild(overlay, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final overlay in overlayLink.overlays) {
      if (overlay.hitTest(result, position: position)) {
        return true;
      }
    }

    return super.hitTestChildren(result, position: position);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<_OverlayLink>('overlayLink', overlayLink),
    );
  }
}

class CustomOverlayEntry extends StatefulWidget {
  const CustomOverlayEntry({
    Key? key,
    this.visible = true,
    this.childAnchor,
    this.overlayAnchor,
    this.overlay,
    this.closeDuration,
    required this.child,
  })  : assert(visible == false || overlay != null),
        assert((childAnchor == null) == (overlayAnchor == null)),
        super(key: key);

  final bool visible;
  final Alignment? overlayAnchor;
  final Alignment? childAnchor;
  final Widget? overlay;
  final Widget child;
  final Duration? closeDuration;

  @override
  _CustomOverlayEntryState createState() => _CustomOverlayEntryState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Alignment>('overlayAnchor', overlayAnchor))
      ..add(DiagnosticsProperty<Alignment>('childAnchor', childAnchor))
      ..add(DiagnosticsProperty<Duration>('closeDuration', closeDuration))
      ..add(DiagnosticsProperty<Widget>('overlay', overlay))
      ..add(DiagnosticsProperty<Widget>('child', child));
  }
}

class _CustomOverlayEntryState extends State<CustomOverlayEntry> {
  final _link = LayerLink();
  late bool _visible = widget.visible;
  Timer? _timer;

  @override
  void didUpdateWidget(CustomOverlayEntry oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.visible) {
      if (!oldWidget.visible && _visible) {
      } else if (oldWidget.visible && widget.closeDuration != null) {
        _timer?.cancel();
        _timer = Timer(widget.closeDuration!, () {
          setState(() => _visible = false);
        });
      } else {
        _visible = false;
      }
    } else {
      _timer?.cancel();
      _timer = null;
      _visible = widget.visible;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_CustomOverlayLinkScope>();
    if (scope == null) {
      throw CustomOverlayNotFoundError._(widget);
    }

    if (widget.overlayAnchor == null) {
      return _CustomOverlayEntryTheater(
        overlay: _visible ? widget.overlay : null,
        overlayLink: scope._overlayLink,
        child: widget.child,
      );
    }

    return Stack(
      children: <Widget>[
        CompositedTransformTarget(
          link: _link,
          child: widget.child,
        ),
        if (_visible)
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return _CustomOverlayEntryTheater(
                  overlayLink: scope._overlayLink,
                  loosen: true,
                  overlay: OverlayComposite(
                    link: _link,
                    childAnchor: widget.childAnchor!,
                    overlayAnchor: widget.overlayAnchor!,
                    targetSize: constraints.biggest,
                    child: widget.overlay,
                  ),
                  child: const SizedBox.shrink(),
                );
              },
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class _CustomOverlayEntryTheater extends SingleChildRenderObjectWidget {
  const _CustomOverlayEntryTheater({
    Key? key,
    required this.overlay,
    required this.overlayLink,
    this.loosen = false,
    required Widget child,
  }) : super(key: key, child: child);

  final Widget? overlay;
  final bool loosen;
  final _OverlayLink overlayLink;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCustomOverlayEntry(overlayLink, loosen: loosen);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderCustomOverlayEntry renderObject,
  ) {
    renderObject
      ..overlayLink = overlayLink
      ..loosen = loosen;
  }

  @override
  SingleChildRenderObjectElement createElement() =>
      _CustomOverlayEntryElement(this);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('loosen', loosen));
    properties.add(
      DiagnosticsProperty<_OverlayLink>('overlayLink', overlayLink),
    );
  }
}

class _RenderCustomOverlayEntry extends RenderProxyBox {
  _RenderCustomOverlayEntry(this._overlayLink, {required bool loosen})
      : assert(_overlayLink.theater != null),
        _loosen = loosen;

  bool _needsAddEntryInTheater = false;

  _OverlayLink _overlayLink;
  _OverlayLink get overlayLink => _overlayLink;
  set overlayLink(_OverlayLink value) {
    assert(value.theater != null);
    if (_overlayLink != value) {
      _overlayLink = value;
      markNeedsLayout();
    }
  }

  bool _loosen;
  bool get loosen => _loosen;
  set loosen(bool value) {
    if (value != _loosen) {
      _loosen = value;
      markNeedsLayout();
    }
  }

  RenderBox? _branch;
  RenderBox? get branch => _branch;
  set branch(RenderBox? value) {
    if (_branch != null) {
      _overlayLink.overlays.remove(branch);
      _overlayLink.theater!.markNeedsPaint();
      dropChild(_branch!);
    }
    _branch = value;
    if (_branch != null) {
      markNeedsAddEntryInTheater();
      adoptChild(_branch!);
    }
  }

  void markNeedsAddEntryInTheater() {
    _needsAddEntryInTheater = true;
    markNeedsLayout();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    if (_branch != null) {
      markNeedsAddEntryInTheater();
      _branch!.attach(owner);
    }
  }

  @override
  void detach() {
    super.detach();
    if (_branch != null) {
      _overlayLink.overlays.remove(branch);
      _overlayLink.theater!.markNeedsPaint();
      _branch!.detach();
    }
  }

  @override
  void markNeedsPaint() {
    super.markNeedsPaint();
    overlayLink.theater!.markNeedsPaint();
  }

  @override
  void performLayout() {
    super.performLayout();
    if (branch != null) {
      if (loosen) {
        branch!.layout(overlayLink.constraints!.loosen());
      } else {
        branch!.layout(BoxConstraints.tight(overlayLink.constraints!.biggest));
      }
      if (_needsAddEntryInTheater) {
        _needsAddEntryInTheater = false;
        _overlayLink.overlays.add(branch!);
        _overlayLink.theater!.markNeedsPaint();
      }
    }
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    if (child == branch) {
      transform.setFrom(overlayLink.theater!.getTransformTo(null));
    }
  }

  @override
  void redepthChildren() {
    super.redepthChildren();
    if (branch != null) {
      redepthChild(branch!);
    }
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    super.visitChildren(visitor);
    if (branch != null) {
      visitor(branch!);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<_OverlayLink>('overlayLink', overlayLink));
    properties.add(DiagnosticsProperty<bool>('loosen', loosen));
    properties.add(DiagnosticsProperty<RenderBox>('branch', branch));
  }
}

class _CustomOverlayEntryElement extends SingleChildRenderObjectElement {
  _CustomOverlayEntryElement(_CustomOverlayEntryTheater widget) : super(widget);

  @override
  _CustomOverlayEntryTheater get widget =>
      super.widget as _CustomOverlayEntryTheater;

  @override
  _RenderCustomOverlayEntry get renderObject =>
      super.renderObject as _RenderCustomOverlayEntry;

  Element? _branch;

  final _branchSlot = 42;

  @override
  void mount(Element? parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    _branch = updateChild(_branch, widget.overlay, _branchSlot);
  }

  @override
  void update(SingleChildRenderObjectWidget newWidget) {
    super.update(newWidget);
    _branch = updateChild(_branch, widget.overlay, _branchSlot);
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_branch != null) {
      visitor(_branch!);
    }
    super.visitChildren(visitor);
  }

  @override
  void forgetChild(Element child) {
    if (child == _branch) {
      _branch = null;
    } else {
      super.forgetChild(child);
    }
  }

  @override
  void insertRenderObjectChild(RenderObject child, dynamic slot) {
    if (slot == _branchSlot) {
      renderObject.branch = child as RenderBox;
    } else {
      super.insertRenderObjectChild(child, slot);
    }
  }

  @override
  void moveRenderObjectChild(
    RenderObject child,
    dynamic oldSlot,
    dynamic newSlot,
  ) {
    if (newSlot != _branchSlot) {
      super.moveRenderObjectChild(child, oldSlot, newSlot);
    }
  }

  @override
  void removeRenderObjectChild(RenderObject child, dynamic slot) {
    if (child == renderObject.branch) {
      renderObject.branch = null;
    } else {
      super.removeRenderObjectChild(child, slot);
    }
  }
}

class CustomOverlayNotFoundError<T extends CustomOverlay> extends Error {
  CustomOverlayNotFoundError._(this._overlayEntry);

  final CustomOverlayEntry _overlayEntry;

  @override
  String toString() {
    return '''
Error: Could not find a $T above this $_overlayEntry.
''';
  }
}

class OverlayComposite extends SingleChildRenderObjectWidget {
  const OverlayComposite({
    Key? key,
    required this.link,
    required this.targetSize,
    required this.childAnchor,
    required this.overlayAnchor,
    Widget? child,
  }) : super(key: key, child: child);

  final Alignment childAnchor;

  final Alignment overlayAnchor;

  final LayerLink link;

  final Size targetSize;

  @override
  OverlayCompositeLayer createRenderObject(BuildContext context) {
    return OverlayCompositeLayer(
      childAnchor: childAnchor,
      overlayAnchor: overlayAnchor,
      link: link,
      targetSize: targetSize,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    OverlayCompositeLayer renderObject,
  ) {
    renderObject
      ..link = link
      ..targetSize = targetSize
      ..childAnchor = childAnchor
      ..overlayAnchor = overlayAnchor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Alignment>('childAnchor', childAnchor));
    properties.add(
      DiagnosticsProperty<Alignment>('overlayAnchor', overlayAnchor),
    );
    properties.add(DiagnosticsProperty<LayerLink>('link', link));
    properties.add(DiagnosticsProperty<Size>('targetSize', targetSize));
  }
}

class OverlayCompositeLayer extends RenderProxyBox {
  OverlayCompositeLayer({
    required LayerLink link,
    required Size targetSize,
    required Alignment childAnchor,
    required Alignment overlayAnchor,
    RenderBox? child,
  })  : _childAnchor = childAnchor,
        _overlayAnchor = overlayAnchor,
        _link = link,
        _targetSize = targetSize,
        super(child);

  Alignment _childAnchor;

  Alignment get childAnchor => _childAnchor;
  set childAnchor(Alignment childAnchor) {
    if (childAnchor != _childAnchor) {
      _childAnchor = childAnchor;
      markNeedsPaint();
    }
  }

  Alignment _overlayAnchor;

  Alignment get overlayAnchor => _overlayAnchor;
  set overlayAnchor(Alignment overlayAnchor) {
    if (overlayAnchor != _overlayAnchor) {
      _overlayAnchor = overlayAnchor;
      markNeedsPaint();
    }
  }

  LayerLink _link;

  LayerLink get link => _link;
  set link(LayerLink value) {
    if (_link == value) {
      return;
    }
    _link = value;
    markNeedsPaint();
  }

  Size _targetSize;

  Size get targetSize => _targetSize;
  set targetSize(Size value) {
    if (_targetSize == value) {
      return;
    }
    _targetSize = value;
    markNeedsPaint();
  }

  @override
  void detach() {
    layer = null;
    super.detach();
  }

  @override
  bool get alwaysNeedsCompositing => true;

  @override
  bool get sizedByParent => false;

  @override
  FollowerLayer? get layer => super.layer as FollowerLayer?;

  Matrix4 getCurrentTransform() {
    return layer?.getLastTransform() ?? Matrix4.identity();
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return hitTestChildren(result, position: position);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return result.addWithPaintTransform(
      transform: getCurrentTransform(),
      position: position,
      hitTest: (result, position) {
        return super.hitTestChildren(result, position: position);
      },
    );
  }

  @override
  void performResize() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final linkedOffset = childAnchor.withinRect(
          Rect.fromLTWH(0, 0, targetSize.width, targetSize.height),
        ) -
        overlayAnchor.withinRect(Rect.fromLTWH(0, 0, size.width, size.height));

    if (layer == null) {
      layer = FollowerLayer(
        link: link,
        showWhenUnlinked: false,
        linkedOffset: linkedOffset,
      );
    } else {
      layer!
        ..link = link
        ..showWhenUnlinked = false
        ..linkedOffset = linkedOffset;
    }

    context.pushLayer(
      layer!,
      super.paint,
      Offset.zero,
      childPaintBounds: const Rect.fromLTRB(
        double.negativeInfinity,
        double.negativeInfinity,
        double.infinity,
        double.infinity,
      ),
    );
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.multiply(getCurrentTransform());
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<LayerLink>('link', link));
    properties.add(
        TransformProperty('current transform matrix', getCurrentTransform()));

    properties.add(DiagnosticsProperty('childAnchor', childAnchor));
    properties.add(DiagnosticsProperty('overlayAnchor', overlayAnchor));
    properties.add(DiagnosticsProperty('targetSize', targetSize));
  }
}
