import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class IrisGoldRepository implements IIrisGoldRepository {
  final IGraphqlProvider remoteProvider;
  final BaseRepository repository;

  IrisGoldRepository({required this.remoteProvider, required this.repository});

  @override
  Future<void> irisGoldGet({
    QueryType queryType = QueryType.loadCache,
    required Function(IrisGoldGetResponse data) callback,
    required Function(OperationException error) onError,
  }) async {
    var document = '''
    query {
        $irisGoldGql
    }
    ''';

    return repository.query(
      type: CacheType.irisGold,
      id: CacheType.irisGold,
      document: document,
      variables: {},
      queryType: queryType,
      callback: (data) {
        return callback(
            IrisGoldGetResponse.fromJson(data?['irisGoldGet'] ?? {}));
      },
      onError: onError,
    );
  }
}
