import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';

import '../../../iris_common.dart';

class IrisCarrousel extends StatelessWidget {
  const IrisCarrousel({
    Key? key,
    required this.followSuggestion,
  }) : super(key: key);
  final FollowSuggestion followSuggestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 256 * context.textScaleFactor,
      padding: const EdgeInsets.only(
        // left: 16,
        bottom: 16,
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 13,
              left: 16,
            ),
            child: Text(
              followSuggestion.carouselTitle ?? 'Suggested Investors',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: followSuggestion.userCards?.length ?? 0,
              itemBuilder: (context, index) {
                final card = followSuggestion.userCards![index];
                return Container(
                  padding: EdgeInsets.only(left: index == 0 ? 14 : 0),
                  child: TopTraderCard(
                    card.user ?? const User(),
                    userCardSubtitle: card.subtitle,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TopTraderCard extends StatelessWidget {
  const TopTraderCard(this.user,
      {this.onAfterFollow, this.userCardSubtitle, Key? key})
      : super(key: key);

  final User user;
  final Function? onAfterFollow;
  final String? userCardSubtitle;

  @override
  Widget build(BuildContext context) {
    List<Asset>? assets;
    //todo add back in if we can get the users top traded assets, also parent
    // double? dailyPercent = user.dailyPercentGain;
    // double? yearPercent = null;
    double? weekPercent = user.temporarySnapshotHistoricalPoints?.weekPercent;
    double? yearPercent = user.temporarySnapshotHistoricalPoints?.yearPercent;
    double? percentGain = weekPercent;
    String gainText = 'This Week';
    if ((yearPercent != null && weekPercent != null) &&
        yearPercent > weekPercent) {
      percentGain = yearPercent;
      gainText = 'This Year';
    }

    final id = uuid.v4();
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      child: InkWell(
        onTap: user.routeToProfile,
        child: SizedBox(
          width: 142 * context.textScaleFactor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserImage(
                  user: user,
                  id: id,
                  radius: 28,
                  onTap: () => user.routeToProfile(id),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UserName(
                      user: user,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      maxLength: 18,
                      heroTag: id,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    // show follower count if null
                    if (userCardSubtitle != null)
                      Text(
                        userCardSubtitle!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontSize: 12),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      )
                    else if (percentGain == null)
                      Text(
                        "${user.followStats?.numberOfFollowers.compactNumber()} Followers",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontSize: 12),
                      )
                    else
                      SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DailyPercentGainView(
                              percentGain: percentGain,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(fontSize: 12),
                            ),
                            Text(
                              " $gainText",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                if (assets != null && assets.isNotEmpty)
                  Builder(builder: (context) {
                    int itemCount = assets.length >= 3 ? 3 : assets.length;
                    var asset1Image = assets[0].pictureUrl;
                    var asset2Image = assets[1].pictureUrl;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (itemCount >= 1)
                          Chip(
                            label: Text(assets[0].symbol ?? ''),
                            avatar: CircleAvatar(
                              backgroundImage: asset1Image != null
                                  ? CachedNetworkImageProvider(asset1Image)
                                  : null,
                            ),
                          ),
                        if (itemCount >= 2) ...[
                          const SizedBox(
                            width: 8,
                          ),
                          Chip(
                            label: Text(assets[1].symbol ?? ''),
                            avatar: CircleAvatar(
                              backgroundImage: asset2Image != null
                                  ? CachedNetworkImageProvider(asset2Image)
                                  : null,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                        if (itemCount >= 3)
                          Center(
                            child: Text(
                              "+${assets.length - 2}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                      ],
                    );
                  }),
                const SizedBox(),
                IrisFollowButton(
                  user$: user.obs,
                  height: 30,
                  width: 200,
                  onFollow: (FollowRequest fr) {
                    onAfterFollow?.call();
                  },
                  includeFollowingOptions: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
