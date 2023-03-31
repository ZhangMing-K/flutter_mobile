import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class TradeAnalysisService extends GetxService {
  IGraphqlProvider iGraphqlProvider = Get.find();
  TradeAnalysisService();

  Future<List<TradeAnalysis>> assetAnalysisGet({
    ASSET_ANALYSIS_LOCATOR? locator,
    List<int>? locatorKeys,
    List<String>? symbols,
    List<POSITION_TYPE>? positionTypes,
    List<OPTION_TYPE>? optionTypes,
    AssetAnalysisOrderBy? orderBy,
    DateRangeInput? between,
    int? limit,
    int? offset,
  }) async {
    const document = '''query assetAnalysisGet(\$input: AssetAnalysisInput!){
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

    final queryOptions = iGraphqlProvider.createQueryOptions(
      document: document,
      variables: inputVars,
    );

    try {
      final res = await iGraphqlProvider
          .queryWithOptions(queryOptions)
          .catchError((e) {});
      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }
      final tradeAnalysisData = data['assetAnalysisGet']['assetAnalysis'];
      final List<TradeAnalysis> tradeAnalysis = List<TradeAnalysis>.from(
          tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
      return tradeAnalysis;
    } catch (err) {
      debugPrint(err.toString());
      return <TradeAnalysis>[];
    }
  }

  Future<List<TradeAnalysis>> positionAnalysisGet({
    ASSET_ANALYSIS_LOCATOR? locator,
    List<int>? locatorKeys,
    List<String>? symbols,
    List<POSITION_TYPE>? positionTypes,
    List<OPTION_TYPE>? optionTypes,
    required OPEN_POSITION_ORDER_BY orderBy,
    required OUTLOOK outlook,
    DateTime? selectedDate,
    DateRangeInput? between,
    int? limit,
    int? offset,
  }) async {
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
        'orderBy': describeEnum(orderBy),
        'outlook': describeEnum(outlook),
        'selectedDate': selectedDate?.toString(),
        'limit': limit,
        'offset': offset
      },
    };

    final queryOptions = iGraphqlProvider.createQueryOptions(
      document: document,
      variables: inputVars,
    );

    try {
      final res = await iGraphqlProvider
          .queryWithOptions(queryOptions)
          .catchError((e) {});
      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }
      final tradeAnalysisData = data['positionAnalysisGet']['positionAnalysis'];
      final List<TradeAnalysis> tradeAnalysis = List<TradeAnalysis>.from(
          tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
      return tradeAnalysis;
    } catch (err) {
      return <TradeAnalysis>[];
    }
  }

  Future<List<TradeAnalysis>> positionTypeAnalysisGet({
    required LOCATOR locator,
    List<int?>? locatorKeys,
    List<String>? symbols,
    List<POSITION_TYPE>? positionTypes,
    required POSITION_STATUS positionStatus,
    List<OPTION_TYPE>? optionTypes,
    DateRangeInput? between,
    int? limit,
    // String requestedFields,
  }) async {
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
    final queryOptions =
        iGraphqlProvider.createQueryOptions(document: document, variables: {
      'input': {
        'locator': describeEnum(locator),
        'locatorKeys': locatorKeys,
        'symbols': symbols,
        'positionTypes': positionTypes?.map((pt) => describeEnum(pt)).toList(),
        'optionTypes': optionTypes?.map((ot) => describeEnum(ot)).toList(),
        'positionStatus': describeEnum(positionStatus),
        'limit': limit,
        'between': between == null
            ? null
            : {'start': between.start.toString(), 'end': between.end.toString()}
      },
    });
    try {
      final res = await iGraphqlProvider
          .queryWithOptions(queryOptions)
          .catchError((e) {});

      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }
      final positionTypeAnalysisData =
          data['positionTypeAnalysisGet']['positionTypeAnalysis'];
      final List<TradeAnalysis> positionTypeAnalysis = List<TradeAnalysis>.from(
          positionTypeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
      return positionTypeAnalysis;
    } catch (err) {
      debugPrint(err.toString());
      return <TradeAnalysis>[];
    }
  }

  Future<List<TradeAnalysis>> tradeAnalysisGet({
    required LOCATOR locator,
    List<int?>? locatorKeys,
    List<String>? symbols,
    List<POSITION_TYPE?>? positionTypes,
    List<OPTION_TYPE?>? optionTypes,
    required ORDER_GROUP_BY orderGroupBy,
    required DECIDING_UNIT unit,
    required POSITION_STATUS positionStatus,
    DateRangeInput? between,
    int? limit,
    int? offset,
    // String requestedFields,
  }) async {
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

    final queryOptions =
        iGraphqlProvider.createQueryOptions(document: document, variables: {
      'input': {
        'locator': describeEnum(locator),
        'locatorKeys': locatorKeys,
        'symbols': symbols,
        'positionTypes': positionTypes?.map((pt) => describeEnum(pt!)).toList(),
        'optionTypes': optionTypes?.map((ot) => describeEnum(ot!)).toList(),
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
    });
    try {
      final res = await iGraphqlProvider
          .queryWithOptions(queryOptions)
          .catchError((e) {});
      final data = res?.data;
      if (data == null) {
        return <TradeAnalysis>[];
      }

      final tradeAnalysisData = data['tradeAnalysisGet']['tradeAnalysis'];
      return List<TradeAnalysis>.from(
          tradeAnalysisData.map((i) => TradeAnalysis.fromJson(i)));
    } catch (err) {
      debugPrint(err.toString());
      return <TradeAnalysis>[];
    }
  }
}
