import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class ReactionService extends GetxService {
  IGraphqlProvider iGraphqlProvider = Get.find();

  Future<Reaction?> reactToText(
      {required REACTION_KIND reactionKind, required int? textKey}) async {
    const document = r'''
      mutation reactToText($input: ReactToTextInput){
        reactToText(input:$input){
          reaction{
            user{
              userKey
              firstName
              lastName
            }
          }
        }
      }
    ''';
    final mutationOptions =
        iGraphqlProvider.createMutationOptions(document: document, variables: {
      'input': {'reactionKind': describeEnum(reactionKind), 'textKey': textKey}
    });
    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      if (res.data!['reactToText']['reaction'] == null) {
        return null;
      }
      return Reaction.fromJson(res.data!['reactToText']['reaction']);
    } catch (e) {
      return null;
    }
  }
}
