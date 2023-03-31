import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class TagAnalysisRepository implements ITagAnalysisRepository {
  final IGraphqlProvider remoteProvider;
  final BaseRepository repository;
  TagAnalysisRepository({
    required this.remoteProvider,
    required this.repository,
  });

  @override
  Future<void> getTopMentions({
    TAG_ANALYSIS_ORDER_BY? orderBy,
    DateRangeInput? between,
    HISTORICAL_SPAN? assetSpan,
    int? limit,
    int? offset,
    QueryType queryType = QueryType.loadCache,
    required Function(List<TagAnalysis> data) callback,
    required Function(OperationException error) onError,
  }) async {
    const document =
        '''query tagAnalysisGet(\$input: TagAnalysisInput!, \$assetSpan: HISTORICAL_SPAN){
        tagAnalysisGet(input:\$input){
          tagAnalysis {
            asset{
              symbol
              assetKey
              pictureUrl
              name
              historical(input: {span:\$assetSpan}) {
                closeAmount
                returnPercentage
              }
            }
            symbol
            totalTags
            distinctUsers
          }
        }
      }
    ''';
    final inputVars = {
      'input': {
        'orderBy': orderBy != null ? describeEnum(orderBy) : null,
        'limit': limit,
        'offset': offset,
        'between': between == null
            ? null
            : {
                'start': between.start.toString(),
                'end': between.end?.toString()
              }
      },
      'assetSpan': assetSpan != null ? describeEnum(assetSpan) : null,
    };
    return repository.query(
      type: CacheType.topMentions,
      id: 'topMentions',
      document: document,
      variables: inputVars,
      queryType: queryType,
      callback: (data) {
        if (data == null) {
          return callback(<TagAnalysis>[]);
        }

        final tagAnalysisData = data['tagAnalysisGet']['tagAnalysis'];
        final List<TagAnalysis> tagAnalysis = List<TagAnalysis>.from(
            tagAnalysisData.map((i) => TagAnalysis.fromJson(i)));
        callback(tagAnalysis);
      },
      onError: onError,
    );
  }

  @override
  Repository<List<TagAnalysis>> tagAnalysisGet({
    TAG_ANALYSIS_ORDER_BY? orderBy,
    DateRangeInput? between,
    HISTORICAL_SPAN? assetSpan,
    int? limit,
    int? offset,
  }) {
    const document =
        '''query tagAnalysisGet(\$input: TagAnalysisInput!, \$assetSpan: HISTORICAL_SPAN){
        tagAnalysisGet(input:\$input){
          tagAnalysis {
            asset{
              symbol
              assetKey
              pictureUrl
              name
              historical(input: {span:\$assetSpan}) {
                closeAmount
                returnPercentage
              }
            }
            symbol
            totalTags
            distinctUsers
          }
        }
      }
    ''';
    final inputVars = {
      'input': {
        'orderBy': orderBy != null ? describeEnum(orderBy) : null,
        'limit': limit,
        'offset': offset,
        'between': between == null
            ? null
            : {
                'start': between.start.toString(),
                'end': between.end?.toString()
              }
      },
      'assetSpan': assetSpan != null ? describeEnum(assetSpan) : null,
    };

    final dataFromRemote = Future<List<TagAnalysis>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          variables: inputVars,
          document: document,
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return <TagAnalysis>[];
      }
      final tagAnalysisData = data['tagAnalysisGet']['tagAnalysis'];
      final List<TagAnalysis> tagAnalysis = List<TagAnalysis>.from(
          tagAnalysisData.map((i) => TagAnalysis.fromJson(i)));
      return tagAnalysis;
    });

    final dataFromLocal = Future<List<TagAnalysis>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        variables: inputVars,
        document: document,
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);

      final data = res?.data;
      if (data == null) {
        return <TagAnalysis>[];
      }

      final tagAnalysisData = data['tagAnalysisGet']['tagAnalysis'];
      final List<TagAnalysis> tagAnalysis = List<TagAnalysis>.from(
          tagAnalysisData.map((i) => TagAnalysis.fromJson(i)));
      return tagAnalysis;
    });
    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }
}
