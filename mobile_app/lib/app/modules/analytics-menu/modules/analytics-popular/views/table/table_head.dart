import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'constants.dart';

class TableHead extends StatelessWidget {
  final ScrollController? scrollController;
  final SortColumns? sortedColumn;
  final Function({SORT_BY? sortBy, SENTIMENT_TYPE? sentimentType})?
      handleSortData;
  final List<AssetOverviewItem>? dataSource;
  final SENTIMENT_TYPE? sentimentType;

  const TableHead(
      {Key? key,
      required this.scrollController,
      this.sortedColumn,
      this.handleSortData,
      this.dataSource,
      this.sentimentType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
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
              children: List.generate(tableWidth.length, (index) {
                return Container(
                    color: context.theme.backgroundColor,
                    child: headerItem(
                        width: tableWidth[index],
                        text: tableHeader[index],
                        sortBy: tableSortBy[index]));
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget headerItem(
      {String? text,
      double? width = 120,
      SORT_BY? sortBy,
      Color? color,
      Alignment alignment = Alignment.center}) {
    return Builder(builder: (context) {
      return InkWell(
          onTap: () {
            handleSortData!(sortBy: sortBy);
          },
          child: Container(
              width: width!,
              alignment: alignment,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: SizedBox(
                        width: width - 10,
                        child: Text(text!,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
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
                      size: 10,
                    )
                ],
              )));
    });
  }
}
