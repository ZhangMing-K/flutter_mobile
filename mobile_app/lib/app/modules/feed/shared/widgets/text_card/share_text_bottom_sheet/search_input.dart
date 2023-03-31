import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'share_text_controller.dart';

class ShareTextSearchInput extends StatelessWidget {
  const ShareTextSearchInput({Key? key, required this.controller})
      : super(key: key);
  final ShareTextController controller;
  //TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: CupertinoSearchTextField(
        onChanged: (value) {
          controller.onSearch(value);
        },
        onSubmitted: (value) {
          // controller.onSearch(value);
        },
        // controller: textEditingController,
        prefixInsets: const EdgeInsets.all(10),
        placeholder: 'Search',
        placeholderStyle: TextStyle(
            color: context.theme.colorScheme.secondary.withOpacity(0.7)),
        style: TextStyle(
            color: context.theme.colorScheme.secondary.withOpacity(0.7)),
      ),
    );
  }
}
