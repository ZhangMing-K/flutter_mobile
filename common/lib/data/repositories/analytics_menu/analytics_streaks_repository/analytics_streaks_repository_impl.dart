import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../../iris_common.dart';

class AnalyticsStreaksRepository implements IAnalyticsStreaksRepository {
  AnalyticsStreaksRepository({
    required this.remoteProvider,
    required this.repository,
  });
  final IGraphqlProvider remoteProvider;
  final BaseRepository repository;
  String assetRunFields = '''
      assetRuns{
        run
        maxRun
        previousMaxRun
        support
        runType
        flipProbability
        didFlip
        roi1Yp
        roi01f
        date
        marketCap
        asset{
          assetKey
          symbol
          pictureUrl
          name
          quote{
            changePercent
          }
        }
      }
    ''';

  @override
  Future<void> getAssetMaxRun({
    int? limit = 6,
    int? offset = 0,
    String? date,
    double? minMarketCap,
    double? maxMarketCap,
    QueryType queryType = QueryType.loadCache,
    RUN_YEAR_DIRECTION runYearDirection = RUN_YEAR_DIRECTION.AGAINST_RUN,
    RUN_METHOD runMethod = RUN_METHOD.OVERALL,
    required Function(List<AssetMaxRunData> data) callback,
    required Function(OperationException error) onError,
  }) async {
    String runTypeNegative = describeEnum(RUN_TYPE.NEGATIVE);
    String runTypePositive = describeEnum(RUN_TYPE.POSITIVE);
    String runYearDirectionInput = '''
  ''';
    if (runYearDirection != RUN_YEAR_DIRECTION.NONE) {
      runYearDirectionInput = '''
      runYearDirection: ${describeEnum(runYearDirection)}
    ''';
    }
    String minMarketCapInput = '''
    ''';
    if (minMarketCap != null) {
      minMarketCapInput = '''
      minMarketCap: $minMarketCap
      ''';
    }
    String maxMarketCapInput = '''
    ''';
    if (maxMarketCap != null) {
      maxMarketCapInput = '''
      maxMarketCap: $maxMarketCap
      ''';
    }
    var document = '''
      query {
        negative: assetMaxRun(input: {
          limit: $limit,
          offset: $offset,
          date: "$date",
          runType: $runTypeNegative,
          runMethod: ${describeEnum(runMethod)},
          $runYearDirectionInput,
          $minMarketCapInput,
          $maxMarketCapInput
        }) {
          $assetRunFields
        }
        positive: assetMaxRun(input: {
          limit: $limit,
          offset: $offset,
          date: "$date",
          runType: $runTypePositive,
          runMethod: ${describeEnum(runMethod)},
          $runYearDirectionInput,
          $minMarketCapInput,
          $maxMarketCapInput
        }) {
          $assetRunFields
        }
      }
    ''';
    final String queryId = CacheType.analyticsAssetMaxRuns +
        date! +
        minMarketCap.toString() +
        maxMarketCap.toString() +
        describeEnum(runYearDirection) +
        describeEnum(runMethod);
    return repository.query(
      type: CacheType.analyticsAssetMaxRuns,
      id: queryId,
      document: document,
      queryType: queryType,
      callback: (data) {
        AssetMaxRunFilterFields filter = AssetMaxRunFilterFields(
            date: date,
            maxMarketCap: maxMarketCap,
            minMarketCap: minMarketCap,
            runYearDirection: runYearDirection,
            runMethod: runMethod);
        if (data == null) {
          return callback(<AssetMaxRunData>[]);
        }
        final List<AssetRun> positiveAssetList = data['positive'] == null
            ? <AssetRun>[]
            : List<AssetRun>.from(
                data['positive']['assetRuns'].map((i) => AssetRun.fromJson(i)));
        final AssetMaxRunData positiveStreaks = AssetMaxRunData(
            filter: filter, type: RUN_TYPE.POSITIVE, list: positiveAssetList);
        final List<AssetRun> negativeAssetList = data['negative'] == null
            ? <AssetRun>[]
            : List<AssetRun>.from(
                data['negative']['assetRuns'].map((i) => AssetRun.fromJson(i)));
        final AssetMaxRunData negativeStreaks = AssetMaxRunData(
            filter: filter, type: RUN_TYPE.NEGATIVE, list: negativeAssetList);
        callback([positiveStreaks, negativeStreaks]);
      },
      onError: onError,
    );
  }
}
