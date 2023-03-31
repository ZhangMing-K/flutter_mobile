import 'package:graphql/client.dart';

import '../../../iris_common.dart';

abstract class IIrisGoldRepository {
  Future<void> irisGoldGet({
    QueryType queryType = QueryType.loadCache,
    required Function(IrisGoldGetResponse data) callback,
    required Function(OperationException error) onError,
  });
}
