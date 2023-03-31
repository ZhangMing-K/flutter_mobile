import 'package:flutter/material.dart';

class KeyboardListenerWrapper extends StatefulWidget {
  final Widget child;
  const KeyboardListenerWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  static bool of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<InheritedKeyboardCheck>())!
        .isKeyboardOpen;
  }

  @override
  KeyboardListenerWrapperState createState() => KeyboardListenerWrapperState();
}

extension KeyboardOpenExt on BuildContext {
  bool get isKeyboardOpen {
    return KeyboardListenerWrapper.of(this);
  }
}

class KeyboardListenerWrapperState extends State<KeyboardListenerWrapper> {
  bool _isKeyboardOpen = false;

  @override
  void didChangeDependencies() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final newValue = bottomInset != 0.0;
    if (newValue != _isKeyboardOpen) {
      _isKeyboardOpen = newValue;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedKeyboardCheck(
        isKeyboardOpen: _isKeyboardOpen, child: widget.child);
  }
}

class InheritedKeyboardCheck extends InheritedWidget {
  const InheritedKeyboardCheck({
    Key? key,
    required Widget child,
    required this.isKeyboardOpen,
  }) : super(key: key, child: child);

  final bool isKeyboardOpen;

  @override
  bool updateShouldNotify(InheritedKeyboardCheck oldWidget) {
    return isKeyboardOpen != oldWidget.isKeyboardOpen;
  }
}
