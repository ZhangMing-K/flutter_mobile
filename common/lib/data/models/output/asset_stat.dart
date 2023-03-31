import 'package:collection/collection.dart';

class AssetStat {
  final double? totalCash;
  final double? currentDebt;
  final double? revenue;
  final double? grossProfit;
  final double? totalRevenue;
  final double? ebitda;
  final double? revenuePerShare;
  final double? revenuePerEmployee;
  final double? profitMargin;
  final double? enterpriseValue;
  final double? enterpriseValueToRevenue;
  final double? priceToSales;
  final double? priceToBook;
  final double? forwardPERatio;
  final double? pegRatio;
  final double? peHigh;
  final double? peLow;
  final double? putCallRatio;
  final double? marketCap;
  final double? week52High;
  final double? week52Low;
  final double? week52Change;
  final double? sharesOutstanding;
  final double? dividendYield;
  final double? float;
  final double? avg10Volume;
  final double? avg30Volume;
  final int? numberEmployees;
  final double? ttmEPS;
  final double? ttmDividendRate;
  final double? nextDividendRate;
  final double? peRatio;
  final double? beta;
  final double? maxChangePercent;
  final double? year5ChangePercent;
  final double? year2ChangePercent;
  final double? year1ChangePercent;
  final double? month6ChangePercent;
  final double? month3ChangePercent;
  final double? month1ChangePercent;
  final double? day30ChangePercent;
  final double? day5ChangePercent;
  final DateTime? week52HighDate;
  final DateTime? week52LowDate;
  final DateTime? exDividendDate;
  final DateTime? nextDividendDate;
  final DateTime? nextEarningsDate;
  final double? day50MovingAverage;
  final double? day200MovingAverage;
  const AssetStat(
      {this.totalCash,
      this.currentDebt,
      this.revenue,
      this.grossProfit,
      this.totalRevenue,
      this.ebitda,
      this.revenuePerShare,
      this.revenuePerEmployee,
      this.profitMargin,
      this.enterpriseValue,
      this.enterpriseValueToRevenue,
      this.priceToSales,
      this.priceToBook,
      this.forwardPERatio,
      this.pegRatio,
      this.peHigh,
      this.peLow,
      this.putCallRatio,
      this.marketCap,
      this.week52High,
      this.week52Low,
      this.week52Change,
      this.sharesOutstanding,
      this.dividendYield,
      this.float,
      this.avg10Volume,
      this.avg30Volume,
      this.numberEmployees,
      this.ttmEPS,
      this.ttmDividendRate,
      this.nextDividendRate,
      this.peRatio,
      this.beta,
      this.maxChangePercent,
      this.year5ChangePercent,
      this.year2ChangePercent,
      this.year1ChangePercent,
      this.month6ChangePercent,
      this.month3ChangePercent,
      this.month1ChangePercent,
      this.day30ChangePercent,
      this.day5ChangePercent,
      this.week52HighDate,
      this.week52LowDate,
      this.exDividendDate,
      this.nextDividendDate,
      this.nextEarningsDate,
      this.day50MovingAverage,
      this.day200MovingAverage});
  AssetStat copyWith(
      {double? totalCash,
      double? currentDebt,
      double? revenue,
      double? grossProfit,
      double? totalRevenue,
      double? ebitda,
      double? revenuePerShare,
      double? revenuePerEmployee,
      double? profitMargin,
      double? enterpriseValue,
      double? enterpriseValueToRevenue,
      double? priceToSales,
      double? priceToBook,
      double? forwardPERatio,
      double? pegRatio,
      double? peHigh,
      double? peLow,
      double? putCallRatio,
      double? marketCap,
      double? week52High,
      double? week52Low,
      double? week52Change,
      double? sharesOutstanding,
      double? dividendYield,
      double? float,
      double? avg10Volume,
      double? avg30Volume,
      int? numberEmployees,
      double? ttmEPS,
      double? ttmDividendRate,
      double? nextDividendRate,
      double? peRatio,
      double? beta,
      double? maxChangePercent,
      double? year5ChangePercent,
      double? year2ChangePercent,
      double? year1ChangePercent,
      double? month6ChangePercent,
      double? month3ChangePercent,
      double? month1ChangePercent,
      double? day30ChangePercent,
      double? day5ChangePercent,
      DateTime? week52HighDate,
      DateTime? week52LowDate,
      DateTime? exDividendDate,
      DateTime? nextDividendDate,
      DateTime? nextEarningsDate,
      double? day50MovingAverage,
      double? day200MovingAverage}) {
    return AssetStat(
      totalCash: totalCash ?? this.totalCash,
      currentDebt: currentDebt ?? this.currentDebt,
      revenue: revenue ?? this.revenue,
      grossProfit: grossProfit ?? this.grossProfit,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      ebitda: ebitda ?? this.ebitda,
      revenuePerShare: revenuePerShare ?? this.revenuePerShare,
      revenuePerEmployee: revenuePerEmployee ?? this.revenuePerEmployee,
      profitMargin: profitMargin ?? this.profitMargin,
      enterpriseValue: enterpriseValue ?? this.enterpriseValue,
      enterpriseValueToRevenue:
          enterpriseValueToRevenue ?? this.enterpriseValueToRevenue,
      priceToSales: priceToSales ?? this.priceToSales,
      priceToBook: priceToBook ?? this.priceToBook,
      forwardPERatio: forwardPERatio ?? this.forwardPERatio,
      pegRatio: pegRatio ?? this.pegRatio,
      peHigh: peHigh ?? this.peHigh,
      peLow: peLow ?? this.peLow,
      putCallRatio: putCallRatio ?? this.putCallRatio,
      marketCap: marketCap ?? this.marketCap,
      week52High: week52High ?? this.week52High,
      week52Low: week52Low ?? this.week52Low,
      week52Change: week52Change ?? this.week52Change,
      sharesOutstanding: sharesOutstanding ?? this.sharesOutstanding,
      dividendYield: dividendYield ?? this.dividendYield,
      float: float ?? this.float,
      avg10Volume: avg10Volume ?? this.avg10Volume,
      avg30Volume: avg30Volume ?? this.avg30Volume,
      numberEmployees: numberEmployees ?? this.numberEmployees,
      ttmEPS: ttmEPS ?? this.ttmEPS,
      ttmDividendRate: ttmDividendRate ?? this.ttmDividendRate,
      nextDividendRate: nextDividendRate ?? this.nextDividendRate,
      peRatio: peRatio ?? this.peRatio,
      beta: beta ?? this.beta,
      maxChangePercent: maxChangePercent ?? this.maxChangePercent,
      year5ChangePercent: year5ChangePercent ?? this.year5ChangePercent,
      year2ChangePercent: year2ChangePercent ?? this.year2ChangePercent,
      year1ChangePercent: year1ChangePercent ?? this.year1ChangePercent,
      month6ChangePercent: month6ChangePercent ?? this.month6ChangePercent,
      month3ChangePercent: month3ChangePercent ?? this.month3ChangePercent,
      month1ChangePercent: month1ChangePercent ?? this.month1ChangePercent,
      day30ChangePercent: day30ChangePercent ?? this.day30ChangePercent,
      day5ChangePercent: day5ChangePercent ?? this.day5ChangePercent,
      week52HighDate: week52HighDate ?? this.week52HighDate,
      week52LowDate: week52LowDate ?? this.week52LowDate,
      exDividendDate: exDividendDate ?? this.exDividendDate,
      nextDividendDate: nextDividendDate ?? this.nextDividendDate,
      nextEarningsDate: nextEarningsDate ?? this.nextEarningsDate,
      day50MovingAverage: day50MovingAverage ?? this.day50MovingAverage,
      day200MovingAverage: day200MovingAverage ?? this.day200MovingAverage,
    );
  }

