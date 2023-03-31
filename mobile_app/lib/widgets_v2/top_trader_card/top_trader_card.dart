import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';

class TopInvestorCard extends StatelessWidget {
  final User user;
  final double marginLeft;
  final Function? saveToRecent;
  final Function? afterStories;
  const TopInvestorCard(
      {Key? key,
      required this.user,
      required this.marginLeft,
      this.saveToRecent,
      this.afterStories})
      : super(key: key);

  Widget assetImageList(List<Asset>? assets, double scaleFactor) {
    if (assets == null || assets.isEmpty) {
      return Container();
    }
    final List<Widget> list = [];
    for (var asset in assets) {
      list.add(AppAssetImage(asset: asset, height: 38));
      //  list.add(SizedBox(width: 10 * scaleFactor));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    final heroTag = uuid.v4();
    final scaleFactor = context.textScaleFactor;
    return GestureDetector(
      onTap: () {
        user.routeToProfile();
        // controller.saveUserToRecent(user);
        if (saveToRecent != null) {
          saveToRecent!(user);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: kBorderRadius,
          color: context.theme.backgroundColor,
        ),
        margin: EdgeInsets.only(
            left: IrisScreenUtil.dWidth(marginLeft, scale: scaleFactor),
            right: IrisScreenUtil.dWidth(6, scale: scaleFactor)),
        padding: EdgeInsets.symmetric(
            horizontal: IrisScreenUtil.dWidth(16, scale: scaleFactor),
            vertical: IrisScreenUtil.dWidth(20, scale: scaleFactor)),
        height: 268,
        width: IrisScreenUtil.dWidth(230, scale: scaleFactor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserImage(
                  radius: 20,
                  id: heroTag,
                  user: user,
                  afterStories: () {
                    if (afterStories != null) {
                      afterStories!(user.userKey!);
                    }
                  },
                ),
                SizedBox(width: IrisScreenUtil.dWidth(10, scale: scaleFactor)),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserName(
                      heroTag: heroTag,
                      user: user,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      maxLength: (18 / scaleFactor).round(),
                    ),
                    Text(
                      user.tradePerformanceConnections![0].tradePerformance!
                              .tradeAccuracy!
                              .formatPercentage() +
                          ' trade accuracy',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(158, 158, 158, 1),
                      ),
                    ),
                  ],
                ))
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius,
                  color: context.theme.colorScheme.secondary.withOpacity(0.05),
                ),
                width: IrisScreenUtil.dWidth(198, scale: scaleFactor),
                padding: EdgeInsets.symmetric(
                    horizontal: IrisScreenUtil.dWidth(16, scale: scaleFactor),
                    vertical: IrisScreenUtil.dWidth(8, scale: scaleFactor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '# Open trades/month',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(158, 158, 158, 1),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.tradePerformanceConnections![0].tradePerformance!
                          .openTradesPerMonth!
                          .toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                )),
            Container(
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius,
                  color: context.theme.colorScheme.secondary.withOpacity(0.05),
                ),
                width: IrisScreenUtil.dWidth(198, scale: scaleFactor),
                padding: EdgeInsets.symmetric(
                    horizontal: IrisScreenUtil.dWidth(16, scale: scaleFactor),
                    vertical: IrisScreenUtil.dWidth(8, scale: scaleFactor)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Most profitable',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(158, 158, 158, 1),
                        ),
                      ),
                      const SizedBox(height: 4),
                      assetImageList(
                          user.tradePerformanceConnections![0]
                              .mostProfitableAssets!,
                          scaleFactor),
                    ])),
            Row(
              children: [
                Expanded(
                  child: IrisFollowButton(
                    user$: user.obs,
                    followingAction: FOLLOWING_ACTION.VIEW_PROFILE,
                    customAction: () {
                      if (saveToRecent != null) {
                        saveToRecent!(user);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
