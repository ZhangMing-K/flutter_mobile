import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class WorkspaceImage extends StatelessWidget {
  final Workspace workspace;
  final double height;
  final bool selected;
  const WorkspaceImage(
      {Key? key,
      required this.workspace,
      this.height = 40,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        workspaceImage(
            selected: selected,
            fit: BoxFit.fill,
            workspace: workspace,
            height: height,
            context: context),
        // if (workspace.botEnabled != true) disabled()
      ],
    );
  }

  Widget disabledOrEnabled(BuildContext context) {
    final String text;
    final Color color;

    if (workspace.botEnabled == true) {
      text = 'Enabled';
      color = context.theme.primaryColor;
    } else {
      text = 'Disabled';
      color = context.theme.colorScheme.secondary;
    }

    return Container(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          text,
          style: TextStyle(color: color),
        ));
  }

  Widget image(BuildContext? context, url, fit) {
    return CachedNetworkImage(
      imageUrl: url!,
      fit: fit,
      height: height,
      width: height,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(7.0)),
          shape: BoxShape.rectangle,
        ),
      ),
      cacheManager: Get.find<IrisImageCacheManager>(),
      placeholder: (context, url) => Container(color: Colors.grey.shade300),
      errorWidget: (context, url, error) =>
          Container(color: Colors.grey.shade300),
    );
  }

  Widget overlayIcon({required Icon icon}) {
    return Positioned(right: 0, left: 40, top: 1, child: icon);
  }

  Widget workspaceImage(
      {required bool selected,
      double? height,
      Workspace? workspace,
      BoxFit? fit,
      BuildContext? context}) {
    String? url = workspace?.imageUrl;
    if (workspace?.imageUrl == null) {
      url = 'http://via.placeholder.com/150?text=${workspace!.serverInitials}';
    }

    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: selected
              ? Border.all(color: IrisColor.primaryColor, width: 3)
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(7.0)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          image(context!, url, fit),
          workspaceName(context),
          disabledOrEnabled(context)
        ]));
  }

  Widget workspaceName(BuildContext context) {
    return Container(
        width: 80,
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          workspace.name!,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
          style: TextStyle(color: context.theme.colorScheme.secondary),
        ));
  }
}
