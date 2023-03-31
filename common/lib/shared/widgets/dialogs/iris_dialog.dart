import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IrisDialog extends StatelessWidget {
  final String title;
  final String? cancelButtonText;
  final String? subtitle;
  final String? confirmButtonText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  ///whether or not the confirm action destroys some piece of data.
  ///will draw confirm as red
  final bool confirmIsDestructive;

  ///Platform specific dialog
  const IrisDialog({
    Key? key,
    required this.title,
    this.cancelButtonText = 'Cancel',
    this.subtitle,
    this.onCancel,
    this.onConfirm,
    this.confirmIsDestructive = false,
    this.confirmButtonText = 'OK',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetPlatform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: subtitle == null ? null : Text(subtitle!),
            actions: [
              if (onCancel != null)
                CupertinoDialogAction(
                  child: Text(cancelButtonText!),
                  onPressed: onCancel,
                ),
              if (onConfirm != null)
                CupertinoDialogAction(
                  child: Text(
                    confirmButtonText!,
                    style:
                        TextStyle(color: context.theme.colorScheme.secondary),
                  ),
                  isDestructiveAction: confirmIsDestructive,
                  onPressed: onConfirm,
                ),
            ],
          )
        : AlertDialog(
            title: Text(title),
            content: subtitle == null ? null : Text(subtitle!),
            actions: [
              if (onCancel != null)
                TextButton(
                  child: Text(cancelButtonText!,
                      style: const TextStyle(color: Colors.blue)),
                  onPressed: onCancel,
                ),
              if (onConfirm != null)
                TextButton(
                  child: Text(
                    confirmButtonText!,
                    style: TextStyle(
                      color: confirmIsDestructive ? Colors.red : null,
                    ),
                  ),
                  onPressed: onConfirm,
                ),
            ],
          );
  }
}
