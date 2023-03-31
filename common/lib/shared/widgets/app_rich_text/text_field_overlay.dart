import 'package:flutter/material.dart';

class TextFieldOverlay extends StatelessWidget {
  const TextFieldOverlay({Key? key}) : super(key: key);

  static show({required BuildContext context}) {
    final OverlayState overlayState = Overlay.of(context)!;
    final OverlayEntry overlayEntry = OverlayEntry(builder: (c) {
      return Positioned(
        width: 56,
        height: 20,
        top: 300 - 72.2,
        left: 300 - 72.2,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () => debugPrint('ON TAP OVERLAY!'),
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.redAccent),
            ),
          ),
        ),
      );
    });
    overlayState.insert(overlayEntry);
  }

  @override
  build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      color: Colors.red,
    );
  }
}
