import '../../../iris_common.dart';

abstract class IPortfolioRepository {
  Repository<Portfolio?> getPortfolio({
    required int? portfolioKey,
    required String document,
    List<String>? fragments,
  });
}
