import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class AutoCompleteAssetRow extends StatelessWidget {
  final Asset asset;

  final Function(Asset, String)? onTap;
  const AutoCompleteAssetRow({Key? key, required this.asset, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        tileColor: context.theme.backgroundColor,
        onTap: () {
          if (onTap != null) {
            onTap!(asset, getText());
          }
        },
        leading: AppAssetImage(
          asset: asset,
        ),
        title: Text(asset.symbol!,
            style: TextStyle(color: context.theme.colorScheme.secondary)),
        // subtitle: Text(asset.name),
        trailing: trailing());
  }

  getText() {
    final Map<String, dynamic> assetJson = {
      'type': 'asset',
      'value': '\$${asset.symbol}',
      'currentPrice': asset.quote?.latestPrice,
      'percentChange': asset.quote?.changePercent,
      'assetKey': asset.assetKey,
    };
    final String assetJsonStr = jsonEncode(assetJson);
    final String assetString = '<C $assetJsonStr>\$${asset.symbol}</C>';
    String percentString = '';
    if (asset.quote?.changePercent != null) {
      final Map<String, dynamic> percentJson = {
        'type': 'percent',
        'value': asset.quote?.changePercent,
      };
      final String percentJsonStr = jsonEncode(percentJson);
      percentString =
          '<C $percentJsonStr>${asset.quote?.changePercent.formatPercentage()}</C>';
    }

    final String totalStr = assetString + percentString;
    return totalStr;
  }

  trailing() {
    if (asset.quote?.changePercent == null) {
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
            percent: asset.quote!.changePercent,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          Text(
            asset.quote!.latestPrice.formatCurrency(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
