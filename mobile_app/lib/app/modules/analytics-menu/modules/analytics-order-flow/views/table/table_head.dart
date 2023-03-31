import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'constants.dart';

class TableHead extends StatelessWidget {
  final ScrollController? scrollController;
  final SortColumns? sortedColumn;
  final Function({SORT_BY? sortBy})? handleSortData;
  final List<OrderFlow>? dataSource;
  final int? goldIndex;
  final POSITION_TYPE positionType;

  const TableHead({
    Key? key,
    required this.scrollController,
    this.sortedColumn,
    this.handleSortData,
    this.dataSource,
    required this.positionType,
    this.goldIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaleFactor = context.textScaleFactor;
    final rowWidths = positionType == POSITION_TYPE.OPTION
        ? optionTableWidth
        : equityTableWidth;
    final rowTexts = positionType == POSITION_TYPE.OPTION
        ? optionTableHeader
        : equityTableHeader;
    final rowSortBy = positionType == POSITION_TYPE.OPTION
        ? optionTableSortBy
        : equityTableSortBy;
    return SizedBox(
      height: 39 * scaleFactor,
      child: Row(
        children: [
          Container(
              color: context.theme.backgroundColor,
              child: headerItem(
                  width: staticWidth,
                  text: 'Ticker',
                  sortBy: SORT_BY.TICKER,
                  alignment: Alignment.center)),
          Expanded(
            child: ListView(
              controller: scrollController,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: List.generate(rowWidths.length, (index) {
                return Container(
                    color: context.theme.backgroundColor,
                    child: headerItem(
                        width: rowWidths[index],
                        text: rowTexts[index],
                        sortBy: rowSortBy[index]));
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget headerItem(
      {String? text,
      double? width = 80,
      SORT_BY? sortBy,
      Color? color,
      Alignment alignment = Alignment.center}) {
    return Builder(builder: (context) {
      final scaleFactor = context.textScaleFactor;
      return InkWell(
          onTap: () {
            handleSortData!(sortBy: sortBy);
          },
          child: Container(
              width: width! * scaleFactor,
              alignment: alignment,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: SizedBox(
                        width: (width - 10) * scaleFactor,
                        child: Text(text!,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: IrisScreenUtil.dFontSize(12),
                              fontWeight: FontWeight.w500,
                              color: sortedColumn!.sortBy == sortBy
                                  ? color ??
                                      context.theme.colorScheme.secondary
                                          .withOpacity(0.75)
                                  : color ??
                                      context.theme.colorScheme.secondary
                                          .withOpacity(0.4),
                            ))),
                  ),
                  if (sortedColumn!.sortBy == sortBy)
                    Icon(
                      sortedColumn!.orderByAsc!
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 10 * scaleFactor,
                    )
                ],
              )));
    });
  }
}
