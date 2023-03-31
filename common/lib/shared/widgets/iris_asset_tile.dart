import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class IrisAssetListTile extends StatelessWidget {
  const IrisAssetListTile({
    Key? key,
    required this.asset,
    this.onTap,
    this.color,
    this.trailing,
  }) : super(key: key);
  final Asset? asset;
  final Color? color;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? context.theme.scaffoldBackgroundColor,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: AppAssetImage(
          asset: asset,
        ),
        title: Text(asset?.symbol ?? '',
            style: TextStyle(
                color: context.theme.colorScheme.secondary,
                fontWeight: FontWeight.w500)),
        subtitle: Text(asset?.name ?? ''),
        trailing: trailing ??
            SizedBox(
              height: 100,
              width: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DisplayPercent(
                    percent: asset?.quote?.changePercent ?? 0.0,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  Text(
                    asset?.quote?.latestPrice.formatCurrency() ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
