import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/story/widgets/story_user_info_header.dart';

class UserStoryGestureItem extends StatelessWidget {
  const UserStoryGestureItem({
    Key? key,
    required this.text,
    required this.user,
  }) : super(key: key);

  final Rx<TextModel> text;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: StoryUserInfoHeader(text: text, user: user)),
    );
  }
}
