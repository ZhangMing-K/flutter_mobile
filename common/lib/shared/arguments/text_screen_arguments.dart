import 'package:get/get.dart';

import '../../iris_common.dart';

class TextScreenArgs {
  final Rx<TextModel?>? text;
  final bool? isComment;

  TextScreenArgs({this.text, this.isComment = false});
}
