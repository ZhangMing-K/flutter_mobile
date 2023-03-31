import '../../iris_common.dart';

typedef FollowActionFunction = Function({
  int? userKey,
  FOLLOW_ACTION actionType,
  int? portfolioKey,
  UserRelation? authUserRelation,
});

enum FOLLOW_ACTION { MUTE, WATCH, REMOVE }
