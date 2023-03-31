import 'package:iris_common/iris_common.dart';

String getUserStoryGql({int limit = 5}) {
  return '''
  user{
    userKey
    storiesConnection(input: {limit: $limit}){
      storiesPagination{
        stories{
          ${TextGql.fullTextWithOutStories}
        }
        nextCursor
        previousCursor
      }
      metaData{
        nbrStories
        currentIndex
        areStories
        areUnseenStories
      }
    }
  }

''';
}
