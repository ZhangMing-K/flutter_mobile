import '../text/text.dart';

String storyGql({int limit = 5, String cursor = ''}) {
  final String cursorToApply = '"$cursor"';
  String cursorString = '''
  ''';
  if (cursor != '') {
    cursorString = '''
      cursor: $cursorToApply
    ''';
  }
  return '''
      storiesConnection(input: {limit: $limit, $cursorString}){
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

''';
}

class StoryGql {
  static const storyLimit1 = '''
  storiesConnection(input: {limit: 1}){
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
  ''';
}
