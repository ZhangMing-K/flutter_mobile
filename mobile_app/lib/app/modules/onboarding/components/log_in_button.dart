import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultTextTitle(
          textTitle: 'Already a member?',
          fontSize: ScreenUtil().setSp(15),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(Paths.Login.createPath([true]));
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: context.theme.colorScheme.secondary,
              fontSize: ScreenUtil().setSp(15),
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
