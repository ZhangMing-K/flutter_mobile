import '../../../iris_common.dart';

abstract class ITopMoversRepository {
  Repository<Leaderboard?> getTopMovers(
      {bool? mostRecent, int? limit, HISTORICAL_SPAN? span});
}
