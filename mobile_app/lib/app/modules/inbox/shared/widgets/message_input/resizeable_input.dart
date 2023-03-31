import 'package:flutter/material.dart';

class ResizeableInput extends StatefulWidget {
  const ResizeableInput(
      {Key? key,
      this.child,
      this.actionItems,
      this.actionMoreItem,
      this.textEdittingController,
      this.showBack})
      : super(key: key);

  final Widget? child;
  final Widget? actionItems;
  final Widget? actionMoreItem;
  final bool? showBack;
  final TextEditingController? textEdittingController;

  @override
  createState() => ResizeableInputState();
}

class ResizeableInputState extends State<ResizeableInput>
    with SingleTickerProviderStateMixin {
  ResizeableInputState();

  late AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 800), vsync: this);
  late Animation animation =
      CurvedAnimation(parent: controller, curve: Curves.fastLinearToSlowEaseIn);

  _animateAppBar() {
    controller.forward();
  }

  _animateBackAppBar() {
    controller.reverse();
  }

  @override
  void initState() {
    widget.textEdittingController!.addListener(textValueChanged);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.textEdittingController != null) {
      widget.textEdittingController!.removeListener(textValueChanged);
    }
    controller.dispose();
    super.dispose();
  }

  void textValueChanged() {
    if (widget.textEdittingController!.text.length > 12) {
      _animateAppBar();
    } else if (widget.textEdittingController!.text.length < 12) {
      _animateBackAppBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedInputField(
      animation: animation as Animation<double>,
      onPress: _animateAppBar,
      onPressCancel: _animateBackAppBar,
      child: widget.child,
      actionItems: widget.actionItems,
      actionMoreItem: widget.actionMoreItem,
      textEdittingController: widget.textEdittingController,
    );
  }
}

class AnimatedInputField extends AnimatedWidget {
  const AnimatedInputField(
      {Key? key,
      required Animation<double> animation,
      this.onPress,
      this.onPressCancel,
      this.onTapInput,
      this.child,
      this.actionItems,
      this.actionMoreItem,
      this.onTapCancel,
      this.focusNode,
      this.textEdittingController,
      this.showBack})
      : super(key: key, listenable: animation);

  final Function? onPress;
  final Function? onPressCancel;
  static final _sizeTween = Tween<double>(begin: 0.0, end: 30.0);
  final Widget? child;
  final Widget? actionItems;
  final Widget? actionMoreItem;
  final Function? onTapInput;
  final Function? onTapCancel;
  final bool? showBack;
  final TextEditingController? textEdittingController;
  final FocusNode? focusNode;
  Widget _buildInputField(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth -
          140 +
          _sizeTween.evaluate(listenable as Animation<double>) * 2.5,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              _buildInputField(context),
              Positioned(
                left: 0,
                child: Container(
                  transform: Matrix4.translationValues(
                      -50 +
                          _sizeTween.evaluate(listenable as Animation<double>) *
                              2,
                      0.0,
                      0.0),
                  child: InkWell(
                    child: actionMoreItem,
                    onTap: () {
                      onPressCancel!();
                    },
                  ),
                ),
              ),
              Positioned(
                left: 0,
                child: Container(
                  transform: Matrix4.translationValues(
                      0 -
                          _sizeTween.evaluate(listenable as Animation<double>) *
                              4,
                      0.0,
                      0.0),
                  child: actionItems,
                  height: 50,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
