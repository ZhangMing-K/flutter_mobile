import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

class UserName extends StatelessWidget {
  final User? user;
  final double fontSize;
  final FontWeight fontWeight;
  final bool route;
  final Color? color;
  final String? heroTag;
  final bool? usernameOverFullName;
  final int? maxLength;
  final bool? shouldResize;
  final bool? showBadge;
  final bool shrinkText;
  final bool hasHero;
  const UserName({
    Key? key,
    required this.user,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.route = true,
    this.heroTag,
    this.color,
    this.hasHero = true,
    this.usernameOverFullName,
    this.maxLength = 40,
    this.shrinkText = true,
    this.shouldResize = true,
    this.showBadge = true,
  }) : super(key: key);
  double get baseFontNumber {
    return fontSize / 7;
  }

  String get name {
    String n = '';
    if (usernameOverFullName == true && user?.username != null) {
      n = user!.username!;
    } else if (user?.fullName != null) {
      n = user!.fullName;
    }
    if (maxLength != null) {
      int len = n.length;
      if (len >= maxLength!) {
        n = n.substring(0, maxLength) + '...';
      }
    }
    return Characters(n)
        .replaceAll(Characters(''), Characters('\u{200B}'))
        .toString();
  }

  badgeWidget() {
    if (user?.badgeType == null) {
      return Container();
    } else if (user!.badgeType == BADGE_TYPE.NEW_USER) {
      return WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Text(
            ' 🎉',
            style: TextStyle(fontSize: (fontSize - baseFontNumber * 2)),
          ));
    }
    String badgePath = IconPath.verifiedAccount;
    double fontSizeAddition = -baseFontNumber;
    Color? color;
    if (user!.badgeType == BADGE_TYPE.VERIFIED) {
      badgePath = IconPath.verifiedAccount;
    } else if (user!.badgeType == BADGE_TYPE.TOP_TRADER) {
      badgePath = IconPath.badgeTopTrader;
      fontSizeAddition = 0;
    } else if (user!.badgeType == BADGE_TYPE.CONTENT_MODERATOR) {
      badgePath = IconPath.badgeModerator;
      fontSizeAddition = baseFontNumber / 4;
      color = Colors.grey;
    }

    return WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 2),
          child: Image.asset(
            badgePath,
            width: fontSize + fontSizeAddition,
            height: fontSize + fontSizeAddition,
            color: color,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container();
    }
    if (route) {
      return InkWell(
          onTap: () {
            if (route) {
              final profileArgs = ProfileArgs(
                user: user ?? const User(),
                heroTag: heroTag ?? user!.userKey.toString(),
              );
              Get.toNamed(
                Paths.Feed + Paths.Home + Paths.Profile,
                arguments: profileArgs,
                parameters: {
                  'profileUserKey': user!.userKey.toString(),
                },
                id: 1,
              );
            }
          },
          child: main());
    }
    return main();
  }

  Widget main() {
    final tag = heroTag ?? user!.userKey.toString();

    final widget = Builder(builder: (context) {
      return Row(
        mainAxisSize: shrinkText ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Flexible(
              child: RichText(
            textScaleFactor: shouldResize! ? context.textScaleFactor : 1,
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: name,
                  style: TextStyle(
                      fontWeight: fontWeight,
                      fontSize: IrisScreenUtil.dFontSize(fontSize),
                      color: color ?? context.theme.colorScheme.secondary),
                ),
              ],
            ),
          )),
          RichText(
            textScaleFactor: shouldResize! ? context.textScaleFactor : 1,
            text: TextSpan(
              children: <InlineSpan>[
                if (showBadge! && user?.badgeType != null) badgeWidget(),
              ],
            ),
          ),
        ],
      );
    });

    return hasHero
        ? Hero(
            tag: tag + 'username',
            child: widget,
          )
        : widget;
  }
}
