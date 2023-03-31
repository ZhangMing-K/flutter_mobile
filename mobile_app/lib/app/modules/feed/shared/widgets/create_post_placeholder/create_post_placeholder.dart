import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../post_input/post_input.dart';

class CreatePostPlaceholder extends StatelessWidget {
  const CreatePostPlaceholder(
      {Key? key, required this.onSubmit, required this.avatarUrl})
      : super(key: key);
  final Function(PostInputInfo info) onSubmit;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        borderRadius: kBorderRadius,
        color: context.theme.backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                PostInput.show(
                    submitName: 'Post',
                    isFullPage: true,
                    textType: TEXT_TYPE.POST,
                    createTextType: CreateTextType(textType: TEXT_TYPE.POST),
                    focusNode: FocusNode(),
                    hintText: 'What\'s on your mind?',
                    onSubmit: onSubmit,
                    onTyping: () {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    ProfileImage(
                      radius: 16,
                      url: avatarUrl,
                      uuid: uuid.v4(),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Text(
                        'What\'s on your mind?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: context.theme.colorScheme.secondary
                              .withOpacity(.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
