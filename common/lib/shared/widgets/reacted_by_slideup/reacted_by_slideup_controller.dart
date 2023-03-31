import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class ReactedBySlideupController extends GetxController {
  ReactedBySlideupController({required this.text$}) {
    reactions.assignAll(text$.value!.reactions!);
  }

  BaseController baseController = Get.find();
  final Rx<TextModel?> text$;
  final TextService textService = Get.find();
  RxList<Reaction> reactions = <Reaction>[].obs;

  int offset = 0;

  String requestedFields(int reactionOffset) {
    return '''
          reactions(input: {limit:10, offset: $reactionOffset }){
            user{
              userKey
              firstName
              lastName
              profilePictureUrl
              verifiedAt
              verifiedText
              firstOrderAt
              authUserFollowInfo{
                followStatus
              }
              badgeType
              avatar {
                avatarKey
                avatarName
                code
                url
              }
            }
          }
  ''';
  }

  updateReactions(List<Reaction> newReactions) {
    text$.value = text$.value!.copyWith(reactions: newReactions);
  }

  getReactions() async {
    final texts = await textService.textGet(
      requestedFields: requestedFields(offset),
      textKey: text$.value!.textKey,
    );

    if (texts == null || texts.isEmpty) {
      return;
    }

    if (texts[0].reactions!.isNotEmpty) {
      if (offset == 0) {
        reactions.assignAll(texts[0].reactions!);
      } else {
        reactions.addAll(texts[0].reactions!);
      }
      offset += 10;
    }
  }
}
