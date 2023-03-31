import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/iris_buttons.dart';

class EmptyFollowingFeedView extends StatelessWidget {
  const EmptyFollowingFeedView(
      {required this.suggestions, this.onAfterFollow, Key? key})
      : super(key: key);
  final Function? onAfterFollow;
  final List<User> suggestions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Welcome to Iris!',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                'Know any good investors? Invite them here to see their trades, portfolios and performance in real time! Follow 3+ people then refresh to populate your feed!',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Suggested Traders',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.left,
                  textWidthBasis: TextWidthBasis.parent,
                ),
              ),
            ],
          ),
        ),
        // TODO @tyler: let's make this list it's own widget/file - we want to have this horizontal scroll of follow suggestions throughout app
        SizedBox(
            height: 270,
            child: Obx(() {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return TopTraderCard(suggestions[index],
                      onAfterFollow: onAfterFollow);
                },
              );
            })),
        const SizedBox(height: 64),
      ],
    );
  }
}

class TopTraderCard extends StatelessWidget {
  const TopTraderCard(this.user, {this.onAfterFollow, Key? key})
      : super(key: key);

  final User user;
  final Function? onAfterFollow;

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
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      child: InkWell(
        onTap: user.routeToProfile,
        child: SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileImage(
                  url: user.profilePictureUrl,
                  uuid: uuid.v4(),
                  radius: 40,
                  onTap: user.routeToProfile,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UserName(
                      user: user,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      maxLength: 18,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    // show follower count if null
                    percentGain == null
                        ? Text(
                            "${user.followStats?.numberOfFollowers.compactNumber()} Followers",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  DailyPercentGainView(
                                    percentGain: percentGain,
                                    textStyle:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                              Text(
                                " $gainText",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          )
                  ],
                ),
                const SizedBox(
                  height: 15,
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
                IrisFollowButton(
                  user$: user.obs,
                  height: 40,
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
