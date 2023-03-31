import 'package:flutter/cupertino.dart';

showSheet(
        {BuildContext? context, required Widget child, Widget? cancelButton}) =>
    showCupertinoModalPopup(
      context: context!,
      builder: (context) => CupertinoActionSheet(
        actions: [child],
        cancelButton: cancelButton,
      ),
    );
