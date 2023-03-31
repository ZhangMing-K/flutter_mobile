import '../../iris_common.dart';

const Map<String, BROKER_NAME> brokerNameMap = {
  'robinhood': BROKER_NAME.ROBINHOOD,
  'td_ameritrade': BROKER_NAME.TD_AMERITRADE,
  'etrade': BROKER_NAME.ETRADE,
  'webull': BROKER_NAME.WEBULL,
};

const Map<BROKER_NAME, String> brokerNameToReadableMap = {
  BROKER_NAME.ROBINHOOD: 'Robinhood',
  BROKER_NAME.TD_AMERITRADE: 'TD Ameritrade',
  BROKER_NAME.ETRADE: 'ETrade',
  BROKER_NAME.WEBULL: 'Webull',
};

class HistoricalSpanDisplay {
  HISTORICAL_SPAN span;

  HistoricalSpanDisplay({required this.span});
  String get displaySpan {
    if (span == HISTORICAL_SPAN.DAY) {
      return 'Day';
    } else if (span == HISTORICAL_SPAN.WEEK) {
      return 'Week';
    } else if (span == HISTORICAL_SPAN.MONTH) {
      return 'Month';
    } else if (span == HISTORICAL_SPAN.THREE_MONTH) {
      return 'Three Month';
    } else if (span == HISTORICAL_SPAN.YEAR) {
      return 'Year';
    } else if (span == HISTORICAL_SPAN.ALL) {
      return 'All';
    }
    return 'n/a';
  }
}

// enum PORTFOLIO_CONNECTION_STATUS { CONNECTED, NOT_CONNECTED, HIDDEN, REMOVED }

// enum WATCH_PORTFOLIO { UNWATCH, WATCH }
