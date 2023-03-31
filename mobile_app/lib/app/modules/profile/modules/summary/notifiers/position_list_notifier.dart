import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class PositionListNotifier extends GetNotifier<PositionsSummaryGetResponse> {
  PositionListNotifier({required this.repository, required this.profileKey})
      : super(const PositionsSummaryGetResponse(
            summarizedPositions: [], totalPortfolioValue: 0));
  final IProfileRepository repository;
  final int profileKey;

  void start() {
    fetchPositionList(null);
  }

  Future<void> fetchPositionList(int? portfolioKey) async {
    change(state, status: RxStatus.loading());
    await repository.positionsSummaryGet(
      input: PositionsSummaryGetInput(
        userKey: profileKey,
        portfolioKey: portfolioKey,
        limit: 5,
      ),
      callback: (PositionsSummaryGetResponse data) {
        change(data, status: RxStatus.success());
      },
      onError: (data) {
        change(state, status: RxStatus.error(data.toString()));
      },
    );
  }
}
