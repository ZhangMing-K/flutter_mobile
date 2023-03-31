import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/rich_text/rich_text_field.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/share_text_bottom_sheet/share_as_image.dart';

import 'search_input.dart';
import 'share_inbox_item.dart';
import 'share_inbox_item_controller.dart';
import 'share_text_controller.dart';

class ShareTextView extends StatefulWidget {
  final ShareTextController controller;
  final ScrollController? scrollController;
  final String? textShared;

  const ShareTextView(
      {Key? key,
      required this.controller,
      this.scrollController,
      this.textShared = 'Post successfully shared'})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ShareTextViewState();
}

class ShareTextViewState extends State<ShareTextView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;
  SlideUpController slideUpController = SlideUpController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: context.theme.backgroundColor,
        ),
        child: Obx(() {
          return widget.controller.isSending.value
              ? Center(child: shareFinished(context))
              : listView();
          // listView(context);
        }));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  emptyWidget(BuildContext context) {
    return NoData(
      text: 'No users match your search',
      backgroundColor: null,
      type: NO_DATA_TYPE.FIT,
      image: Image.asset(Images.noItemsInFeed, width: 300, height: 300),
    );
  }

  hide() {
    controller.reverse();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));

    offset = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          // Start animation at begin
          slideUpController.toggle();
        } else if (status == AnimationStatus.dismissed) {
          // To hide widget, we need complete animation first
          slideUpController.toggle();
        }
      });
  }

  Widget shareFinished(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: context.theme.colorScheme.secondary, width: 2)),
          padding: const EdgeInsets.all(2),
          child: Icon(
            Icons.check,
            color: context.theme.colorScheme.secondary,
            size: 18,
          ),
        ),
        const SizedBox(height: 15),
        Text(widget.textShared!,
            style: TextStyle(
                color: context.theme.colorScheme.secondary.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.normal))
      ],
    );
  }

  Widget listView() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 24, bottom: 12),
            child: ShareTextAsImageButton(
                text: widget.controller.sharedText.value),
          ),
          const Spacer(),
        ],
      ),
      ShareTextSearchInput(controller: widget.controller),
      const SizedBox(height: 12),
      Obx(() {
        final listItems = widget.controller.getDisplayItems();
        return Expanded(
            child: IrisListView(
                itemCount: listItems.length,
                controller: widget.scrollController!,
                emptyWidget: emptyWidget(context),
                widgetLoader: const ShimmerScroll(useSpinner: true),
                loadMore: widget.controller.inboxList$.isNotEmpty
                    ? widget.controller.loadMore
                    : widget.controller.loadMoreFollower,
                builder: (BuildContext context, int index) {
                  final dynamic item = listItems[index];
                  TextModel inboxItem = const TextModel();
                  User userItem = const User();
                  if (item is TextModel) {
                    inboxItem = item;
                  } else {
                    userItem = item;
                  }
                  final inboxType = item is TextModel
                      ? SHARE_INBOX_TYPE.INBOX
                      : SHARE_INBOX_TYPE.USER;
                  final ShareInboxItemController itemController =
                      ShareInboxItemController(
                          inboxType: inboxType,
                          text: inboxItem.obs,
                          user: userItem.obs);
                  return ShareInboxItemView(
                    controller: widget.controller,
                    itemController: itemController,
                    text: inboxItem.obs,
                    user: userItem.obs,
                    isLast: index == widget.controller.inboxList$.length - 1,
                    isFirst: index == 0,
                    onShow: show,
                    onHide: hide,
                    inboxType: inboxType,
                  );
                }));
      }),
      Stack(
        children: <Widget>[
          SlideTransition(
            position: offset,
            child: SlideUpWidget(
              controller: slideUpController,
              child: textField(context),
            ),
          ),
        ],
      ),
      Builder(builder: (context) {
        return Container(
          margin: EdgeInsets.only(
              top: 16, bottom: context.isKeyboardOpen ? 16 : 40),
          child: sendBtn(),
        );
      })
    ]);
  }

  Widget sendBtn() {
    return Obx(() {
      final isDisabled = widget.controller.selectedInbox$.isEmpty &&
          widget.controller.selectedFollowerList$.isEmpty;
      return Container(
          height: 50,
          width: Get.width - 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: isDisabled
                ? Colors.grey[400]
                : IrisColor.backgroundColorDark.withOpacity(0.7),
          ),
          child: TextButton(
            child: Text(
              widget.controller.selectedInbox$.length +
                          widget.controller.selectedFollowerList$.length >
                      1
                  ? 'Send separately'
                  : 'Send',
              style: TextStyle(
                  fontSize: 18, color: context.theme.colorScheme.secondary),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(isDisabled
                    ? Colors.grey[500]!
                    : context.theme.primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(color: Colors.white, fontSize: 12))),
            onPressed: () async {
              widget.controller.share();
            },
          ));
    });
  }

  show() {
    controller.forward();
  }

  Widget textField(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: .8,
              color: Colors.grey[800]!,
            ),
          ),
          color: context.theme.backgroundColor.withAlpha(50),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichTextField(
              focusNode: focusNode,
              textEditingController: widget.controller.textEdittingController,
              hintText: 'Write a message ...',
              createTextType: CreateTextType(
                textType: TEXT_TYPE.POST,
              ),
              onTyping: () {},
            ),
          ],
        ));
  }
}
