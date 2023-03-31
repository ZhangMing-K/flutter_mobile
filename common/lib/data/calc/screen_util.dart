import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IrisScreenUtil {
  IrisScreenUtil._();

  static const bool useScreenUtil = true;
  static double scaleFactor = Get.textScaleFactor;
  static const bool isScale = true;
  static double dFontSize(double fontSize) {
    if (useScreenUtil) {
      return ScreenUtil().setSp(fontSize);
    }
    return fontSize;
  }

  static double dHeight(double height) {
    if (useScreenUtil) {
      return ScreenUtil().setHeight(height);
    }
    return height;
  }

  static double dWidth(double width, {double scale = 1.0}) {
    if (useScreenUtil) {
      return ScreenUtil().setWidth(width) * scale;
    }
    return width * scale;
  }
}
