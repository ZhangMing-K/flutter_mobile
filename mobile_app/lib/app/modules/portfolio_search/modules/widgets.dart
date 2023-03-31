import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';

class AssetListTile extends StatelessWidget {
  final Asset? asset;
  const AssetListTile({Key? key, this.asset}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.backgroundColor,
      // margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              // Get.toNamed(
              //   Paths.Asset,
              //   parameters: {'assetKey': asset!.assetKey!.toString()},
              // );
            },
            leading: AppAssetImage(
              asset: asset,
            ),
            title: Text(
              asset!.symbol!,
              style: TextStyle(color: context.theme.colorScheme.secondary),
            ),
            subtitle: Text(asset!.name!),
            trailing: trailing(asset: asset),
          ),
          const Divider()
        ],
      ),
    );
  }

  Widget? trailing({Asset? asset}) {
    if (asset?.quote?.changePercent == null) {
      return null;
    }

    return SizedBox(
      width: 100,
      height: 100,
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
}
