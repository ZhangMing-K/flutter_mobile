import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

import 'article_shared_message_text.dart';
import 'order_shared_message_text.dart';
import 'post_shared_message_text.dart';

class SharedMessageText extends StatelessWidget {
  final TextModel? text;
  final double scaleFactor;
  final bool isCancellable;
  final int? fromCollectionKey;
  final Function()? onCancelSharingOrder;
  final Function()? onTap;
  final IrisEvent irisEvent;
  const SharedMessageText({
    Key? key,
    required this.text,
    this.fromCollectionKey,
    this.isCancellable = false,
    this.scaleFactor = 1.0,
    this.onCancelSharingOrder,
    this.onTap,
    required this.irisEvent,
  }) : super(key: key);

  Widget get shared {
    switch (text!.textType) {
      case TEXT_TYPE.POST:
        return SharedTextPost(text: text);
      case TEXT_TYPE.ORDER:
        return SharedTextOrder(
            text: text,
            isCancellable: isCancellable,
            scaleFactor: scaleFactor,
            onCancelSharingOrder: onCancelSharingOrder,
            onTap: onTap);
      case TEXT_TYPE.ASSET_ARTICLE:
        return SharedTextArticle(text: text);
      case TEXT_TYPE.ARTICLE:
        return Container();
      // return SharedTextV2Article(text: text);
      case null:

        /// WORKAROUND: Instead of text!.textType == TEXT_TYPE.ORDER,
        /// the value always comes to null. I will investigate if there
        /// is any possibility to fix this in the frontend without
        /// relying on modifications in the backend.
        return SharedTextOrder(
            text: text,
            isCancellable: isCancellable,
            scaleFactor: scaleFactor,
            onCancelSharingOrder: onCancelSharingOrder,
            onTap: onTap);
      default:
        return const Text('no shared widget made for this');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      seenDuration: const Duration(seconds: 2),
      onSeen: () {
        irisEvent.registerTextView(
            textKey: text!.textKey!,
            from: TEXT_VIEW_FROM.COLLECTION,
            fromCollectionKey: fromCollectionKey);
      },
      child: Container(child: shared),
    );
  }
}
