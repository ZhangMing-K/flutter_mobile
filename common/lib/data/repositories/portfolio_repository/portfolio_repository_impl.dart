import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class PortfolioRepository implements IPortfolioRepository {
  final IGraphqlProvider remoteProvider;
  PortfolioRepository({
    required this.remoteProvider,
  });

  @override
  Repository<Portfolio?> getPortfolio({
    required int? portfolioKey,
    required String document,
    List<String>? fragments,
  }) {
    final dataFromRemote = Future<Portfolio?>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          document: document,
          variables: {
            'input': {
              'portfolioKeys': [portfolioKey],
            },
          },
          fragments: fragments,
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return null;
      }
      final portfolioData = data['portfoliosGet']['portfolios'][0];
      Portfolio? portfolio = Portfolio.fromJson(portfolioData);
      if (res?.hasException ?? false) {
        if (res!.exception!.graphqlErrors[0].message.contains('Unauthorized')) {
          portfolio = portfolio.copyWith(
              connectionStatus: CONNECTION_STATUS.DISCONNECTED);
        }
      }
      return portfolio;
    });

    final dataFromLocal = Future<Portfolio?>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        document: document,
        variables: {
          'input': {
            'portfolioKeys': [portfolioKey],
          },
        },
        fragments: fragments,
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);
      if (res == null ||
          res.data == null ||
          res.data!['portfoliosGet'] == null) {
        return null;
      }
      final portfolioData = res.data!['portfoliosGet']['portfolios'][0];
      Portfolio? portfolio = Portfolio.fromJson(portfolioData);
      if (res.hasException) {
        if (res.exception!.graphqlErrors[0].message.contains('Unauthorized')) {
          portfolio = portfolio.copyWith(
              connectionStatus: CONNECTION_STATUS.DISCONNECTED);
        }
      }
      return portfolio;
    });

    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }
}
