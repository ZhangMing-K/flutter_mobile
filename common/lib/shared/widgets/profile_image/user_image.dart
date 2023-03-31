import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

class UserImage extends StatelessWidget {
  final User user;
  final double radius;
  final bool showFullScreen;
  final bool showStories;
  final Function? onTap;
  final Function? onTapIfNoStories;
  final BROKER_NAME? brokerName;
  final Asset? asset;
  final String? id;
  final Function? afterStories;
  final bool? shouldResize;
  final bool hasHero;

  const UserImage({
    Key? key,
    required this.user,
    this.radius = 25,
    this.showFullScreen = false,
    this.showStories = true,
    this.onTap,
    this.onTapIfNoStories,
    this.brokerName,
    this.asset,
    //TODO: MAKE IT MANDATORY TO GET HERO ANIMATION EVERYWHERE
    this.id,
    this.afterStories, // function to be called after watching stories
    this.shouldResize = true,
    this.hasHero = true,
  }) : super(key: key);

  Color get gradientColor {
    if (hasStories && hasUnseenStories) {
      if (user.badgeType == BADGE_TYPE.TOP_TRADER) {
        return const Color(0xffB29701);
      }
      return const Color(0xffFF01FF);
    } else {
      if (user.badgeType == BADGE_TYPE.TOP_TRADER) {
        return const Color(0xffe8b923);
      }
      return lightenColor(Colors.grey.shade900, .3);
    }
  }

  // ignore: non_constant_identifier_names
  bool get hasStories {
    if (!showStories) return false;
    final storyConnection = user.storiesConnection;
    if (storyConnection == null) return false;
    final metadata = user.storiesConnection!.metaData?.areStories;
    if (metadata == null) return false;
    return metadata;
  }

  bool get hasUnseenStories {
    final storyConnection = user.storiesConnection;
    if (storyConnection == null) return false;
    final metadata = user.storiesConnection?.metaData?.areUnseenStories;
    if (metadata == null) return false;
    return metadata;
  }

  EdgeInsets get innerPadding {
    final double padding =
        getInnerPadding(radius, hasUnseenStories: hasUnseenStories);
    return EdgeInsets.all(padding);
  }

  EdgeInsets get outerPadding {
    final double padding =
        getOuterPadding(radius, hasUnseenStories: hasUnseenStories);
    return EdgeInsets.all(padding);
  }

  Color get ringColor {
    if (hasStories && hasUnseenStories) {
      if (user.badgeType == BADGE_TYPE.TOP_TRADER) {
        return const Color(0xffFFE44E);
      }
      return const Color(0xff00CDFD);
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _heroIdToPush = id ?? uuid.v4();
    final heroIdToWidget = _heroIdToPush + 'avatar';
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: [
          finalImage(
              heroIdToPush: _heroIdToPush, heroIdToWidget: heroIdToWidget),
          if (brokerName != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: BrokerIcon(
                brokerName: brokerName,
                height: (radius * 2) * .50,
              ),
            ),
          if (asset != null && brokerName == null)
            Positioned(
              bottom: 0,
              right: 0,
              child: AppAssetImage(
                asset: asset,
                height: (radius * 2) * .50,
              ),
            )
        ],
      ),
      onTap: () => onPictureTap(_heroIdToPush),
    );
  }

  Widget finalImage(
      {required String heroIdToPush, required String heroIdToWidget}) {
    final widget = hasStories
        ? Container(
            child: Padding(
              padding: outerPadding,
              child: Builder(builder: (context) {
                return Container(
                  child: image(
                    iRadius: radius,
                    heroIdToPush: heroIdToPush,
                    heroIdToWidget: heroIdToWidget,
                  ),
                  padding: innerPadding,
                  decoration: kInnerDecoration(context.isDarkMode),
                );
              }),
            ),
            decoration: kGradientBoxDecoration(),
          )
        : image(
            iRadius: radius + baseRingNumber(radius),
            heroIdToPush: heroIdToPush,
            heroIdToWidget: heroIdToWidget,
          );

    return hasHero
        ? Hero(
            tag: heroIdToWidget,
            child: widget,
          )
        : widget;
  }

  Widget image(
      {required double iRadius,
      required String heroIdToWidget,
      required String heroIdToPush}) {
    return Builder(builder: (context) {
      return ProfileImage(
        radius: shouldResize! ? iRadius * context.textScaleFactor : iRadius,
        showFullScreen: !hasStories && showFullScreen,
        url: user.profilePictureUrl,
        uuid: heroIdToWidget,
        onTap: () => onPictureTap(heroIdToPush),
      );
    });
  }

  BoxDecoration kGradientBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          gradientColor,
          ringColor,
        ],
        stops: const [0.0, .7],
      ),
      color: Colors.black,
      shape: BoxShape.circle,
    );
  }

  BoxDecoration kInnerDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? Colors.black : Colors.white,
      shape: BoxShape.circle,
    );
  }

  void onPictureTap(String avatarHeroId) {
    if (onTap != null) {
      onTap!();
    } else {
      if (hasStories == false && onTapIfNoStories != null) {
        onTapIfNoStories!();
      } else {
        user.routeToFromProfilePicture(afterStories, avatarHeroId);
      }
    }
  }
}
