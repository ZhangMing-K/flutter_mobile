enum SORT_BY { TICKER, PINVESTORS, DINVESTED, BULLISHORBEARISH, STREAK }

class SortColumns {
  SORT_BY? sortBy;
  bool? orderByAsc;
  SortColumns({this.sortBy, this.orderByAsc});
}

const List<double> tableWidth = [
  120,
  120,
  120,
];

const List<String> tableHeader = [
  '% of investors',
  '\$ invested',
  'Bullish/Bearish',
];

const List<SORT_BY> tableSortBy = [
  SORT_BY.PINVESTORS,
  SORT_BY.DINVESTED,
  SORT_BY.BULLISHORBEARISH,
  SORT_BY.STREAK,
];

const double staticWidth = 120;
