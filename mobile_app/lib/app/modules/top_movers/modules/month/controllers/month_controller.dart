import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

typedef TestPredicate<E> = bool Function(E element);

class MonthController extends GetxController with StateMixin<List<Portfolio?>> {
  final ITopMoversRepository repository;
  final scrollController = ScrollController();

  final listviewController = GlobalKey<IrisListViewState>();
  int offset = 0;

  Rx<Portfolio?> portfolio$ = Rx<Portfolio?>(null);
  MonthController({required this.repository});

  Repository<Leaderboard?> getTopMovers() {
    return repository.getTopMovers(
        limit: 10, mostRecent: true, span: HISTORICAL_SPAN.MONTH);
  }

  Future<void> loadMore() async {
    final data = await getTopMovers().remote;
    if (data != null) {
      offset += 10;
      final List<Portfolio?> newData = data.instances!
          .map((item) => item.portfolio!.copyWith(
                snapshot: item.snapshot,
                user: item.user,
                // rankNumber: item.rankNumber,
              ))
          .toList();
      change(state!..addAll(newData), status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    getTopMovers().getResponse((leaderboard) {
      if (leaderboard != null) {
        offset += 10;
        final List<Portfolio?> data = leaderboard.instances!
            .map((item) => item.portfolio!.copyWith(
                  snapshot: item.snapshot,
                  user: item.user,
                  // rankNumber: item.rankNumber,
                ))
            .toList();
        rebuildOnChange(data);
      }
    });
    super.onInit();
  }

  Future<void> pullRefresh() async {
    offset = 0;
    final data = await getTopMovers().remote;
    if (data != null) {
      offset += 10;
      final List<Portfolio?> newData = data.instances!
          .map((item) => item.portfolio!.copyWith(
                snapshot: item.snapshot,
                user: item.user,
                // rankNumber: item.rankNumber,
              ))
          .toList();
      rebuildOnChange(newData);
    }
  }

  void rebuildOnChange(List<Portfolio?> data) {
    change(data, status: RxStatus.success());
  }

  refreshEntities(
      {FOLLOW_STATUS? followStatus,
      FOLLOW_REQUEST_ENTITY_TYPE? entityType,
      int? entityKey}) {
    if (entityType == FOLLOW_REQUEST_ENTITY_TYPE.PORTFOLIO &&
        entityKey != null) {}
  }
}

extension Rep<E> on List<E> {
  bool replaceWhere(TestPredicate<E> test, E replacement) {
    var found = false;
    final len = length;
    for (var i = 0; i < len; i++) {
      if (test(this[i])) {
        this[i] = replacement;
        found = true;
      }
    }
    return found;
  }
}
