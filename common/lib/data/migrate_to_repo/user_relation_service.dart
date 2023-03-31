import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class UserRelationSerivce extends GetxService {
  IGraphqlProvider iGraphqlProvider = Get.find();

  UserRelationSerivce();

  Future userRelationsUpdate(
      {required USER_RELATION_ENTITY_TYPE entityType,
      required List<int?> entityKeys,
      bool? mute,
      bool? watch,
      bool? block,
      bool? hide,
      bool? seen,
      DateTime? savedAt,
      RELATION_LOCATION? relationLocation}) async {
    const document = r'''
      mutation userRelationsUpdate($input:UserRelationsUpdateInput!){
          userRelationsUpdate(input:$input){
            userRelations {
              userRelationKey
              mutedAt
              hideAt
              relationLocation
              seenAt
              savedAt
              blockedAt
            }
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'entityType': describeEnum(entityType),
      'entityKeys': [...entityKeys],
    };

    if (mute != null) {
      input['mute'] = mute;
    }

    if (watch != null) {
      input['watch'] = watch;
    }

    if (block != null) {
      input['block'] = block;
    }

    if (hide != null) {
      input['hide'] = hide;
    }

    if (seen != null) {
      input['seen'] = seen;
    }

    if (savedAt != null) {
      input['savedAt'] = savedAt;
    }

    if (relationLocation != null) {
      input['relationLocation'] = describeEnum(relationLocation);
    }

    final mutationOptions = iGraphqlProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );
    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);

      final relationData = res.data!['userRelationsUpdate']['userRelations'][0];
      return UserRelation.fromJson(relationData);
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }
}
