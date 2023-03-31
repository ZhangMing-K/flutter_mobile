import 'package:flutter/material.dart';

import '../themes/colors.dart';

class IrisAccordion extends StatefulWidget {
  /// An accordion is used to show (and hide) content. Use [showAccordion] to hide & show the accordion content.
  const IrisAccordion(
      {Key? key,
      this.title,
      this.content,
      this.titleChild,
      this.contentChild,
      this.collapsedTitleBackgroundColor = IrisColor.scaffoldBackgroundColor,
      this.expandedTitleBackgroundColor = IrisColor.subTitle,
      this.collapsedIcon = const Icon(Icons.keyboard_arrow_down),
      this.expandedIcon = const Icon(Icons.keyboard_arrow_up),
      this.textStyle = const TextStyle(color: Colors.black, fontSize: 16),
      this.titlePadding = const EdgeInsets.all(10),
      this.contentBackgroundColor = IrisColor.scaffoldBackgroundColor,
      this.contentPadding = const EdgeInsets.all(10),
      this.titleBorder = const Border(),
      this.contentBorder = const Border(),
      this.margin,
      this.showAccordion = false,
      this.onToggleCollapsed,
      this.titleBorderRadius = const BorderRadius.all(Radius.circular(0)),
      this.contentBorderRadius = const BorderRadius.all(Radius.circular(0))})
      : super(key: key);

  /// controls if the accordion should be collapsed or not making it possible to be controlled from outside
  final bool showAccordion;

  /// child of  type [Widget]is alternative to title key. title will get priority over titleChild
  final Widget? titleChild;

  /// content of type[String] which shows the messages after the [IrisAccordion] is expanded
  final String? content;

  /// contentChild of  type [Widget]is alternative to content key. content will get priority over contentChild
  final Widget? contentChild;

  /// type of [Color] or [IrisColor] which is used to change the background color of the [IrisAccordion] title when it is collapsed
  final Color collapsedTitleBackgroundColor;

  /// type of [Color] or [IrisColor] which is used to change the background color of the [IrisAccordion] title when it is expanded
  final Color expandedTitleBackgroundColor;

  /// collapsedIcon of type [Widget] which is used to show when the [IrisAccordion] is collapsed
  final Widget collapsedIcon;

  /// expandedIcon of type[Widget] which is used when the [IrisAccordion] is expanded
  final Widget expandedIcon;

  /// text of type [String] is alternative to child. text will get priority over titleChild
  final String? title;

  /// textStyle of type [textStyle] will be applicable to text only and not for the child
  final TextStyle textStyle;

  /// titlePadding of type [EdgeInsets] which is used to set the padding of the [IrisAccordion] title
  final EdgeInsets titlePadding;

  /// descriptionPadding of type [EdgeInsets] which is used to set the padding of the [IrisAccordion] description
  final EdgeInsets contentPadding;

  /// type of [Color] or [IrisColor] which is used to change the background color of the [IrisAccordion] description
  final Color contentBackgroundColor;

  /// margin of type [EdgeInsets] which is used to set the margin of the [IrisAccordion]
  final EdgeInsets? margin;

  /// titleBorderColor of type  [Color] or [IrisColor] which is used to change the border color of title
  final Border titleBorder;

  /// contentBorderColor of type  [Color] or [IrisColor] which is used to change the border color of content
  final Border contentBorder;

  /// titleBorderRadius of type  [Radius]  which is used to change the border radius of title
  final BorderRadius titleBorderRadius;

  /// contentBorderRadius of type  [Radius]  which is used to change the border radius of content
  final BorderRadius contentBorderRadius;

  /// function called when the content body collapsed
  final Function(bool?)? onToggleCollapsed;

  @override
  _IrisAccordionState createState() => _IrisAccordionState();
}

class _IrisAccordionState extends State<IrisAccordion>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController controller;
  // ignore: non_constant_identifier_names
  late Animation<Offset> offset;
  bool? showAccordion;

  @override
  void initState() {
    showAccordion = widget.showAccordion;
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    offset = Tween(
      begin: const Offset(0, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.slowMiddle,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: widget.margin ?? const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: _toggleCollapsed,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: widget.titleBorderRadius,
                  border: widget.titleBorder,
                  color: showAccordion!
                      ? widget.expandedTitleBackgroundColor
                      : widget.collapsedTitleBackgroundColor,
                ),
                // padding: widget.titlePadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: widget.title != null
                          ? Text(widget.title!, style: widget.textStyle)
                          : (widget.titleChild ?? Container()),
                    ),
                    if (showAccordion!)
                      widget.expandedIcon
                    else
                      widget.collapsedIcon
                  ],
                ),
              ),
            ),
            if (showAccordion!)
              Container(
                  decoration: BoxDecoration(
                    borderRadius: widget.contentBorderRadius,
                    border: widget.contentBorder,
                    color: widget.contentBackgroundColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: SlideTransition(
                    position: offset,
                    child: widget.content != null
                        ? Text(widget.content!)
                        : (widget.contentChild ?? Container()),
                  ))
            else
              Container()
          ],
        ),
      );

  void _toggleCollapsed() {
    setState(() {
      switch (controller.status) {
        case AnimationStatus.completed:
          controller.forward(from: 29);
          break;
        case AnimationStatus.dismissed:
          controller.forward();
          break;
        default:
      }
      showAccordion = !showAccordion!;
      if (widget.onToggleCollapsed != null) {
        widget.onToggleCollapsed!(showAccordion);
      }
    });
  }
}
