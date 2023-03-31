import 'package:flutter/material.dart';

class IrisAutoScrollContent extends StatelessWidget {
  const IrisAutoScrollContent({Key? key, required this.child})
      : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      reverse: true,
      shrinkWrap: true,
      slivers: [
        SliverFillRemaining(
          child: Builder(builder: (focusedCtx) {
            /// Media Query will add a listener to this context
            /// for all keyboard height changes
            MediaQuery.of(focusedCtx);

            /// the primary focus will only be attached to this context
            /// after the build, so we have to use microtask from Future.
            /// 400 miliseconds is needing for iOS keyboard
            Future.delayed(const Duration(milliseconds: 400))
                .then((_) => Scrollable.ensureVisible(
                      FocusManager.instance.primaryFocus!.context!,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    ));
            return child;
          }),
        ),
      ],
    );
  }
}
