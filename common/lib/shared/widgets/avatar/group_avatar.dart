import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

class GroupAvatar extends StatefulWidget {
  final double? width;

  final double? height;

  final double space;

  final double arcAngle;

  final int initIndex;

  final EdgeInsets padding;

  final EdgeInsets margin;

  final AlignmentGeometry? alignment;

  final Color? color;

  final Decoration? decoration;

  final int itemCount;

  final IndexedWidgetBuilder itemBuilder;

  final int? bigImageWidth;

  final int? bigImageHeight;

  final Image? bigImage;

  final String? bigImageUrl;

  const GroupAvatar({
    Key? key,
    this.width,
    this.height,
    this.space = 3,
    this.arcAngle = 0,
    this.initIndex = 1,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.alignment,
    this.color,
    this.decoration,
    required this.itemCount,
    required this.itemBuilder,
    this.bigImageWidth,
    this.bigImageHeight,
    this.bigImage,
    this.bigImageUrl,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GroupAvatarState();
  }
}

class GroupCircleAvatar extends StatelessWidget {
  final List<User> users;
  final double? width;
  final double? height;
  const GroupCircleAvatar({
    Key? key,
    required this.users,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupAvatar(
      space: 0,
      width: width ?? 38,
      height: height ?? 36,
      // margin: EdgeInsets.symmetric(horizontal: 2),
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        final user = users[index];
        final url = user.profilePictureUrl;
        return getImage(url);
      },
    );
  }

  Widget getImage(String? url) {
    if (isInvalidUrl(url)) {
      return Image.asset(
        Images.defaultProfileImage,
        fit: BoxFit.cover,
        // cacheRawData: true,
      );
    } else {
      return CachedNetworkImage(
          imageUrl: url!,
          fit: BoxFit.cover,
          cacheManager: Get.find<IrisImageCacheManager>());
    }
  }

  bool isInvalidUrl(String? url) =>
      url == null ||
      url ==
          'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y';
}

class _GroupAvatarState extends State<GroupAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.alignment,
      color: widget.color,
      decoration: widget.decoration,
      margin: widget.margin,
      padding: widget.padding,
      width: widget.width,
      height: widget.height,
      child: _buildDingTalkGroup(context),
    );
  }

  Widget _buildDingTalkGroup(BuildContext context) {
    final double width = widget.width! - widget.padding.horizontal;
    final int itemCount = math.min(4, widget.itemCount);
    final double itemW = (width - widget.space) / 2;
    final List<Widget> children = [];
    for (int i = 0; i < itemCount; i++) {
      children.add(Positioned(
          top: (widget.space + itemW) * (i ~/ 2),
          left: (widget.space + itemW) *
              (((itemCount == 3 && i == 2) ? i + 1 : i) % 2),
          child: SizedBox(
            width: itemCount == 1 ? width : itemW,
            height:
                (itemCount == 1 || itemCount == 2 || (itemCount == 3 && i == 0))
                    ? width
                    : itemW,
            child: widget.itemBuilder(context, i),
          )));
    }
    return ClipOval(
      child: Stack(
        children: children,
      ),
    );
  }
}
