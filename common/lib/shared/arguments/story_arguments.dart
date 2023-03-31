import '../../iris_common.dart';

class StoryArgs {
  final User? user;
  final Asset? asset;
  final StoriesConnection storiesConnection;
  final Function? afterStories;
  final String heroTag;

  StoryArgs({
    required this.storiesConnection,
    required this.heroTag,
    this.user,
    this.asset,
    this.afterStories,
  });
}
