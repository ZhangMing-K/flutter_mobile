import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class HighlightData {
  String title;
  String? titleQualifier;
  List<String?>? orderGroupUUIDS;
  String? symbol;
  ORDER_SIDE? orderSide;
  Asset? asset;
  String? valueLabel;
  double? value;
  HighlightData(
      {required this.title,
      this.titleQualifier,
      this.orderGroupUUIDS,
      this.asset,
      this.symbol,
      this.orderSide,
      this.valueLabel,
      this.value});
}

class Highlights {
  List<HighlightData> items;
  Highlights({required this.items});
}

class HorizontalHighlights extends StatelessWidget {
  final double? height;
  final List<HighlightData> columns;
  final Color backgroundColor;
  const HorizontalHighlights(
      {Key? key,
      this.height = 100,
      required this.columns,
      this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaleFactor = context.textScaleFactor;
    if (columns.isEmpty) {
      return Container();
    }
    return Container(
      height: height! * scaleFactor,
      color: context.theme.scaffoldBackgroundColor,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: columns.length,
          itemBuilder: (BuildContext context, index) {
            return InkWell(
                onTap: () {
                  if (columns[index].orderGroupUUIDS != null &&
                      columns[index].orderGroupUUIDS!.isNotEmpty) {
                    Get.toNamed(
                      '/focused-feed',
                      arguments: {
                        'focusedFeedArguments': {
                          'orderGroupUUIDS': columns[index].orderGroupUUIDS
                        }
                      },
                      id: 1,
                    );
                  }
                },
                child: highlightCard(columns[index], context));
          }),
    );
  }

  Text getOrderSideDisplay(ORDER_SIDE orderSide) {
    late String str;
    switch (orderSide) {
      case ORDER_SIDE.BUY:
        str = '(Buy)';
        break;
      case ORDER_SIDE.SELL:
        str = '(Sell)';
        break;
    }
    return Text(str,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w300));
  }

  Widget highlightCard(HighlightData highlightData, BuildContext context) {
    final scaleFactor = context.textScaleFactor;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0 * scaleFactor),
      child: Card(
        elevation: 3,
        color: backgroundColor,
        child: Container(
          padding: EdgeInsets.all(10 * scaleFactor),
          height: 35 * scaleFactor,
          width: 200 * scaleFactor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    highlightData.title,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 5 * scaleFactor),
                  if (highlightData.titleQualifier != null)
                    Text(
                      highlightData.titleQualifier!,
                      style: const TextStyle(
                          fontSize: 8, fontWeight: FontWeight.w300),
                    ),
                ],
              ),
              SizedBox(
                height: 5 * scaleFactor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppAssetImage(
                    asset: highlightData.asset,
                    height: 30,
                  ),
                  Text(
                    highlightData.symbol!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (highlightData.orderSide != null)
                    getOrderSideDisplay(highlightData.orderSide!),
                  SizedBox(
                    width: 20 * scaleFactor,
                  ),
                  Column(
                    children: [
                      Text(
                        highlightData.valueLabel!,
                        style: const TextStyle(fontSize: 10),
                      ),
                      DisplayPercent(
                        percent: highlightData.value,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
