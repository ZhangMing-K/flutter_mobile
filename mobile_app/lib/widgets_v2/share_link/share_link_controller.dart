import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:share_plus/share_plus.dart' as package;

class ShareLinkController extends GetxController {
  RxList<Share> shareObjects = <Share>[].obs;
  Share? shareOriginal;
  Rx<Share?> shareWithAmounts = Rx<Share?>(null);
  RxBool showAmounts = false.obs;
  final BaseController baseController = Get.find();
  final SocialService socialService = Get.find();
  GlobalKey<FormBuilderState>? shareKey;

  Share? get shareObjectToUse {
    return shareObjects.firstWhereOrNull(
        (element) => element.showAmounts == showAmounts.value);
  }

  copyLink(context) async {
    Get.back();
    await FlutterClipboard.copy(shareObjectToUse!.url);
    IrisSnackbar.trigger(
      title: 'Copied to your clipboard!',
      body: 'Share this!',
    );
  }

  @override
  dispose() {
    debugPrint('SLIDE UP DISPOSED');
    super.dispose();
  }

  generateLink() async {
    if (shareObjectToUse == null) {
      final share = (await socialService.shareCreate(
          entityKey: shareOriginal!.entityKey,
          shareType: shareOriginal!.shareType!,
          showAmounts: showAmounts.value))!;

      final List<Share> newList = [...shareObjects, share];
      shareObjects.assignAll(newList);
    }
  }

  share() async {
    Get.back();
    await package.Share.share(shareObjectToUse!.url);

    Get.delete<ShareLinkController>();
  }
}
