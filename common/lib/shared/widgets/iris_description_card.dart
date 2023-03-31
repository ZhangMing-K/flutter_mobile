import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'default_text_title.dart';

class IrisDescriptionCard extends StatelessWidget {
  final String? title;

  final String? description;
  final String? image;
  final Function? onTap;
  const IrisDescriptionCard(
      {Key? key, this.title, this.description, this.image, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!() : null,
      child: Container(
        // height: ScreenUtil().setHeight(135),
        decoration: BoxDecoration(
          color: context.theme.brightness == Brightness.dark
              ? const Color(0xff303235)
              : const Color(0xffECECEC),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultTextTitle(
                  textTitle: title,
                  fontSize: ScreenUtil().setSp(22),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (image != null)
                    Image.asset(
                      image!,
                      width: ScreenUtil().setWidth(90),
                      height: ScreenUtil().setHeight(60),
                    ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DefaultTextTitle(
                        textTitle: description,
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
