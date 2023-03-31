import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class PieChartNotifier extends GetNotifier<PositionTypeSummaryGetResponse> {
  PieChartNotifier({
    required this.repository,
    required this.profileKey,
  }) : super(const PositionTypeSummaryGetResponse());
  final IProfileRepository repository;
  final int profileKey;

  void start() {
    fetchPieChart(null);
  }

  Future<void> fetchPieChart(int? portfolioKey) async {
    change(state, status: RxStatus.loading());
    await repository.positionTypeSummaryGet(
      queryType: QueryType.loadMore,
      input: PositionTypeSummaryGetInput(
        userKey: profileKey,
        portfolioKey: portfolioKey,
      ),
      callback: (data) {
        change(data, status: RxStatus.success());
      },
      onError: (data) {
        change(state, status: RxStatus.error(data.toString()));
      },
    );
  }
}
