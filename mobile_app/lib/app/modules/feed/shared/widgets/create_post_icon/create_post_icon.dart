import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/post_input/post_input.dart';
import 'package:iris_mobile/app/routes/pages.dart';

class CreatePostIcon extends StatelessWidget {
  final Function(PostInputInfo info) onSubmit;

  const CreatePostIcon({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        Images.add_post,
        width: 25,
        height: 25,
        color: context.theme.colorScheme.secondary,
      ),
      onPressed: () {
        PostInput.show(
            submitName: 'Publish',
            isFullPage: true,
            // showDDCards: true,
            textType: TEXT_TYPE.POST,
            createTextType: CreateTextType(textType: TEXT_TYPE.POST),
            focusNode: FocusNode(),
            hintText: 'What\'s on your mind?',
            onSubmit: onSubmit,
            onTyping: () {});
      },
    );
  }

  Widget postOptions({
    required VoidCallback onTap,
    required String name,
    required IconData icon,
  }) {
    return Material(
      child: InkWell(
        onTap: () {
          // Close bottomsheet after click
          Get.back();
          // Prevent glitches on route
          Future(() => onTap());
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                icon,
              ),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
