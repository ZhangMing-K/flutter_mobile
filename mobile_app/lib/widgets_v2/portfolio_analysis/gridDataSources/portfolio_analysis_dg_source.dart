// import 'package:flutter/foundation.dart';

// import 'package:syncfusion_flutter_core/src/theme/datagrid_theme.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// import '../../../shared/extensions/double.dart';
// import '../../../shared/models/trade_analysis/trade_analysis.dart';
// import 'package:iris_mobile/app/shared/types/index.dart';

// class PortfolioAnalysisDGSource extends DataGridSource<TradeAnalysis> {
//   PortfolioAnalysisDGSource(
//       {@required this.orderAnalytics, @required this.displayUnit});
//   List<TradeAnalysis> orderAnalytics;
//   DISPLAY_UNIT displayUnit;
//   @override
//   List<TradeAnalysis> get dataSource => this.orderAnalytics;
//   void set dataSource(List<TradeAnalysis> src) => this.orderAnalytics = src;
//   SortColumnDetails _lastSort = SortColumnDetails(
//       name: 'profitLossTotal', sortDirection: DataGridSortDirection.descending);
//   set lastSort(SortColumnDetails sort) => this._lastSort = sort;
//   get lastSort => this._lastSort;

//   String get profitLossMapName {
//     if (displayUnit == DISPLAY_UNIT.DOLLAR)
//       return 'profitLossTotal';
//     else if (displayUnit == DISPLAY_UNIT.PERCENT)
//       return 'profitLossPercentPortfolio';
//     else
//       return 'profitLossPercentPortfolio';
//   }

//   void updateDataGridSource() {
//     notifyListeners();
//   }

//   @override
//   Future<bool> handleSort() {
//     if (this.sortedColumns.isNotEmpty) {
//       this._lastSort = this.sortedColumns[0];
//       this.orderAnalytics.sort((a, b) => compare(a, b, this.sortedColumns[0]));
//       dataSource = this.orderAnalytics;
//     } else {
//       this.orderAnalytics.sort((a, b) => compare(a, b, this._lastSort));
//       dataSource = this.orderAnalytics;
//     }
//     return super.handleSort();
//   }

//   getSortColValue(TradeAnalysis obj, String colName) {
//     switch (colName) {
//       case 'profitLossTotal':
//         return obj.profitLossTotal;
//         break;
//       case 'profitLossPercentTotal':
//         return obj.profitLossPercentTotal;
//         break;
//       case 'profitLossPercentPortfolio':
//         return obj.profitLossPercentPortfolio;
//         break;
//       case 'gainPercentAverageInvestment':
//         return obj.gainPercentAverageInvestment;
//         break;
//       case 'averageDurationMinutes':
//         return obj.averageDurationMinutes;
//         break;
//       default:
//         return obj.profitLossTotal;
//         break;
//     }
//   }

//   @override
//   int compare(TradeAnalysis a, TradeAnalysis b, SortColumnDetails sortColumn) {
//     final colNames = [
//       'profitLossPercentPortfolio',
//       'profitLossTotal',
//       'profitLossPercentTotal',
//       'averageDurationMinutes',
//       'gainPercentAverageInvestment'
//     ];
//     if (colNames.contains(sortColumn.name)) {
//       final double val1 = getSortColValue(a, sortColumn.name) ?? 0;
//       final double val2 = getSortColValue(b, sortColumn.name) ?? 0;
//       if (sortColumn.sortDirection == DataGridSortDirection.ascending)
//         return val1.compareTo(val2);
//       else if (sortColumn.sortDirection == DataGridSortDirection.descending)
//         return val2.compareTo(val1);
//       else
//         return super.compare(a, b, sortColumn);
//     }
//     return super.compare(a, b, sortColumn);
//   }

//   @override
//   Object getValue(TradeAnalysis position, String columnName) {
//     switch (columnName) {
//       case 'symbol':
//         return '${position?.asset?.symbol ?? position.symbol}';
//         break;
//       case 'profitLossTotal':
//         return position.profitLossTotal.formatCurrency();
//         break;
//       case 'profitLossPercentPortfolio':
//         return position.profitLossPercentPortfolio.formatPercentage();
//         break;
//       case 'profitLossPercentTotal':
//         return position.profitLossPercentTotal.formatPercentage();
//         break;
//       case 'transactionCount':
//         return position.transactionCount;
//         break;
//       case 'gainPercentAverageInvestment':
//         return position.gainPercentAverageInvestment.formatPercentage();
//         break;
//       case 'averageInvestment':
//         return position.averageInvestment.formatCurrency();
//         break;
//       case 'averageRelativeInvestment':
//         return position.averageRelativeInvestment.formatPercentage();
//         break;
//       case 'averageDurationMinutes':
//         String unit = 'day';
//         double display = position.averageDurationMinutes / 1440;
//         if ((position.averageDurationMinutes / 1440) < 1) {
//           if ((position.averageDurationMinutes) / 60 < 1) {
//             unit = 'min';
//             display = position.averageDurationMinutes;
//           } else {
//             unit = 'hour';
//             display = position.averageDurationMinutes / 60;
//           }
//         }
//         return '${display.formatCompact()} $unit${display > 1 || display == 0 ? 's' : ''}';
//         break;
//       default:
//         return '';
//         break;
//     }
//   }
// }