  factory AssetStat.fromJson(Map<String, dynamic> json) {
    return AssetStat(
      totalCash: json['totalCash']?.toDouble(),
      currentDebt: json['currentDebt']?.toDouble(),
      revenue: json['revenue']?.toDouble(),
      grossProfit: json['grossProfit']?.toDouble(),
      totalRevenue: json['totalRevenue']?.toDouble(),
      ebitda: json['ebitda']?.toDouble(),
      revenuePerShare: json['revenuePerShare']?.toDouble(),
      revenuePerEmployee: json['revenuePerEmployee']?.toDouble(),
      profitMargin: json['profitMargin']?.toDouble(),
      enterpriseValue: json['enterpriseValue']?.toDouble(),
      enterpriseValueToRevenue: json['enterpriseValueToRevenue']?.toDouble(),
      priceToSales: json['priceToSales']?.toDouble(),
      priceToBook: json['priceToBook']?.toDouble(),
      forwardPERatio: json['forwardPERatio']?.toDouble(),
      pegRatio: json['pegRatio']?.toDouble(),
      peHigh: json['peHigh']?.toDouble(),
      peLow: json['peLow']?.toDouble(),
      putCallRatio: json['putCallRatio']?.toDouble(),
      marketCap: json['marketCap']?.toDouble(),
      week52High: json['week52High']?.toDouble(),
      week52Low: json['week52Low']?.toDouble(),
      week52Change: json['week52Change']?.toDouble(),
      sharesOutstanding: json['sharesOutstanding']?.toDouble(),
      dividendYield: json['dividendYield']?.toDouble(),
      float: json['float']?.toDouble(),
      avg10Volume: json['avg10Volume']?.toDouble(),
      avg30Volume: json['avg30Volume']?.toDouble(),
      numberEmployees: json['numberEmployees'],
      ttmEPS: json['ttmEPS']?.toDouble(),
      ttmDividendRate: json['ttmDividendRate']?.toDouble(),
      nextDividendRate: json['nextDividendRate']?.toDouble(),
      peRatio: json['peRatio']?.toDouble(),
      beta: json['beta']?.toDouble(),
      maxChangePercent: json['maxChangePercent']?.toDouble(),
      year5ChangePercent: json['year5ChangePercent']?.toDouble(),
      year2ChangePercent: json['year2ChangePercent']?.toDouble(),
      year1ChangePercent: json['year1ChangePercent']?.toDouble(),
      month6ChangePercent: json['month6ChangePercent']?.toDouble(),
      month3ChangePercent: json['month3ChangePercent']?.toDouble(),
      month1ChangePercent: json['month1ChangePercent']?.toDouble(),
      day30ChangePercent: json['day30ChangePercent']?.toDouble(),
      day5ChangePercent: json['day5ChangePercent']?.toDouble(),
      week52HighDate: json['week52HighDate'] != null
          ? DateTime.parse(json['week52HighDate'])
          : null,
      week52LowDate: json['week52LowDate'] != null
          ? DateTime.parse(json['week52LowDate'])
          : null,
      exDividendDate: json['exDividendDate'] != null
          ? DateTime.parse(json['exDividendDate'])
          : null,
      nextDividendDate: json['nextDividendDate'] != null
          ? DateTime.parse(json['nextDividendDate'])
          : null,
      nextEarningsDate: json['nextEarningsDate'] != null
          ? DateTime.parse(json['nextEarningsDate'])
          : null,
      day50MovingAverage: json['day50MovingAverage']?.toDouble(),
      day200MovingAverage: json['day200MovingAverage']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['totalCash'] = totalCash;
    data['currentDebt'] = currentDebt;
    data['revenue'] = revenue;
    data['grossProfit'] = grossProfit;
    data['totalRevenue'] = totalRevenue;
    data['ebitda'] = ebitda;
    data['revenuePerShare'] = revenuePerShare;
    data['revenuePerEmployee'] = revenuePerEmployee;
    data['profitMargin'] = profitMargin;
    data['enterpriseValue'] = enterpriseValue;
    data['enterpriseValueToRevenue'] = enterpriseValueToRevenue;
    data['priceToSales'] = priceToSales;
    data['priceToBook'] = priceToBook;
    data['forwardPERatio'] = forwardPERatio;
    data['pegRatio'] = pegRatio;
    data['peHigh'] = peHigh;
    data['peLow'] = peLow;
    data['putCallRatio'] = putCallRatio;
    data['marketCap'] = marketCap;
    data['week52High'] = week52High;
    data['week52Low'] = week52Low;
    data['week52Change'] = week52Change;
    data['sharesOutstanding'] = sharesOutstanding;
    data['dividendYield'] = dividendYield;
    data['float'] = float;
    data['avg10Volume'] = avg10Volume;
    data['avg30Volume'] = avg30Volume;
    data['numberEmployees'] = numberEmployees;
    data['ttmEPS'] = ttmEPS;
    data['ttmDividendRate'] = ttmDividendRate;
    data['nextDividendRate'] = nextDividendRate;
    data['peRatio'] = peRatio;
    data['beta'] = beta;
    data['maxChangePercent'] = maxChangePercent;
    data['year5ChangePercent'] = year5ChangePercent;
    data['year2ChangePercent'] = year2ChangePercent;
    data['year1ChangePercent'] = year1ChangePercent;
    data['month6ChangePercent'] = month6ChangePercent;
    data['month3ChangePercent'] = month3ChangePercent;
    data['month1ChangePercent'] = month1ChangePercent;
    data['day30ChangePercent'] = day30ChangePercent;
    data['day5ChangePercent'] = day5ChangePercent;
    data['week52HighDate'] = week52HighDate?.toString();
    data['week52LowDate'] = week52LowDate?.toString();
    data['exDividendDate'] = exDividendDate?.toString();
    data['nextDividendDate'] = nextDividendDate?.toString();
    data['nextEarningsDate'] = nextEarningsDate?.toString();
    data['day50MovingAverage'] = day50MovingAverage;
    data['day200MovingAverage'] = day200MovingAverage;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetStat &&
            (identical(other.totalCash, totalCash) ||
                const DeepCollectionEquality()
                    .equals(other.totalCash, totalCash)) &&
            (identical(other.currentDebt, currentDebt) ||
                const DeepCollectionEquality()
                    .equals(other.currentDebt, currentDebt)) &&
            (identical(other.revenue, revenue) ||
                const DeepCollectionEquality()
                    .equals(other.revenue, revenue)) &&
            (identical(other.grossProfit, grossProfit) ||
                const DeepCollectionEquality()
                    .equals(other.grossProfit, grossProfit)) &&
            (identical(other.totalRevenue, totalRevenue) ||
                const DeepCollectionEquality()
                    .equals(other.totalRevenue, totalRevenue)) &&
            (identical(other.ebitda, ebitda) ||
                const DeepCollectionEquality().equals(other.ebitda, ebitda)) &&
            (identical(other.revenuePerShare, revenuePerShare) ||
                const DeepCollectionEquality()
                    .equals(other.revenuePerShare, revenuePerShare)) &&
            (identical(other.revenuePerEmployee, revenuePerEmployee) ||
                const DeepCollectionEquality()
                    .equals(other.revenuePerEmployee, revenuePerEmployee)) &&
            (identical(other.profitMargin, profitMargin) ||
                const DeepCollectionEquality()
                    .equals(other.profitMargin, profitMargin)) &&
            (identical(other.enterpriseValue, enterpriseValue) ||
                const DeepCollectionEquality()
                    .equals(other.enterpriseValue, enterpriseValue)) &&
            (identical(other.enterpriseValueToRevenue, enterpriseValueToRevenue) ||
                const DeepCollectionEquality().equals(
                    other.enterpriseValueToRevenue,
                    enterpriseValueToRevenue)) &&
            (identical(other.priceToSales, priceToSales) ||
                const DeepCollectionEquality()
                    .equals(other.priceToSales, priceToSales)) &&
            (identical(other.priceToBook, priceToBook) ||
                const DeepCollectionEquality()
                    .equals(other.priceToBook, priceToBook)) &&
            (identical(other.forwardPERatio, forwardPERatio) ||
                const DeepCollectionEquality()
                    .equals(other.forwardPERatio, forwardPERatio)) &&
            (identical(other.pegRatio, pegRatio) ||
                const DeepCollectionEquality()
                    .equals(other.pegRatio, pegRatio)) &&
            (identical(other.peHigh, peHigh) ||
                const DeepCollectionEquality().equals(other.peHigh, peHigh)) &&
            (identical(other.peLow, peLow) ||
                const DeepCollectionEquality().equals(other.peLow, peLow)) &&
            (identical(other.putCallRatio, putCallRatio) ||
                const DeepCollectionEquality()
                    .equals(other.putCallRatio, putCallRatio)) &&
            (identical(other.marketCap, marketCap) ||
                const DeepCollectionEquality()
                    .equals(other.marketCap, marketCap)) &&
            (identical(other.week52High, week52High) ||
                const DeepCollectionEquality()
                    .equals(other.week52High, week52High)) &&
            (identical(other.week52Low, week52Low) ||
                const DeepCollectionEquality().equals(other.week52Low, week52Low)) &&
            (identical(other.week52Change, week52Change) || const DeepCollectionEquality().equals(other.week52Change, week52Change)) &&
            (identical(other.sharesOutstanding, sharesOutstanding) || const DeepCollectionEquality().equals(other.sharesOutstanding, sharesOutstanding)) &&
            (identical(other.dividendYield, dividendYield) || const DeepCollectionEquality().equals(other.dividendYield, dividendYield)) &&
            (identical(other.float, float) || const DeepCollectionEquality().equals(other.float, float)) &&
            (identical(other.avg10Volume, avg10Volume) || const DeepCollectionEquality().equals(other.avg10Volume, avg10Volume)) &&
            (identical(other.avg30Volume, avg30Volume) || const DeepCollectionEquality().equals(other.avg30Volume, avg30Volume)) &&
            (identical(other.numberEmployees, numberEmployees) || const DeepCollectionEquality().equals(other.numberEmployees, numberEmployees)) &&
            (identical(other.ttmEPS, ttmEPS) || const DeepCollectionEquality().equals(other.ttmEPS, ttmEPS)) &&
            (identical(other.ttmDividendRate, ttmDividendRate) || const DeepCollectionEquality().equals(other.ttmDividendRate, ttmDividendRate)) &&
            (identical(other.nextDividendRate, nextDividendRate) || const DeepCollectionEquality().equals(other.nextDividendRate, nextDividendRate)) &&
            (identical(other.peRatio, peRatio) || const DeepCollectionEquality().equals(other.peRatio, peRatio)) &&
            (identical(other.beta, beta) || const DeepCollectionEquality().equals(other.beta, beta)) &&
            (identical(other.maxChangePercent, maxChangePercent) || const DeepCollectionEquality().equals(other.maxChangePercent, maxChangePercent)) &&
            (identical(other.year5ChangePercent, year5ChangePercent) || const DeepCollectionEquality().equals(other.year5ChangePercent, year5ChangePercent)) &&
            (identical(other.year2ChangePercent, year2ChangePercent) || const DeepCollectionEquality().equals(other.year2ChangePercent, year2ChangePercent)) &&
            (identical(other.year1ChangePercent, year1ChangePercent) || const DeepCollectionEquality().equals(other.year1ChangePercent, year1ChangePercent)) &&
            (identical(other.month6ChangePercent, month6ChangePercent) || const DeepCollectionEquality().equals(other.month6ChangePercent, month6ChangePercent)) &&
            (identical(other.month3ChangePercent, month3ChangePercent) || const DeepCollectionEquality().equals(other.month3ChangePercent, month3ChangePercent)) &&
            (identical(other.month1ChangePercent, month1ChangePercent) || const DeepCollectionEquality().equals(other.month1ChangePercent, month1ChangePercent)) &&
            (identical(other.day30ChangePercent, day30ChangePercent) || const DeepCollectionEquality().equals(other.day30ChangePercent, day30ChangePercent)) &&
            (identical(other.day5ChangePercent, day5ChangePercent) || const DeepCollectionEquality().equals(other.day5ChangePercent, day5ChangePercent)) &&
            (identical(other.week52HighDate, week52HighDate) || const DeepCollectionEquality().equals(other.week52HighDate, week52HighDate)) &&
            (identical(other.week52LowDate, week52LowDate) || const DeepCollectionEquality().equals(other.week52LowDate, week52LowDate)) &&
            (identical(other.exDividendDate, exDividendDate) || const DeepCollectionEquality().equals(other.exDividendDate, exDividendDate)) &&
            (identical(other.nextDividendDate, nextDividendDate) || const DeepCollectionEquality().equals(other.nextDividendDate, nextDividendDate)) &&
            (identical(other.nextEarningsDate, nextEarningsDate) || const DeepCollectionEquality().equals(other.nextEarningsDate, nextEarningsDate)) &&
            (identical(other.day50MovingAverage, day50MovingAverage) || const DeepCollectionEquality().equals(other.day50MovingAverage, day50MovingAverage)) &&
            (identical(other.day200MovingAverage, day200MovingAverage) || const DeepCollectionEquality().equals(other.day200MovingAverage, day200MovingAverage)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(totalCash) ^
        const DeepCollectionEquality().hash(currentDebt) ^
        const DeepCollectionEquality().hash(revenue) ^
        const DeepCollectionEquality().hash(grossProfit) ^
        const DeepCollectionEquality().hash(totalRevenue) ^
        const DeepCollectionEquality().hash(ebitda) ^
        const DeepCollectionEquality().hash(revenuePerShare) ^
        const DeepCollectionEquality().hash(revenuePerEmployee) ^
        const DeepCollectionEquality().hash(profitMargin) ^
        const DeepCollectionEquality().hash(enterpriseValue) ^
        const DeepCollectionEquality().hash(enterpriseValueToRevenue) ^
        const DeepCollectionEquality().hash(priceToSales) ^
        const DeepCollectionEquality().hash(priceToBook) ^
        const DeepCollectionEquality().hash(forwardPERatio) ^
        const DeepCollectionEquality().hash(pegRatio) ^
        const DeepCollectionEquality().hash(peHigh) ^
        const DeepCollectionEquality().hash(peLow) ^
        const DeepCollectionEquality().hash(putCallRatio) ^
        const DeepCollectionEquality().hash(marketCap) ^
        const DeepCollectionEquality().hash(week52High) ^
        const DeepCollectionEquality().hash(week52Low) ^
        const DeepCollectionEquality().hash(week52Change) ^
        const DeepCollectionEquality().hash(sharesOutstanding) ^
        const DeepCollectionEquality().hash(dividendYield) ^
        const DeepCollectionEquality().hash(float) ^
        const DeepCollectionEquality().hash(avg10Volume) ^
        const DeepCollectionEquality().hash(avg30Volume) ^
        const DeepCollectionEquality().hash(numberEmployees) ^
        const DeepCollectionEquality().hash(ttmEPS) ^
        const DeepCollectionEquality().hash(ttmDividendRate) ^
        const DeepCollectionEquality().hash(nextDividendRate) ^
        const DeepCollectionEquality().hash(peRatio) ^
        const DeepCollectionEquality().hash(beta) ^
        const DeepCollectionEquality().hash(maxChangePercent) ^
        const DeepCollectionEquality().hash(year5ChangePercent) ^
        const DeepCollectionEquality().hash(year2ChangePercent) ^
        const DeepCollectionEquality().hash(year1ChangePercent) ^
        const DeepCollectionEquality().hash(month6ChangePercent) ^
        const DeepCollectionEquality().hash(month3ChangePercent) ^
        const DeepCollectionEquality().hash(month1ChangePercent) ^
        const DeepCollectionEquality().hash(day30ChangePercent) ^
        const DeepCollectionEquality().hash(day5ChangePercent) ^
        const DeepCollectionEquality().hash(week52HighDate) ^
        const DeepCollectionEquality().hash(week52LowDate) ^
        const DeepCollectionEquality().hash(exDividendDate) ^
        const DeepCollectionEquality().hash(nextDividendDate) ^
        const DeepCollectionEquality().hash(nextEarningsDate) ^
        const DeepCollectionEquality().hash(day50MovingAverage) ^
        const DeepCollectionEquality().hash(day200MovingAverage);
  }

  @override
  String toString() => 'AssetStat(${toJson()})';
}
