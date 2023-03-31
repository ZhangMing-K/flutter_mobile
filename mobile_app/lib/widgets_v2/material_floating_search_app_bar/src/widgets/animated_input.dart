import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../search_bar_style.dart';
import '../text_controller.dart';
import 'no_keyboard_focus_node.dart';

class AnimatedInput extends StatefulWidget {
  const AnimatedInput({
    Key? key,
    this.child,
    this.input,
    this.hintText,
    this.style,
    this.onTapInput,
    this.onTapCancel,
    this.showBack,
    this.showCloseIcon,
  }) : super(key: key);

  final Widget? child;
  final String? hintText;
  final TextController? input;
  final FloatingSearchAppBarStyle? style;
  final Function? onTapInput;
  final Function? onTapCancel;
  final bool? showBack;
  final bool? showCloseIcon;

  @override
  createState() => AnimatedInputState();
}

class AnimatedInputState extends State<AnimatedInput>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = CurvedAnimation(
        parent: controller, curve: Curves.fastLinearToSlowEaseIn);
    super.initState();
  }

  FocusNode? _focusNode = NoKeyboardEditableTextFocusNode();
  late final AnimationController controller;
  late final Animation animation;

  _animateAppBar() {
    if (mounted) {
      controller.forward();
      setState(() {
        _focusNode = widget.input!.node;
      });
    }
  }

  _animateBackAppBar() {
    if (mounted) {
      controller.reverse();
      setState(() {
        _focusNode = NoKeyboardEditableTextFocusNode();
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedInputField(
        animation: animation as Animation<double>,
        onPress: _animateAppBar,
        onPressCancel: _animateBackAppBar,
        input: widget.input,
        hintText: widget.hintText,
        style: widget.style,
        onTapInput: widget.onTapInput,
        child: widget.child,
        onTapCancel: widget.onTapCancel,
        focusNode: _focusNode,
        showBack: widget.showBack,
        showCloseIcon: widget.showCloseIcon);
  }
}

class AnimatedInputField extends AnimatedWidget {
  const AnimatedInputField(
      {Key? key,
      required Animation<double> animation,
      this.onPress,
      this.onPressCancel,
      this.hintText,
      this.input,
      this.style,
      this.onTapInput,
      this.child,
      this.onTapCancel,
      this.focusNode,
      this.showBack,
      this.showCloseIcon})
      : super(key: key, listenable: animation);

  final Function? onPress;
  final Function? onPressCancel;
  static final _sizeTween = Tween<double>(begin: 0.0, end: 30.0);
  final String? hintText;
  final Widget? child;
  final TextController? input;
  final FloatingSearchAppBarStyle? style;
  final Function? onTapInput;
  final Function? onTapCancel;
  final bool? showBack;
  final bool? showCloseIcon;
  final FocusNode? focusNode;

  Widget _buildInputField() {
    return NotificationListener<ScrollNotification>(
        onNotification: (_) => true,
        child: Builder(builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: showBack!
                    ? screenWidth -
                        85 -
                        _sizeTween.evaluate(listenable as Animation<double>) *
                            1.5
                    : screenWidth -
                        25 -
                        _sizeTween.evaluate(listenable as Animation<double>) *
                            2.5,
                height: 40,
                child: Theme(
                  child: TextField(
                    controller: input,
                    scrollPadding: EdgeInsets.zero,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    focusNode: focusNode,
                    maxLines: 1,
                    autofocus: false,
                    cursorColor: style!.accentColor,
                    style: style!.queryStyle!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                    onTap: () {
                      onTapInput!();
                      onPress!();
                    },
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 16.0),
                      isDense: true,
                      contentPadding: const EdgeInsets.only(left: 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Theme.of(context).backgroundColor,
                      suffixIcon: showCloseIcon!
                          ? GestureDetector(
                              onTap: () {
                                onTapCancel!();
                              },
                              child: const Icon(Icons.close,
                                  size: 24, color: Colors.grey))
                          : null,
                      prefixIcon: const Icon(Icons.search,
                          size: 24, color: Colors.grey),
                    ),
                  ),
                  data: Theme.of(context).copyWith(primaryColor: Colors.grey),
                ),
              ));
        }));
  }

  @override
  Widget build(BuildContext context) {
    final icon =
        GetPlatform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios;
    const marginLeft = 15.5;
    const marginRight = 15.0;
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: showBack! ? marginLeft : 0,
              right: showBack! ? marginRight : 0),
          child: showBack!
              ? GestureDetector(
                  child: Icon(
                    icon,
                    color: Theme.of(context).appBarTheme.iconTheme!.color,
                    size: 24,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              : null,
        ),
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: <Widget>[
              _buildInputField(),
              Positioned(
                  right: 0,
                  child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      transform: Matrix4.translationValues(
                          (showBack! ? 90 : 100) -
                              _sizeTween.evaluate(
                                      listenable as Animation<double>) *
                                  3,
                          0.0,
                          0.0),
                      child: GestureDetector(
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: context.theme.appBarTheme.iconTheme!.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        onTap: () {
                          onPressCancel!();
                          onTapCancel!();
                        },
                      ))),
            ],
          ),
        ),
      ],
    );
  }
}
