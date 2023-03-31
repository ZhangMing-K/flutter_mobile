import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

enum DD_ASSET_TITLE_TYPE { WITH_USER, DEFAULT }

class DDAssetTitle extends StatelessWidget {
  final Asset? asset;
  final bool isBearish;
  final double upsideSlider;
  final String timeFrame;
  final String? riskName;
  final User user;
  final double size;
  final DD_ASSET_TITLE_TYPE titleType;
  const DDAssetTitle({
    Key? key,
    required this.asset,
    required this.isBearish,
    required this.upsideSlider,
    required this.timeFrame,
    required this.riskName,
    required this.user,
    this.size = 1.0,
    this.titleType = DD_ASSET_TITLE_TYPE.DEFAULT,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double titleFontSize = 20 * size;
    if (titleType == DD_ASSET_TITLE_TYPE.WITH_USER) {
      titleFontSize = 15 * size;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image(),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              usernameRow(),
              RichText(
                textScaleFactor: context.textScaleFactor,
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: TextStyle(
                    fontSize: titleFontSize,
                    color: context.theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${asset?.symbol} ',
                    ),
                    TextSpan(
                      text:
                          '${isBearish ? "" : "+"}${upsideSlider.formatPercentage()}',
                      style: TextStyle(
                        color: isBearish ? Colors.red : Colors.green,
                      ),
                    ),
                    TextSpan(
                      text: ' $timeFrame',
                    ),
                  ],
                ),
              ),
              if (riskName != null)
                Text(
                  '$riskName risk',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: context.theme.colorScheme.secondary.withOpacity(.7),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }

  image() {
    if (titleType == DD_ASSET_TITLE_TYPE.WITH_USER) {
      return UserImage(
        user: user,
        radius: 25 * size,
        asset: asset,
      );
    } else if (titleType == DD_ASSET_TITLE_TYPE.DEFAULT) {
      return AppAssetImage(
        asset: asset,
        height: 50 * size,
      );
    }

    return Container();
  }

  usernameRow() {
    if (titleType == DD_ASSET_TITLE_TYPE.WITH_USER) {
      return Row(
        children: [
          UserName(
            user: user,
            color: Colors.grey.shade500,
          ),
          if (user.traderPercentile != null)
            Text(
              ' -  ${user.traderPercentile} trader percentile',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
            ),
        ],
      );
    }

    return Container();
  }
}
