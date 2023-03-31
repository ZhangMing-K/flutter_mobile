import '../text/text.dart';

String profileTextsGql({
  required int offset,
  required String textType,
}) {
  return '''
texts(input:{textTypes: [$textType], limit: 10, offset: $offset, dueDiligenceOptions: {lastUpdatedDDOnly: true}}){
  ${TextGql.feed}
}
                  
    ''';
}
