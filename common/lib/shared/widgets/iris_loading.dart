import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/consts/units.dart';

import 'default_text_title.dart';

/// returns a platform adaptive loading indicator
/// `CupertinoActivityIndicator` when on ios
/// `CircularProgressIndicator` when on android
/// `size` simple dictates the height and width of said indicator
class IrisLoading extends StatelessWidget {
  final String? loadingText;
  final double size;

  const IrisLoading({Key? key, this.loadingText, this.size = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Platform.isIOS
                ? const CupertinoActivityIndicator(
                    radius: 10,
                  )
                : SizedBox(
                    height: size,
                    width: size,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          context.theme.primaryColor),
                    ),
                  ),
            if (loadingText != null) ...[
              const SizedBox(height: 14),
              DefaultTextTitle(
                textTitle: loadingText,
                fontSize: TextUnit.medium,
                fontWeight: FontWeight.w400,
                color: context.theme.hintColor,
              )
            ],
          ],
        ));
  }
}
