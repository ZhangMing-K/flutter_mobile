import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iris_common/shared/index.dart';

class SnackBarService extends GetxService {
  static SnackBarService get to => Get.find();

  void oneLine({
    required String imageUrl,
    required String name,
    required String content,
    required VoidCallback? onPressed,
  }) {
    _snackbarWrapper(
      url: imageUrl,
      onPressed: onPressed,
      body: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w300,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '$name ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: content),
          ],
        ),
      ),
    );
  }

  void twoLine({
    required String? imageUrl,
    required String name,
    required String subtitle,
    required VoidCallback? onPressed,
  }) {
    _snackbarWrapper(
      url: imageUrl,
      onPressed: onPressed,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }

  void threeLine({
    required String imageUrl,
    required String name,
    required String subtitle,
    required String content,
    required VoidCallback? onPressed,
  }) {
    _snackbarWrapper(
      url: imageUrl,
      onPressed: onPressed,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }

  void _snackbarWrapper({
    required String? url,
    required Widget body,
    required VoidCallback? onPressed,
  }) {
    Get.rawSnackbar(
        onTap: (_) {
          onPressed?.call();
        },
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(16),
        backgroundColor: !Get.isDarkMode
            ? const Color(0xffDCDCDC).withOpacity(.9)
            : const Color(0xff333333).withOpacity(.9),
        borderRadius: 8,
        barBlur: 7,
        messageText: Row(
          children: [
            ClipOval(
              child: SizedBox(
                height: 32,
                width: 32,
                child: ProfileImage(
                  url: url,
                  uuid: uuid.v4(),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(child: body)
          ],
        ));
  }
}
