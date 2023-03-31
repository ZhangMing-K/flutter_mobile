import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iris_common/iris_common.dart';

class TraderCard extends StatelessWidget {
  const TraderCard({Key? key, required this.user, this.showTopAssets = false})
      : super(key: key);

  final User user;
  final bool showTopAssets;

  @override
  Widget build(BuildContext context) {
    var assets = user.assetsWatching;
    double? dailyPercent = user.dailyPercentGain;
    return SizedBox(
      width: showTopAssets ? 250 : 232,
      height: showTopAssets ? 350 : 270,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileImage(
                url: user.profilePictureUrl,
                uuid: uuid.v4(),
                radius: 25,
              ),
              // const SizedBox(height: 24),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          user.fullName,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                      SvgPicture.asset(IconPath.trophy_svg)
                    ],
                  ),
                  Text(
                    "${user.followStats?.numberOfFollowers} followers",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  // const Text("{tp} trader percentile"),
                ],
              ),
              // const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).chipTheme.backgroundColor,
                    //TODO use a main theme color, not from chip theme
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          if (dailyPercent == null)
                            Text(
                              'N/A',
                              style: Theme.of(context).textTheme.headline4,
                            )
                          else
                            DailyPercentGainView(
                              percentGain: dailyPercent,
                              textStyle: Theme.of(context).textTheme.headline4,
                            ),
                          Text(
                            "Day",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          // if (dailyPercent == null)
                          Text(
                            'N/A',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          // else
                          // // TODO get the YearPercentGain values
                          //   DailyPercentGainView(
                          //     percentGain: yearPercent,
                          //     textStyle: Theme.of(context).textTheme.headline4,
                          //   ),
                          Text(
                            "Year",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (showTopAssets && assets != null && assets.isNotEmpty)
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
              // const Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Follow"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(
                      40), // fromHeight use double.infinity as width and 40 is the height
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
