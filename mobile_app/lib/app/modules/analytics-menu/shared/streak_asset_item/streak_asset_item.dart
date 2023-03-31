import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class IrisStreakAssetData {
  IrisStreakAssetData(this.type, this.value);
  String type;
  double value;
}

class StreakAssetItem extends StatelessWidget {
  const StreakAssetItem({
    Key? key,
    required this.assetRun,
    required this.isPositive,
    required this.dateTime,
    this.index = 0,
  }) : super(key: key);
  final AssetRun assetRun;
  final bool isPositive;
  final int? index;
  final DateTime dateTime;

  List<IrisStreakAssetData> get irisAssetStreakData {
    final current = assetRun.run ?? 0;
    final high = assetRun.previousMaxRun ?? 0;
    if (high >= current) {
      return [
        IrisStreakAssetData('high', 100),
        IrisStreakAssetData(
            'current', current == high ? 99.99 : current / high * 100),
      ];
    } else {
      return [
        IrisStreakAssetData('high', high / current * 100),
        IrisStreakAssetData('current', 100),
      ];
    }
  }

  String? labelMapper(IrisStreakAssetData data, int index) {
    return data.type.toString();
  }

  bool get isBlur {
    final difference = DateTime.now().difference(dateTime).inDays;
    if (difference > 1) {
      return false;
    } else {
      if (index! < 3) {
        return false;
      }
      return true;
    }
  }

  Color getBarColor(IrisStreakAssetData data, rowIndex) {
    return data.type == 'current'
        ? isPositive
            ? IrisColor.positiveChange
            : IrisColor.negativeChange
        : Get.isDarkMode
            ? IrisColor.brokerCardOnDarkBG
            : IrisColor.lightSecondaryColor;
  }

  bool get isFlipped {
    return assetRun.didFlip ?? false;
  }

  bool get isStreakEnded {
    return assetRun.didFlip != null;
  }

  String get roi01fVal {
    double roi01f = 0;
    if (assetRun.roi01f != null) {
      roi01f = assetRun.roi01f!;
    } else {
      roi01f = assetRun.asset!.quote!.changePercent ?? 0;
    }

    return (roi01f > 0 ? '+' : '') + roi01f.formatPercentage();
  }

  int get previousMaxRun {
    return assetRun.previousMaxRun ?? 0;
  }

  Widget main(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            color: context.theme.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
                color: isStreakEnded
                    ? isPositive
                        ? IrisColor.positiveChange
                        : IrisColor.negativeChange
                    : context.theme.backgroundColor)),
        padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
        margin: EdgeInsets.only(
            top: ScreenUtil().setWidth(10),
            left: ScreenUtil().setWidth(8),
            right: ScreenUtil().setWidth(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppAssetImage(
                    asset: assetRun.asset!, height: ScreenUtil().setWidth(50)),
                SizedBox(
                  width: ScreenUtil().setWidth(8),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(assetRun.asset!.symbol!,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    SizedBox(
                        width: ScreenUtil().setWidth(80),
                        child: Text(
                          '\$' +
                              (assetRun.marketCap ?? 0).formatCompact() +
                              ' Mkt',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w500,
                              color: IrisColor.lightSecondaryColor),
                        )),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Text(assetRun.run!.toString() + 'd',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w700)),
                SizedBox(height: ScreenUtil().setWidth(8)),
                Text(previousMaxRun.toString() + 'd',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w700,
                        color: IrisColor.lightSecondaryColor)),
              ],
            ),
            SizedBox(
                width: ScreenUtil().setWidth(110),
                height: ScreenUtil().setWidth(70),
                child: SfCartesianChart(
                    primaryYAxis:
                        NumericAxis(isVisible: false, maximum: 100, minimum: 0),
                    primaryXAxis:
                        CategoryAxis(isVisible: false, maximum: 1, minimum: 0),
                    plotAreaBorderWidth: 0,
                    series: <ChartSeries>[
                      // Renders bar chart
                      BarSeries<IrisStreakAssetData, double>(
                        width: 0.75,
                        dataSource: irisAssetStreakData,
                        xValueMapper: (IrisStreakAssetData sales, _) =>
                            sales.value / 100,
                        yValueMapper: (IrisStreakAssetData sales, _) =>
                            sales.value,
                        dataLabelMapper: labelMapper,
                        pointColorMapper: getBarColor,
                        spacing: 0.5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                      )
                    ])),
            Column(
              children: [
                Text(
                  roi01fVal,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                    (assetRun.roi1Yp! > 0 ? '+' : '') +
                        assetRun.roi1Yp!.formatPercentage() +
                        ' year',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w500,
                        color: IrisColor.lightSecondaryColor))
              ],
            )
          ],
        ),
      ),
      if (isFlipped)
        Positioned(
          top: 10,
          right: 0,
          child: RotationTransition(
              turns: const AlwaysStoppedAnimation(15 / 360),
              child: Transform.translate(
                  offset: const Offset(-3, 0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    alignment: Alignment.center,
                    child: const Text('FLIPPED',
                        style: TextStyle(color: Colors.white)),
                  ))),
        )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // return isBlur ? BlurFilter(child: main(context), sigmaX: 10, sigmaY: 10,) : main(context);
    return main(context);
  }
}
