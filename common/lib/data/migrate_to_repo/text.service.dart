import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;

import '../../iris_common.dart';

class TextService extends GetxService {
  final IGraphqlProvider iGraphqlProvider;

  TextService({
    required this.iGraphqlProvider,
  });

  List<TextModel?> groupOptionStrategies(List<TextModel?> texts) {
    final optionLegGroupIdList = [];
    final List<TextModel?> groupedList = [];
    for (TextModel? text in texts) {
      if (text?.order?.positionType == POSITION_TYPE.OPTION &&
          text?.order?.optionLegGroupId != null) {
        if (optionLegGroupIdList.contains(text!.order!.optionLegGroupId)) {
          continue;
        } else {
          optionLegGroupIdList.add(text.order!.optionLegGroupId);
          groupedList.add(text);
        }
      } else {
        groupedList.add(text);
      }
    }
    return groupedList;
  }

  Future<TextModel?> textCreate({required String value, int? parentKey}) async {
    const document = '''
      mutation textCreate(\$input: TextCreateInput){
        textCreate(input:\$input){
          text{
            ${TextGql.feed}
          }
        }
      }
    ''';
    final mutationOptions =
        iGraphqlProvider.createMutationOptions(document: document, variables: {
      'input': {'value': value, 'parentKey': parentKey}
    });

    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      return TextModel.fromJson(res.data!['textCreate']['text']);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<TextModel> textCreateV2({
    required TEXT_TYPE textType,
    String? value,
    int? parentKey,
    Giff? giff,
    List<http.MultipartFile>? fileUploads,
    int? collectionKey,
  }) async {
    const document = '''
      mutation textCreateV2(\$input: TextCreateV2Input!, \$fileUploads: [Upload]){
        textCreateV2(input:\$input, fileUploads: \$fileUploads){
          text{
            ${TextGql.feed}
            collection {
              collectionKey
              collectionGuardedInfo {
                encryptionCode
              }
            }
          }
        }
      }
    ''';
    final Map<String, dynamic> variables = {};
    final Map<dynamic, dynamic> input = {'textType': describeEnum(textType)};
    if (value != null) input['value'] = value;
    if (parentKey != null) input['parentKey'] = parentKey;
    if (collectionKey != null) input['collectionKey'] = collectionKey;
    if (giff != null) {
      input['giffInfo'] = {
        'giffSource': describeEnum(giff.giffSource!),
        'remoteId': giff.remoteId,
        'url': giff.url
      };
    }
    if (fileUploads != null && fileUploads.isNotEmpty) {
      variables['fileUploads'] = fileUploads;
    }
    variables['input'] = input;
    final mutationOptions = iGraphqlProvider.createMutationOptions(
        document: document,
        variables: variables,
        fetchPolicy: FetchPolicy.noCache);
    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      final TextModel text =
          TextModel.fromJson(res.data!['textCreateV2']['text']);
      return text;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<TextModel?> textDelete({int? textKey}) async {
    const document = r'''
      mutation textDelete($input: TextDeleteInput){
        textDelete(input:$input){
          text{
            textKey
          }
        }
      }
    ''';

    final mutationOptions =
        iGraphqlProvider.createMutationOptions(document: document, variables: {
      'input': {'textKey': textKey},
    });

    try {
      final res = await iGraphqlProvider
          .mutateWithOptions(mutationOptions)
          .catchError((e) {});
      final text = res.data!['textDelete']['text'];
      return TextModel.fromJson(text);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<TextModel> textEdit({
    int? textKey,
    String? value,
    Giff? giff,
    List<http.MultipartFile>? fileUploads,
    int? entityKey,
    APP_MEDIA_TYPE? entityType,
    int? collectionKey,
  }) async {
    const document = r'''
    mutation textEdit($input: TextEditInput, $fileUploads: [Upload]){
      textEdit(input: $input, fileUploads: $fileUploads){
        text{
          textKey
          value
          taggedGiffs{
            giffKey
            remoteId
            url
          }
          taggedFiles {
            fileKey
            url
            fileType
          }
        }
      }
    }
    ''';
    final Map<String, dynamic> variables = {};
    final Map<dynamic, dynamic> input = {'textKey': textKey, 'value': value};
    if (collectionKey != null) {
      input['collectionKey'] = collectionKey;
    }
    if (entityKey != null && entityType != null) {
      input['removeTextTags'] = [
        {
          'entityKey': entityKey,
          'entityType': entityType == APP_MEDIA_TYPE.GIFF ? 'GIFF' : 'FILE'
        }
      ];
    }
    if (giff != null) {
      input['giffInfo'] = {
        'giffSource': describeEnum(giff.giffSource!),
        'remoteId': giff.remoteId,
        'url': giff.url
      };
    }
    if (fileUploads != null && fileUploads.isNotEmpty) {
      variables['fileUploads'] = fileUploads;
    }
    variables['input'] = input;
    final mutationOptions = iGraphqlProvider.createMutationOptions(
        document: document, variables: variables);

    try {
      final res = await iGraphqlProvider
          .mutateWithOptions(mutationOptions)
          .catchError((e) {
        debugPrint(
            'Could not complete GraphQL request for textEdit. Error: $e');
        throw e;
      });
      final text = res.data!['textEdit']['text'];
      return TextModel.fromJson(text);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<TextModel?> textFeature(
      {required int? textKey, required bool feature}) async {
    const document = '''
      mutation textFeature(\$input: TextFeatureInput!){
        textFeature(input:\$input) {
          text{
             textKey
             featuredAt
          }
        }
      }
    ''';
    final queryOptions =
        iGraphqlProvider.createQueryOptions(document: document, variables: {
      'input': {
        'textKey': textKey,
        'feature': feature,
      },
    });

    try {
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
      final data = res?.data;

      if (data == null) {
        //Make the proper handling of errors
        return null;
      }
      if (res?.hasException ?? false) {
        debugPrint(res!.exception.toString());
      }
      final textData = data['textFeature']['text'];
      final TextModel text = TextModel.fromJson(textData);
      return text;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<TextModel>?> textGet({
    List<TEXT_TYPE>? textTypes,
    int? accountUserKey,
    int? portfolioKey,
    int? textKey,
    int? offset,
    String? requestedFields,
    TextCommentInput? textCommentInput,
  }) async {
    requestedFields ??= TextGql.feed;
    var document = '''
      query textGet(\$input: TextGetInput
    ''';

    if (textCommentInput != null) {
      document += '''
        , \$textCommentInput: TextCommentInput
        ''';
    }

    document += '''){
        textGet(input:\$input){
          texts{
            $requestedFields
          }
        }
      }
    ''';

    final List<String?>? textTypesAux =
        textTypes?.map((item) => describeEnum(item)).toList();
    // if (textTypes != null) {
    //   textTypesAux = List(textTypes.length);
    //   for (int i = 0; i < textTypes.length; i++) {
    //     textTypesAux[i] = describeEnum(textTypes[i]);
    //   }
    // }

    final queryOptions =
        iGraphqlProvider.createQueryOptions(document: document, variables: {
      'input': {
        'textTypes': textTypesAux,
        'accountUserKey': accountUserKey,
        'portfolioKey': portfolioKey,
        'textKey': textKey,
        'limit': 10,
        'offset': offset,
      },
      'textCommentInput': {
        'limit': textCommentInput?.limit,
        'offset': textCommentInput?.offset
      }
    });

    try {
      final res = await iGraphqlProvider
          .queryWithOptions(queryOptions)
          .catchError((e) {});
      if (res?.data!['textGet']['texts'] == null) {
        return [];
      }
      final textsListData = res?.data!['textGet']['texts'];
      final List<TextModel> textsList =
          List<TextModel>.from(textsListData.map((i) => TextModel.fromJson(i)));
      return textsList;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
