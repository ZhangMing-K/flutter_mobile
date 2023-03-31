import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class FlagService extends GetxService {
  IGraphqlProvider iGraphqlProvider = Get.find();

  String entityField({required FLAG_ENTITY_TYPE flagEntityType}) {
    switch (flagEntityType) {
      case FLAG_ENTITY_TYPE.TEXT:
        return '''
          text {
            value
            textKey
            parentKey
            textType
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
        ''';

      case FLAG_ENTITY_TYPE.PORTFOLIO:
        return '''
          portfolio {
            brokerName
            portfolioKey
            accountId
            connectionStatus
          }
        ''';

      case FLAG_ENTITY_TYPE.USER:
        return '''
          user {
            userKey
            firstName
            lastName
            suspendedAt
          }
        ''';
    }
  }

  Future flagCreate(
      {required FLAG_ENTITY_TYPE flagEntityType,
      int? flagEntityKey,
      required FLAG_REASON_TYPE flagReasonType,
      String? reason}) async {
    var document = r'''
    mutation flagCreate($input: FlagCreateInput) {
      flagCreate(input:$input){
        flag {
          flagKey
    ''';
    document += entityField(flagEntityType: flagEntityType);
    document += '}}}';
    final Map<String, dynamic> input = {
      'flagEntityKey': flagEntityKey,
      'flagEntityType': describeEnum(flagEntityType),
      'flagType': describeEnum(flagReasonType),
      'reason': reason
    };
    final options = iGraphqlProvider
        .createMutationOptions(document: document, variables: {'input': input});
    try {
      final res = await iGraphqlProvider.mutateWithOptions(options);
      final flagData = res.data!['flagCreate']['flag'];
      final flag = Flag.fromJson(flagData);
      return flag;
    } catch (err) {
      rethrow;
    }
  }
}
