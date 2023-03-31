import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:iris_common/iris_common.dart';

import '../../shared/widgets/post_input/post_input_controller.dart';

class TextController extends GetxController with StateMixin<List<TextModel>> {
  FocusNode focusNode = FocusNode();

  late final postInput = PostInputController(
    textType: TEXT_TYPE.COMMENT,
    focusNode: focusNode,
    createTextType: CreateTextType(
      textType: TEXT_TYPE.COMMENT,
      parentKey: textKey,
    ),
    onSubmit: createComment,
  );

  int? textKey;
  RxBool notAvailable$ = false.obs;
  RxString notAvailableText$ = ''.obs;

  late final Rx<TextModel?>? text$;
  RxBool isComment$ = false.obs;
  Rx<API_STATUS?> apiStatus$ = Rx(null);

  final IAuthUserService authUserStore = Get.find();
  final IFeedRepository repository = Get.find();
  final IrisEvent irisEvent = Get.find();
  Timer? attentionTimer;
  Timer? longAttentionTimer;
  RxString title$ = 'Post'.obs;

  ScrollController scrollController = ScrollController();

  String get titleText {
    if (text$!.value?.textType == TEXT_TYPE.ORDER) {
      return 'Order';
    }
    return 'Post';
  }

  Future<void> createComment(PostInputInfo info) async {
    final String value = info.textEditingController!.text;
    info.textEditingController!.text = '';

    if (info.mediaList.isEmpty && value.isEmpty) {
      return;
    }

    try {
      await createText(value, info);
      // updateList();

    } catch (err) {
      rethrow;
      // Get.back();
    }
  }

  createText(String value, PostInputInfo info) async {
    final int? parentKey = info.createTextType!.parentKey;

    final TextModel text = text$!.value!;

    final TextModel textCreateEvent = TextModel(
        textCreateId: DateTime.now()
            .millisecondsSinceEpoch, //This is so we can locate it later
        value: value,
        textType: info.createTextType!.textType,
        parentKey: parentKey,

        //TODO: Create authUser object on UserController and remove Store depencency of this controller
        user: authUserStore.loggedUser,
        orderedCreatedAt: DateTime.now());

    text$!.value =
        text.copyWith(comments: [...text.comments ?? [], textCreateEvent]);

    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);

    Giff? giff;
    List<http.MultipartFile>? fileUploads;

    if (info.mediaList.isNotEmpty) {
      final AppMedia appMedia = info.mediaList[0];
      info.mediaList.clear();
      if (appMedia.appMediaType == APP_MEDIA_TYPE.GIFF) {
        giff = Giff(
            giffSource: GIFF_SOURCE.GIPHY,
            remoteId: appMedia.giffId,
            url: appMedia.url);
      }
      if (appMedia.appMediaType == APP_MEDIA_TYPE.PHOTO) {
        final http.MultipartFile multiPartFile = http.MultipartFile.fromBytes(
          'photo',
          appMedia.bytes!,
          filename: '${DateTime.now().second}.jpg',
          contentType: MediaType('image', 'jpg'),
        );
        fileUploads = [multiPartFile];
      }
      if (appMedia.appMediaType == APP_MEDIA_TYPE.VIDEO) {
        final http.MultipartFile multiPartFile = http.MultipartFile.fromBytes(
          'video',
          appMedia.bytes!,
          filename: '${DateTime.now().second}.mp4',
          contentType: MediaType('video', 'mp4'),
        );
        fileUploads = [multiPartFile];
      }
    }

    TextModel? newText;
    try {
      if (fileUploads != null) {
        newText = await overlayLoader(
            context: Get.overlayContext!,
            asyncFunction: () async {
              return repository.postCreate(
                  giff: giff,
                  value: value,
                  parentKey: parentKey,
                  fileUploads: fileUploads,
                  textType: info.createTextType!.textType,
                  collectionKey: info.createTextType!.collectionKey);
            });
      } else {
        newText = await repository.postCreate(
            giff: giff,
            value: value,
            parentKey: parentKey,
            fileUploads: fileUploads,
            textType: info.createTextType!.textType,
            collectionKey: info.createTextType!.collectionKey);
      }
      // if (Get.isBottomSheetOpen) {
      //   Get.back();
      // }

      if (newText == null) {
        debugPrint('ERROR NEW TEXT IS NULL');
        return;
      }

      final comments = text.comments ?? [];
      final List<TextModel> newComments = [];
      for (var element in comments) {
        if (element.textCreateId == textCreateEvent.textCreateId) {
          newComments.add(textCreateEvent);
        } else {
          newComments.add(element);
        }
      }

      text$!.value = text.copyWith(comments: [...newComments, newText]);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> commentsGet() async {
    if (text$?.value?.textKey == null) return;
    repository.getComments(
      CommentsGetInput(
        parentKey: text$!.value!.textKey,
        limit: 10,
        offset: 0,
      ),
      callback: (data) {
        final text = text$!.value;
        final newText = data.comments;

        if (newText == null) {
          return;
        }
        text$!.value = text!.copyWith(comments: [...newText]);
      },
      onError: onError,
    );
  }

  Future<void> getFullpage() async {
    await repository.getFullPage(
        textKey: textKey!,
        callback: onSuccess,
        onError: onError,
        queryType: QueryType.loadRemote);
    if (notAvailable$.isFalse) {
      await commentsGet();
    }
  }

  Future<void> getText() async {
    await getFullpage();
    irisEvent.registerTextEvent(
        textKey: textKey!, textEventType: TEXT_EVENT_ACTION.CLICK);
    registerAttention(textKey!);
    registerLongAttention(textKey!);
  }

  @override
  void onClose() {
    attentionTimer?.cancel();
    longAttentionTimer?.cancel();
  }

  void onError(OperationException err) {
    debugPrint(err.toString());
    notAvailable$.value = true;
    if (err.graphqlErrors.isNotEmpty) {
      final GraphQLError error = err.graphqlErrors.first;
      if (error.message.contains('deleted')) {
        notAvailableText$.value = 'This post has been removed by the owner';
        return;
      }
    }

    notAvailableText$.value = 'This post is not available';
  }

  @override
  void onInit() {
    final params = Get.parameters['textKey'];
    final args = Get.arguments;

    if (params != null && params != '') {
      textKey = int.tryParse(params);
    }

    if (args is TextScreenArgs) {
      text$ = args.text!;
      isComment$.value = args.isComment!;
      change([], status: RxStatus.success());
    } else {
      text$ = Rx<TextModel?>(null);
    }

    getText();
    super.onInit();
  }

  void onSuccess(List<TextModel> data) {
    notAvailable$.value = false;
    rebuildOnChange(data);
  }

  /// This method checks if the value of the added data is different from the value of the current state.
  /// It serves functions that do not use [getResponse] from a [Repository], but only data from the local cache,
  /// or just from the internet.
  void rebuildOnChange(List<TextModel> data) {
    text$!.value = data.isNotEmpty ? data[0] : null;
    change(data, status: RxStatus.success());
  }

  void registerAttention(int textKey) {
    attentionTimer = Timer(const Duration(seconds: 5), () {
      irisEvent.registerTextEvent(
          textKey: textKey, textEventType: TEXT_EVENT_ACTION.ATTENTION);
    });
  }

  void registerLongAttention(int textKey) {
    longAttentionTimer = Timer(const Duration(seconds: 20), () {
      irisEvent.registerTextEvent(
          textKey: textKey, textEventType: TEXT_EVENT_ACTION.LONG_ATTENTION);
    });
  }
}
