import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'button_overlay_controller.dart';

class AvatarsOverlay extends StatelessWidget {
  final double overlap;
  final List<String?> avatars;

  const AvatarsOverlay({Key? key, this.overlap = 10.0, required this.avatars})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = List<Widget>.generate(avatars.length, (index) {
      final url = avatars[index];
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: Visibility(
          visible: url == null ||
              url ==
                  'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
          child: CircleAvatar(
              radius: 20,
              //backgroundColor: Color(0xFFF5F5F5),
              backgroundColor: Colors.transparent,
              child: Image.asset(Images.defaultProfileImage, width: 20 * 1.7)),
          replacement: CircleAvatar(
            radius: 20,
            backgroundImage: ResizeImage(
                CachedNetworkImageProvider(
                  avatars[index]!,
                ),
                height: 300,
                width: 300),
          ),
        ),
      );
    });

    return Stack(children: items);
  }
}

class OverlayButton extends StatelessWidget {
  static const double overlap = 10;
  final VoidCallback onTap;
  final RxBool isVisible;
  final List<String?> avatars;

  const OverlayButton({
    Key? key,
    required this.onTap,
    required this.isVisible,
    required this.avatars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<OverlayButtonController>(
      global: false,
      init: OverlayButtonController(isVisible),
      didChangeDependencies: (state) {
        final scroll = state.primaryScroll;

        // .context
        //     .findAncestorStateOfType<NestedScrollViewState>()!
        //     .outerController;
        state.controller!.didChangeDependencies(scroll!);
      },
      builder: (_) {
        return Visibility(
          visible: _.canShow.value && avatars.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              color: context.isDarkMode
                  ? const Color(0xff5F5F5F)
                  : const Color(0xff939393),
              borderRadius: BorderRadius.circular(40),
              child: InkWell(
                onTap: () {
                  PrimaryScrollController.of(context)?.animateTo(0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeIn);
                  onTap();
                },
                child: SizedBox(
                  height: 50,
                  width: 130 + (13.0 * avatars.length),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7.0,
                        vertical: 7.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: AvatarsOverlay(
                              avatars: avatars,
                            ),
                          ),
                          Text(
                            avatars.length == 1 ? 'New post' : 'New Posts',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

extension ScrollExt on State {
  ScrollController? get primaryScroll => PrimaryScrollController.of(context);
}
