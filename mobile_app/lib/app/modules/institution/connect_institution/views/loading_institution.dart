import 'package:flutter/material.dart';

class LoadingConnectInstitution extends StatefulWidget {
  const LoadingConnectInstitution(
      {Key? key, this.duration = const Duration(seconds: 10)})
      : super(key: key);

  final Duration? duration;

  @override
  _LoadingConnectInstitutionState createState() =>
      _LoadingConnectInstitutionState();
}

class _LoadingConnectInstitutionState extends State<LoadingConnectInstitution>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        // animationBehavior: AnimationBehavior.,

        duration: widget.duration,
        vsync: Scaffold.of(context));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: widget.duration!,
        curve: Curves.decelerate,
        builder: (context, dynamic d, widget) {
          debugPrint(d);
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.grey.shade200.withOpacity(.2),
              height: d * MediaQuery.of(context).size.height,
            ),
          );
        });
  }
}
