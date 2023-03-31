import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../iris_common.dart';

class RoutedAssetListTile extends StatelessWidget {
  final Asset? asset;
  final VoidCallback? saveToStorage;
  final Function? assetToWatchlist;
  final bool? isRoute;
  const RoutedAssetListTile(
      {Key? key,
      this.asset,
      this.saveToStorage,
      this.assetToWatchlist,
      this.isRoute = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: ListTile(
        onTap: () {
          if (isRoute!) {
            if (saveToStorage != null) {
              saveToStorage!();
            }
          } else {
            final bool isWatching =
                asset!.authUserIsWatching != true ? false : true;
            if (assetToWatchlist != null) {
              assetToWatchlist!(!isWatching);
            }
          }
        },
        contentPadding: const EdgeInsets.only(left: 16),
        leading: AppAssetImage(
          asset: asset,
        ),
        title: Text(asset!.symbol!,
            style: TextStyle(
                color: context.theme.colorScheme.secondary,
                fontWeight: FontWeight.w500)),
        subtitle: Text(asset!.name ?? ''),
        trailing: trailing(asset: asset, action: assetToWatchlist),
      ),
    );
  }

  Widget trailing({Asset? asset, Function? action}) {
    Widget percentChange = Container();
    if (asset?.quote?.changePercent != null) {
      percentChange = SizedBox(
        height: 100,
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DisplayPercent(
              percent: asset!.quote!.changePercent,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            Text(
              asset.quote!.latestPrice.formatCurrency(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  // color: Colors.black,
                  fontFamily: 'Roboto',
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      );
    }
    final bool isWatching = asset!.authUserIsWatching != true ? false : true;
    final icon =
        isWatching ? UniconsLine.minus_circle : UniconsLine.plus_circle;
    return Container(
        width: 115,
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            percentChange,
            StatefulBuilder(builder: (_, update) {
              return IrisBounceButton(
                  duration: const Duration(milliseconds: 100),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    if (action != null) {
                      action(!isWatching);
                    }
                  },
                  child: Icon(
                    icon,
                    size: 22,
                    color: isWatching
                        ? IrisColor.dateFromColor
                        : IrisColor.primaryColor,
                  ));
            })
          ],
        ));
  }
}
