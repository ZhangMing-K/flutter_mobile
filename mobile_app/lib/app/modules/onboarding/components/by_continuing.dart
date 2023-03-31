import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class ByContinuing extends StatelessWidget {
  const ByContinuing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(width: IrisScreenUtil.dWidth(4)),
        DefaultTextTitle(
          textTitle: 'By continuing you are agreeing to our',
          fontSize: IrisScreenUtil.dFontSize(12),
        ),
        TextButton(
          onPressed: () async {
            const url = kTermsOfServiceUrl;
            UrlUtils.open(url);
          },
          child: Text(
            'Terms & Conditions.',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: context.theme.primaryColor,
              fontSize: IrisScreenUtil.dFontSize(12), // * scaleFactor,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
