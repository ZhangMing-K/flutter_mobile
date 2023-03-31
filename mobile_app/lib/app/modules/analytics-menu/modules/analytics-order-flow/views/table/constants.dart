enum SORT_BY {
  TIME,
  TICKER,
  STRATEGY,
  INVESTED,
  TRADER_ACCURACY,
  TRADER_PERCENTILE
}

class SortColumns {
  SORT_BY? sortBy;
  bool? orderByAsc;
  SortColumns({this.sortBy, this.orderByAsc});
}

const List<double> optionTableWidth = [
  50,
  65,
  80,
  90,
  80,
  80,
  80,
  80,
  80,
  80,
  80,
  80,
];

const List<String> optionTableHeader = [
  'Time',
  'Strategy',
  'Trader percentile',
  '\$ Invested',
  'Trader accuracy',
  '% of portfolio',
  'Expiration',
  'Strike',
  'Current',
  'Buy/Sell',
  'Open/Close',
  'Gain/loss'
];

const List<SORT_BY> optionTableSortBy = [
  SORT_BY.TIME,
  SORT_BY.STRATEGY,
  SORT_BY.TRADER_PERCENTILE,
  SORT_BY.INVESTED,
  SORT_BY.TRADER_ACCURACY,
  SORT_BY.TIME,
  SORT_BY.TIME,
  SORT_BY.TIME,
  SORT_BY.TIME,
  SORT_BY.TIME,
  SORT_BY.TIME,
  SORT_BY.TIME,
];

const List<double> equityTableWidth = [
  50,
  65,
  80,
  90,
  80,
  80,
  80,
  80,
  80,
  90,
];

const List<String> equityTableHeader = [
  'Time',
  'Strategy',
  'Trader percentile',
  '\$ Invested',
  'Trader accuracy',
  '% of portfolio',
  'Buy price',
  'Current',
  'Gain/Loss',
  'Open/Close',
];

const List<SORT_BY> equityTableSortBy = [
  SORT_BY.TIME,
  SORT_BY.STRATEGY,
  SORT_BY.TRADER_PERCENTILE,
  SORT_BY.INVESTED,
  SORT_BY.TIME,
  SORT_BY.TIME,
  SORT_BY.TIME,
  SORT_BY.TIME,
  SORT_BY.TRADER_ACCURACY,
  SORT_BY.TIME,
];

const double staticWidth = 65;
