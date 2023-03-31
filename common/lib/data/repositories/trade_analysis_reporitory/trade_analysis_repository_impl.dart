import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class TradeAnalysisRepository implements ITradeAnalysisRepository {
  final IGraphqlProvider remoteProvider;
  final BaseRepository repository;
  TradeAnalysisRepository({
    required this.remoteProvider,
    required this.repository,
  });

  @override
  Repository<List<TradeAnalysis>> assetAnalysisGet({
    ASSET_ANALYSIS_LOCATOR? locator,
    List<int>? locatorKeys,
    List<String>? symbols,
    List<POSITION_TYPE>? positionTypes,
    List<OPTION_TYPE>? optionTypes,
    AssetAnalysisOrderBy? orderBy,
    DateRangeInput? between,
    int? limit,
    int? offset,
  }) {
    const document = '''query assetAnalysisGet(\$input: AssetAnalysisInput!){
        assetAnalysisGet(input:\$input){
          assetAnalysis {
            symbol
            asset {
              assetKey
              symbol
              name
              pictureUrl
              quote {
                latestPrice
                changePercent
              }
            }
            usersHoldingBull
            usersHoldingBear
            uniqueUsersPositionsOpenedCount
            totalAmountOpen
            bullishAmountOpen
            bearishAmountOpen
            totalAmountClose
            bullishAmountClose
            bearishAmountClose
            positionsOpenedCount
            positionsClosedCount
            totalTransactionCount
            totalTransactionAmount
            bullishTransactionAmount
            bearishTransactionAmount
            averageEquityBuyPrice
            averageEquitySellPrice
            totalPutStrike
            totalPutQuantity
            totalCallStrike
            totalCallQuantity
            callOpenOrderCount
            uniqueUserCallOpened
            putOpenOrderCount
            uniqueUserPutOpened
            equityOpenOrderCount
            uniqueUserEquityOpened
            callCloseOrderCount
            putCloseOrderCount
            equityCloseOrderCount
            uniqueUserEquityClosed
            callAmountOpen
            putAmountOpen
            equityAmountOpen
            callAmountClosed
            putAmountClosed
            equityAmountClosed
            totalCost
            averageBuyPrice
            averagePutStrike
            averageCallStrike
            bullishPositionsOpenedCount
            bearishPositionsOpenedCount
            bullishPositionsClosedCount
            bearishPositionsClosedCount
            bullishTransactionCount
            bearishTransactionCount
            bullishUserPositionsOpened
            bearishUserPositionsOpened
            averageCallDTE
            averagePutDTE
          }
        }
      }
    ''';
    final inputVars = {
      'input': {
        'locator': locator != null ? describeEnum(locator) : null,
        'locatorKeys': locatorKeys,
        'symbols': symbols,
        'positionTypes': positionTypes?.map((pt) => describeEnum(pt)).toList(),
        'optionTypes': optionTypes?.map((ot) => describeEnum(ot)).toList(),
        'orderBy': orderBy == null
            ? null
            : {
                'outlook': describeEnum(orderBy.outlook!),
                'orderBy': describeEnum(orderBy.orderBy!)
              },
        'limit': limit,
        'offset': offset,
        'between': between == null
            ? null
            : {
                'start': between.start.toString(),
                'end': between.end?.toString()
              }
      },
    };

    final dataFromRemote = Future<List<TradeAnalysis>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          variables: inputVars,
          document: document,
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }
      final tradeAnalysisData = data['assetAnalysisGet']['assetAnalysis'];
      final List<TradeAnalysis> tradeAnalysis = List<TradeAnalysis>.from(
          tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
      return tradeAnalysis;
    });

    final dataFromLocal = Future<List<TradeAnalysis>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        variables: inputVars,
        document: document,
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);

      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }

      final tradeAnalysisData = data['assetAnalysisGet']['assetAnalysis'];
      final List<TradeAnalysis> tradeAnalysis = List<TradeAnalysis>.from(
          tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
      return tradeAnalysis;
    });
    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }

  @override
  Future<void> getMostBearishorBullish({
    ASSET_ANALYSIS_LOCATOR? locator,
    List<int>? locatorKeys,
    List<String>? symbols,
    List<POSITION_TYPE>? positionTypes,
    List<OPTION_TYPE>? optionTypes,
    AssetAnalysisOrderBy? orderBy,
    DateRangeInput? between,
    int? limit,
    int? offset,
    QueryType queryType = QueryType.loadCache,
    required Function(List<TradeAnalysis> data) callback,
    required Function(OperationException error) onError,
  }) async {
    const document =
        '''query assetAnalysisGet(\$input: AssetAnalysisInput!, \$assetSpan: HISTORICAL_SPAN){
        assetAnalysisGet(input:\$input){
          assetAnalysis {
            symbol
            asset {
              assetKey
              pictureUrl
              quote {
                latestPrice
                changePercent
              }
              historical(input: {span:\$assetSpan}) {
                closeAmount
                returnPercentage
              }
            }
            usersHoldingBull
            usersHoldingBear
            uniqueUsersPositionsOpenedCount
            totalAmountOpen
            bullishAmountOpen
            bearishAmountOpen
            totalAmountClose
            bullishAmountClose
            bearishAmountClose
            positionsOpenedCount
            positionsClosedCount
            totalTransactionCount
            totalTransactionAmount
            bullishTransactionAmount
            bearishTransactionAmount
            averageEquityBuyPrice
            averageEquitySellPrice
            totalPutStrike
            totalPutQuantity
            totalCallStrike
            totalCallQuantity
            callOpenOrderCount
            uniqueUserCallOpened
            putOpenOrderCount
            uniqueUserPutOpened
            equityOpenOrderCount
            uniqueUserEquityOpened
            callCloseOrderCount
            putCloseOrderCount
            equityCloseOrderCount
            uniqueUserEquityClosed
            callAmountOpen
            putAmountOpen
            equityAmountOpen
            callAmountClosed
            putAmountClosed
            equityAmountClosed
            totalCost
            averageBuyPrice
            averagePutStrike
            averageCallStrike
            bullishPositionsOpenedCount
            bearishPositionsOpenedCount
            bullishPositionsClosedCount
            bearishPositionsClosedCount
            bullishTransactionCount
            bearishTransactionCount
            bullishUserPositionsOpened
            bearishUserPositionsOpened
            averageCallDTE
            averagePutDTE
          }
        }
      }
    ''';
    final inputVars = {
      'input': {
        'locator': locator != null ? describeEnum(locator) : null,
        'locatorKeys': locatorKeys,
        'symbols': symbols,
        'positionTypes': positionTypes?.map((pt) => describeEnum(pt)).toList(),
        'optionTypes': optionTypes?.map((ot) => describeEnum(ot)).toList(),
        'orderBy': orderBy == null
            ? null
            : {
                'outlook': describeEnum(orderBy.outlook!),
                'orderBy': describeEnum(orderBy.orderBy!)
              },
        'limit': limit,
        'offset': offset,
        'between': between == null
            ? null
            : {
                'start': between.start.toString(),
                'end': between.end?.toString()
              }
      },
    };
    return repository.query(
      type: orderBy!.outlook! == OUTLOOK.BEARISH
          ? CacheType.mostBearish
          : CacheType.mostBullish,
      id: orderBy.outlook! == OUTLOOK.BEARISH ? 'mostBearish' : 'mostBullish',
      document: document,
      variables: inputVars,
      queryType: queryType,
      callback: (data) {
        if (data == null) {
          return callback(<TradeAnalysis>[]);
        }

        final tradeAnalysisData = data['assetAnalysisGet']['assetAnalysis'];
        final List<TradeAnalysis> tradeAnalysis = List<TradeAnalysis>.from(
            tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
        callback(tradeAnalysis);
      },
      onError: onError,
    );
  }

  @override
  Repository<List<TradeAnalysis>> positionAnalysisGet({
    ASSET_ANALYSIS_LOCATOR? locator,
    List<int>? locatorKeys,
    List<String>? symbols,
    List<POSITION_TYPE>? positionTypes,
    List<OPTION_TYPE>? optionTypes,
    OPEN_POSITION_ORDER_BY? orderBy,
    OUTLOOK? outlook,
    DateTime? selectedDate,
    DateRangeInput? between,
    int? limit,
    int? offset,
  }) {
    const document =
        '''query positionAnalysisGet(\$input: PositionAnalysisInput!){
        positionAnalysisGet(input:\$input){
          positionAnalysis {
            symbol
            asset {
              assetKey
              pictureUrl
              quote {
                latestPrice
                changePercent
              }
            }
            symbol
            profitLossTotal
            profitLossPercentTotal
            totalAmountOpen
            positionType
            optionType
            totalCost
            totalQuantity
            usersHolding
            averageBuyPrice
          }
        }
      }
    ''';
    final inputVars = {
      'input': {
        'locator': locator != null ? describeEnum(locator) : null,
        'locatorKeys': locatorKeys,
        'symbols': symbols,
        'positionTypes': positionTypes?.map((pt) => describeEnum(pt)).toList(),
        'optionTypes': optionTypes?.map((ot) => describeEnum(ot)).toList(),
        'orderBy': describeEnum(orderBy!),
        'outlook': describeEnum(outlook!),
        'selectedDate': selectedDate?.toString(),
        'limit': limit,
        'offset': offset
      },
    };

    final dataFromRemote = Future<List<TradeAnalysis>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          variables: inputVars,
          document: document,
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }
      final tradeAnalysisData = data['positionAnalysisGet']['positionAnalysis'];
      final List<TradeAnalysis> tradeAnalysis = List<TradeAnalysis>.from(
          tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
      return tradeAnalysis;
    });

    final dataFromLocal = Future<List<TradeAnalysis>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        variables: inputVars,
        document: document,
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);

      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }

      final tradeAnalysisData = data['positionAnalysisGet']['positionAnalysis'];
      final List<TradeAnalysis> tradeAnalysis = List<TradeAnalysis>.from(
          tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
      return tradeAnalysis;
    });
    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }

  @override
  Repository<List<TradeAnalysis>> positionTypeAnalysisGet({
    LOCATOR? locator,
    List<int>? locatorKeys,
    List<String>? symbols,
    List<POSITION_TYPE>? positionTypes,
    required POSITION_STATUS positionStatus,
    List<OPTION_TYPE>? optionTypes,
    DateRangeInput? between,
    int? limit,
    // String requestedFields,
  }) {
    const document =
        '''query positionTypeAnalysisGet(\$input: PositionTypeAnalysisInput!){
        positionTypeAnalysisGet(input:\$input) {    	
          positionTypeAnalysis {
            orderStrategy
            profitLossTotal
            positionType
            optionType
            profitLossPercentTotal
            profitLossPercentRelative
            averageDurationMinutes
            averageInvestment
            averageRelativeInvestment
            gainPercentAverageInvestment
          }
        }
      }''';
    final inputVars = {
      'input': {
        'locator': describeEnum(locator!),
        'locatorKeys': locatorKeys,
        'symbols': symbols,
        'positionTypes': positionTypes?.map((pt) => describeEnum(pt)).toList(),
        'optionTypes': optionTypes?.map((ot) => describeEnum(ot)).toList(),
        'positionStatus': describeEnum(positionStatus),
        'limit': limit,
        'between': between == null
            ? null
            : {
                'start': between.start.toString(),
                'end': between.end?.toString()
              }
      },
    };

    final dataFromRemote = Future<List<TradeAnalysis>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          variables: inputVars,
          document: document,
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }
      final tradeAnalysisData =
          data['positionTypeAnalysisGet']['positionTypeAnalysis'];
      final List<TradeAnalysis> tradeAnalysis = List<TradeAnalysis>.from(
          tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
      return tradeAnalysis;
    });

    final dataFromLocal = Future<List<TradeAnalysis>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        variables: inputVars,
        document: document,
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);

      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }

      final tradeAnalysisData =
          data['positionTypeAnalysisGet']['positionTypeAnalysis'];
      final List<TradeAnalysis> tradeAnalysis = List<TradeAnalysis>.from(
          tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
      return tradeAnalysis;
    });
    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }

  @override
  Repository<List<TradeAnalysis>> tradeAnalysisGet({
    LOCATOR? locator,
    List<int>? locatorKeys,
    List<String>? symbols,
    List<POSITION_TYPE>? positionTypes,
    List<OPTION_TYPE>? optionTypes,
    required ORDER_GROUP_BY orderGroupBy,
    required DECIDING_UNIT unit,
    required POSITION_STATUS positionStatus,
    DateRangeInput? between,
    int? limit,
    int? offset,
    // String requestedFields,
  }) {
    // requestedFields ??= defaultTopOrdersGetFields;
    const document = '''query tradeAnalysisGet(\$input: TradeAnalysisInput!){
        tradeAnalysisGet(input:\$input){
          tradeAnalysis {
            symbol
            asset {
              symbol
              assetKey
              pictureUrl
              name
            }
            profitLossTotal
            profitLossPercentTotal
            profitLossPercentRelative
            profitLossPercentPortfolio
            openedAt
            closedAt
            positionClosed
            averageDurationMinutes
            averageInvestment
            averageRelativeInvestment
            gainPercentAverageInvestment
            transactionCount
            orderStrategies
            positionTypes
            orderGroupUUIDS
            positionEffects {
              open
              close
            }
          }
        }
      }
    ''';
    final inputVars = {
      'input': {
        'locator': describeEnum(locator!),
        'locatorKeys': locatorKeys,
        'symbols': symbols,
        'positionTypes': positionTypes?.map((pt) => describeEnum(pt)).toList(),
        'optionTypes': optionTypes?.map((ot) => describeEnum(ot)).toList(),
        'groupBy': describeEnum(orderGroupBy),
        'unit': describeEnum(unit),
        'positionStatus': describeEnum(positionStatus),
        'limit': limit,
        'offset': offset,
        'between': between == null
            ? null
            : {
                'start': between.start.toString(),
                'end': between.end?.toString()
              }
      },
    };

    final dataFromRemote = Future<List<TradeAnalysis>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          variables: inputVars,
          document: document,
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }
      final tradeAnalysisData = data['tradeAnalysisGet']['tradeAnalysis'];
      final List<TradeAnalysis> tradeAnalysis = List<TradeAnalysis>.from(
          tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
      return tradeAnalysis;
    });

    final dataFromLocal = Future<List<TradeAnalysis>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        variables: inputVars,
        document: document,
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }

      final tradeAnalysisData = data['tradeAnalysisGet']['tradeAnalysis'];
      final List<TradeAnalysis> tradeAnalysis = List<TradeAnalysis>.from(
          tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
      return tradeAnalysis;
    });
    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }
}
