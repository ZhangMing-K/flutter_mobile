import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card.dart';
import 'package:iris_mobile/app/routes/pages.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({
    Key? key,
    required this.text$,
    required this.heroTag,
    this.alignment = const Alignment(0, -.25),
  }) : super(key: key);

  final String heroTag;
  final Rx<TextModel> text$;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final scaleFactor = context.textScaleFactor;
    return Material(
      type: MaterialType.transparency,
      child: (text$.value.textKey == null)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IrisLoading(size: 40 * scaleFactor),
                SizedBox(height: 16 * scaleFactor),
                const Center(child: Text('Loading new story'))
              ],
            )
          : Align(
              alignment: alignment,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextCard(
                      text: text$,
                      textCardDisplayType: TEXT_CARD_DISPLAY_TYPE.STORY),
                ],
              ),
            ),
    );
  }
}
