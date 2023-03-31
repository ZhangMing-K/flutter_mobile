import 'package:graphql/client.dart';

import '../../../iris_common.dart';

abstract class ITradeAnalysisRepository {
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
  });
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
  });
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
  });
  Repository<List<TradeAnalysis>> positionTypeAnalysisGet({
    LOCATOR? locator,
    List<int>? locatorKeys,
    List<String>? symbols,
    List<POSITION_TYPE>? positionTypes,
    required POSITION_STATUS positionStatus,
    List<OPTION_TYPE>? optionTypes,
    DateRangeInput? between,
    int? limit,
  });

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
  });
}
