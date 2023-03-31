import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class JediUserService extends GetxService {
  JediUserService();
  IGraphqlProvider iGraphqlProvider = Get.find();

  Future<User?> jediUserEdit(
      {required int? userKey, bool? verify, bool? suspend}) async {
    const document = r'''
    mutation jediUserEdit($input: JediUserEditInput!) {
      jediUserEdit(input:$input){
        user{
          firstName
          lastName
          description
          email
          profilePictureUrl
          username
          suspendedAt
          avatar {
            avatarKey
            avatarName
            code
            url
          }
        }
      }
    }    
    ''';
    final variables = {
      'input': {
        'userKey': userKey,
        'verify': verify,
        'suspend': suspend,
      }
    };
    final options = iGraphqlProvider.createMutationOptions(
        document: document, variables: variables);
    try {
      final res = await iGraphqlProvider.mutateWithOptions(options);
      final userData = res.data!['jediUserEdit']['user'];
      final user = User.fromJson(userData);
      return user;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }
}
