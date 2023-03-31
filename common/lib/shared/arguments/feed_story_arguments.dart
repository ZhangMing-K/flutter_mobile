import '../../iris_common.dart';

class FeedStoryArgs {
  final List<User>? userList;
  final int? initialPage;
  final String heroId;
  FeedStoryArgs({
    this.userList,
    this.initialPage,
    required this.heroId,
  });
}
