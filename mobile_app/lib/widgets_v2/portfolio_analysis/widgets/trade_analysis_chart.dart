import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class TradeAnalysisChart extends StatelessWidget {
  final List<TradeAnalysisChartData> chartData;
  final DISPLAY_UNIT displayUnit;
  final Function(ChartSeriesController)? onRendered;
  const TradeAnalysisChart(
      {Key? key,
      required this.chartData,
      required this.displayUnit,
      this.onRendered})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: context.width,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tradeTypeBubbles(),
              if (chartData != null) buildBarChart(),
              profitLossColumn()
            ]));
  }

  Widget buildBarChart() {
    return Builder(builder: (context) {
      return SizedBox(
          width: context.width / 1.95,
          child: SfCartesianChart(
              primaryYAxis: NumericAxis(isVisible: false),
              primaryXAxis: CategoryAxis(isVisible: false),
              plotAreaBorderWidth: 0,
              series: <ChartSeries>[
                BarSeries<TradeAnalysisChartData, double>(
                    animationDuration: 1700,
                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                    width: .75,
                    dataLabelMapper: labelMapper,
                    pointColorMapper: getBarColor,
                    dataSource: chartData.reversed.toList(),
                    xValueMapper: xValue,
                    yValueMapper: yValue,
                    onRendererCreated: onRendered)
              ]));
    });
  }

  Color getBarColor(TradeAnalysisChartData data, rowIndex) {
    return data.profitLoss! >= 0
        ? IrisColor.positiveChange
        : IrisColor.negativeChange;
  }

  List<String> getTradeTypes() {
    final List<String> typeList = ['Equity', 'Call', 'Put', 'Crypto'];
    // chartData.forEach((d) => typeList.add(d.tradeType.capitalize));
    return typeList;
  }

  String? labelMapper(TradeAnalysisChartData data, int index) {
    return data.tradeType;
  }

  Widget profitLossColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (chartData != null)
          if (displayUnit == DISPLAY_UNIT.DOLLAR)
            ...chartData.map((t) => profitLossDisplay(t.profitLoss!))
          else
            ...chartData.map((t) => DisplayPercent(percent: t.profitLoss))
        else
          ...[0, 0, 0].map((v) => profitLossDisplay(v.toDouble())),
      ],
    );
  }

  Widget profitLossDisplay(double pl) {
    return Row(children: [
      Image.asset(
        pl >= 0 ? IconPath.greenArrowPercent : IconPath.redArrowPercent,
        width: 11,
        height: 6,
      ),
      Text(pl.abs().formatCurrency(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: pl >= 0
                  ? IrisColor.positiveChange
                  : IrisColor.negativeChange))
    ]);
  }

  Widget tradeTypeBubble(String type) {
    return Builder(builder: (context) {
      return Container(
          width: context.width * .18,
          // height: 18,
          margin: const EdgeInsets.only(top: 2, bottom: 2),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              color: Colors.grey.withOpacity(0.15)),
          child: Text(type,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)));
    });
  }

  Widget tradeTypeBubbles() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [...getTradeTypes().map((t) => tradeTypeBubble(t))],
    );
  }

  double? xValue(TradeAnalysisChartData data, rowIndex) {
    // if(data.profitLoss < 0 || chartData.length > 1)
    return data.profitLoss;
    // else
    //   return data.profitLoss * -1;
  }

  double? yValue(TradeAnalysisChartData data, rowIndex) {
    // if(data.profitLoss < 0 || chartData.length > 1)
    return data.profitLoss;
    // else
    // return data.profitLoss * -1;
  }
}

class TradeAnalysisChartData {
  String? tradeType;
  double? profitLoss;
  TradeAnalysisChartData({this.tradeType, this.profitLoss});
}
