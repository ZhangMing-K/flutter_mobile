import 'package:graphql/client.dart';

import '../../../../iris_common.dart';

abstract class IAnalyticsStreaksRepository {
  Future<void> getAssetMaxRun({
    int? limit,
    int? offset,
    String? date,
    RUN_YEAR_DIRECTION runYearDirection = RUN_YEAR_DIRECTION.AGAINST_RUN,
    RUN_METHOD runMethod = RUN_METHOD.OVERALL,
    QueryType queryType = QueryType.loadCache,
    double? minMarketCap,
    double? maxMarketCap,
    required Function(List<AssetMaxRunData> data) callback,
    required Function(OperationException error) onError,
  });
}

class AssetMaxRunData<T> {
  final List<AssetRun>? list;
  final AssetMaxRunFilterFields filter;
  final RUN_TYPE type;
  const AssetMaxRunData(
      {required this.list, required this.type, required this.filter});
}

class AssetMaxRunFilterFields {
  final String? date;
  final double? minMarketCap;
  final double? maxMarketCap;
  final RUN_YEAR_DIRECTION runYearDirection;
  final RUN_METHOD runMethod;
  AssetMaxRunFilterFields(
      {required this.date,
      required this.minMarketCap,
      required this.maxMarketCap,
      required this.runYearDirection,
      required this.runMethod});
}
