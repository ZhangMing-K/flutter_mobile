import 'package:graphql/client.dart';

import '../../../iris_common.dart';

abstract class ITagAnalysisRepository {
  Future<void> getTopMentions({
    TAG_ANALYSIS_ORDER_BY? orderBy,
    DateRangeInput? between,
    HISTORICAL_SPAN? assetSpan,
    int? limit,
    int? offset,
    QueryType queryType = QueryType.loadCache,
    required Function(List<TagAnalysis> data) callback,
    required Function(OperationException error) onError,
  });

  Repository<List<TagAnalysis>> tagAnalysisGet({
    TAG_ANALYSIS_ORDER_BY? orderBy,
    DateRangeInput? between,
    HISTORICAL_SPAN? assetSpan,
    int? limit,
    int? offset,
  });
}
