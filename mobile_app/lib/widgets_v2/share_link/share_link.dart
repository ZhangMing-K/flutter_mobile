import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'share_link_controller.dart';

class LoadingPreview extends StatelessWidget {
  const LoadingPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 186,
      color: context.theme.backgroundColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 14),
          Text('Loading your preview...', style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }
}

class ShareLink extends StatelessWidget {
  ShareLinkController? controller;

  Share? shareLink;
  ShareLink({this.shareLink}) {
    controller = Get.put(ShareLinkController());
    if (shareLink!.shareKey != controller?.shareOriginal?.shareKey) {
      controller!.shareObjects.assignAll([shareLink!]);
      controller!.shareOriginal = shareLink;
      controller!.showAmounts = false.obs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        main(context),
        shareRow(context),
      ],
    );
  }

  errorWidget() {
    return Column(
      children: [
        const SizedBox(height: 14),
        Image.asset(Images.noItemsInFeed, height: 100),
        const SizedBox(height: 14),
        const Text('Error loading your preview...',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  header() {
    return Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(builder: (BuildContext context) {
              return Text(
                'Customize your share link',
                style: TextStyle(
                    fontSize: 20,
                    color: context.textTheme.bodyText1!.color,
                    fontWeight: FontWeight.bold),
              );
            })
          ],
        ));
  }

  imageContent() {
    return Obx(() {
      final shareObjectToDisplay = controller!.shareObjects.firstWhereOrNull(
          (element) => element.showAmounts == controller!.showAmounts.value);
      return Column(
        children: [
          imageTitle(),
          const SizedBox(height: 8),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey[300]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: shareObjectToDisplay?.imageUrl != null
                  ? CachedNetworkImage(
                      // height: 250,
                      cacheManager: Get.find<IrisImageCacheManager>(),
                      imageUrl: shareObjectToDisplay!.imageUrl,
                      errorWidget: (context, url, error) => errorWidget(),
                      placeholder: (context, url) => const LoadingPreview(),
                    )
                  : const LoadingPreview()),
        ],
      );
    });
  }

  imageTitle() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(builder: (BuildContext context) {
              return Text('Your link preview',
                  style: TextStyle(
                    fontSize: 16,
                    color: context.textTheme.bodyText1!.color,
                    fontWeight: FontWeight.bold,
                  ));
            }),
            const Icon(Icons.image)
          ],
        ));
  }

  main(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            header(),
            ListTile(
              title: Text('Would you like to show real dollar amounts?',
                  style: TextStyle(
                      fontSize: 16,
                      color: context.theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold)),
              trailing: SizedBox(width: 150, child: shareView()),
            ),
            const SizedBox(height: 8),
            imageContent(),
          ],
        )
      ],
    );
  }

  pill(text) {
    return SizedBox(
      width: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(text)],
      ),
    );
  }

  Widget shareRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 12, left: 14, right: 14),
      child: Row(children: [
        Expanded(
            child: ElevatedButton(
                child: const Text('Share',
                    style: TextStyle(
                        fontSize: 16, color: IrisColor.accentColorDark)),
                onPressed: () async {
                  HapticFeedback.mediumImpact();
                  await controller!.share();
                })),
        const SizedBox(width: 8),
        Expanded(
            child: OutlinedButton(
                child: const Text('Copy Link'),
                onPressed: () async {
                  await controller!.copyLink(context);
                })),
      ]),
    );
  }

  Widget shareView() {
    //TODO: Why create a globalKey here??
    final _formKey = GlobalKey<FormBuilderState>();
    controller!.shareKey = _formKey;
    return Column(children: [
      FormBuilder(
          key: controller!.shareKey,
          initialValue: {
            'showAmounts': controller!.showAmounts.value,
          },
          child: Column(
            children: <Widget>[
              // Text('Would you like to show real dollar amounts?'),
              FormBuilderChoiceChip(
                name: 'showAmounts',
                spacing: 8.0,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.end,
                alignment: WrapAlignment.end,
                direction: Axis.horizontal,
                onChanged: (dynamic val) {
                  controller!.showAmounts.value = val;
                  controller!.generateLink();
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                options: [
                  FormBuilderFieldOption(value: true, child: pill('Yes')),
                  FormBuilderFieldOption(value: false, child: pill('No')),
                ],
              ),
            ],
          )),
    ]);
  }
}
