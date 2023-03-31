import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/rich_text/rich_text_span_builder.dart';

enum FLAG_TYPE {
  CASHTAG,
  HASHTAG,
  AT,
  USERMENTION,
}

class FlagInfo {
  FlagInfo({this.flagType, this.flagValue});

  FLAG_TYPE? flagType;
  String? flagValue;
}

class RichTextField<T> extends StatefulWidget {
  const RichTextField(
      {this.hintText = 'reply...',
      this.hintColor,
      this.focusNode,
      required this.textEditingController,
      required this.onTyping,
      this.maxLines = 10,
      this.autofocus = false,
      this.createTextType,
      this.suffix,
      this.textInputAction = TextInputAction.newline,
      this.isFullPage = false,
      this.key});

  final String? hintText;
  final Color? hintColor;
  final CreateTextType? createTextType;
  final FocusNode? focusNode;
  final TextEditingController textEditingController;
  final Function onTyping;
  final TextInputAction textInputAction;
  final int maxLines;
  final bool autofocus;
  @override
  final GlobalKey<RichTextFieldState<T>>? key;
  final bool isFullPage;
  final Widget? suffix;

  @override
  RichTextFieldState<T> createState() => RichTextFieldState<T>();
}

class RichTextFieldState<T> extends State<RichTextField<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? listSuggestionsEntry;
  List<Widget> selectWidgets = [];
  String currentSearchVal = '';
  String prevTypingVal = '';
  int prevTypingTicker = 0;
  bool isUserTyping = false;
  int numLines = 0;
  final interval = const Duration(seconds: 3);

  clearOverlay() {
    if (listSuggestionsEntry != null) {
      listSuggestionsEntry!.remove();
      listSuggestionsEntry = null;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    currentSearchVal = '';
    super.dispose();
  }

  startTimeout([int? milliseconds]) {
    final duration = interval;
    Timer.periodic(duration, (timer) {
      if (currentSearchVal == '' || !isUserTyping) {
        timer.cancel();
        return;
      }
      final tickerDiff = timer.tick - prevTypingTicker;
      if (prevTypingVal == currentSearchVal && tickerDiff > 0) {
        // user didn't change text for 3 seconds, cancel timer
        isUserTyping = false;
        timer.cancel();
        return;
      }
      if (prevTypingVal != currentSearchVal) {
        prevTypingVal = currentSearchVal;
        prevTypingTicker = timer.tick;
      } else {
        prevTypingTicker = 1;
      }
      widget.onTyping();
    });
  }

  textValueChanged() async {
    final textValue = widget.textEditingController.value.text;
    numLines = '\n'.allMatches(textValue).length + 1;
    if (numLines > 10) numLines = 10;
    if (textValue.trim().isNotEmpty && !isUserTyping) {
      isUserTyping = true;
      widget.onTyping();
      startTimeout();
    } else if (textValue.trim().isEmpty && isUserTyping) {
      isUserTyping = false;
    }
    if (currentSearchVal != textValue) {
      currentSearchVal = textValue;
      if (textValue == '' ||
          textValue[textValue.length - 1] == ' ' ||
          textValue[textValue.length - 1] == '\n') {
        clearOverlay();
      }
      final List<String> words = textValue.split(RegExp(r'\s'));
      await searchForDropDown(words, true);
    }
  }

  var assertScrollController = ScrollController();
  RxBool isloading$ = RxBool(false);

  void updateOverlay() {
    if (listSuggestionsEntry == null) {
      final Size textFieldSize = (context.findRenderObject() as RenderBox).size;
      final width = textFieldSize.width;
      listSuggestionsEntry = OverlayEntry(builder: (context) {
        final double overlayHeight =
            selectWidgets.isNotEmpty && selectWidgets.length < 4
                ? selectWidgets.length * 63.33
                : 190;
        return selectWidgets.isNotEmpty
            ? Positioned(
                width: width,
                child: CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    // offset: Offset(0.0, -1 * (overlayHeight + 10)),
                    offset: !widget.isFullPage
                        ? Offset(0.0, -1 * (overlayHeight + 10))
                        : Offset(
                            0.0,
                            numLines < 9
                                ? 25 * numLines.toDouble()
                                : -1 * ((10 - numLines) * 25)),
                    child: Container(
                      height: overlayHeight,
                      color: Colors.transparent,
                      child: Card(
                          child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              removeBottom: true,
                              child: ScrollListView(
                                  children: selectWidgets,
                                  onBottom: () async {
                                    page++;
                                    final List<String> words =
                                        currentSearchVal.split(RegExp(r'\s'));
                                    await searchForDropDown(words, false);
                                  }))),
                    )))
            : Container();
      });
      Overlay.of(context)!.insert(listSuggestionsEntry!);
      listSuggestionsEntry!.markNeedsBuild();
    }
  }

  searchForDropDown(List<String> words, bool isFirst) async {
    if (words.isNotEmpty) {
      // final String lastWord = words[words.length - 1];
      int wordPos = 0;
      final int totalLen = words.length;
      final List<String> originWords = words;
      words.asMap().forEach((index, word) async {
        final String lastWord = word;
        wordPos += word.length;
        final String firstLetter = lastWord != '' ? lastWord[0] : lastWord;
        final FlagInfo flagInfo = FlagInfo();
        final int pos = widget.textEditingController.value.selection.baseOffset;

        if (firstLetter == r'@') {
          flagInfo.flagType = FLAG_TYPE.USERMENTION;
          final List<String> words = lastWord.split(r'@');
          flagInfo.flagValue = words[words.length - 1];
          for (int i = 0; i < index; i++) {
            wordPos += 1;
          }
          final int tagPos = wordPos - word.length;
          if (totalLen > index) {
            if (tagPos < pos && pos <= wordPos) {
              await onFlag(flagInfo, isFirst, false);
            }
          }
          if (totalLen > index + 1) {
            if (originWords[index + 1] == '' && wordPos + 1 == pos) {
              // we allow only 1 space in user mention
              final String flagVal = words[words.length - 1];
              flagInfo.flagValue = flagVal;
              await onFlag(flagInfo, isFirst, true);
            }
            if (originWords[index + 1].isNotEmpty &&
                wordPos + originWords[index + 1].length + 1 == pos) {
              // we allow only 1 space in user mention
              final String flagVal =
                  words[words.length - 1] + ' ' + originWords[index + 1];
              flagInfo.flagValue = flagVal;
              await onFlag(flagInfo, isFirst, true);
            } else if (totalLen > index + 2 &&
                wordPos + originWords[index + 1].length + 1 < pos) {
              clearOverlay();
            }
          }
        }
        if (firstLetter == r'$') {
          flagInfo.flagType = FLAG_TYPE.CASHTAG;
          final List<String> words = lastWord.split(r'$');
          flagInfo.flagValue = words[words.length - 1];
          for (int i = 0; i < index; i++) {
            wordPos += 1;
          }
          final int tagPos = wordPos - word.length;
          if (totalLen > index) {
            if (tagPos < pos && pos <= wordPos) {
              await onFlag(flagInfo, isFirst, false);
            }
          }
          if (totalLen > index + 1) {
            if (originWords[index + 1] == '' && wordPos + 1 == pos) {
              // we don't allow space in cash tag
              clearOverlay();
            }
            if (originWords[index + 1].isNotEmpty &&
                wordPos + originWords[index + 1].length + 1 == pos) {
              // we don't allow space in cash tag
              clearOverlay();
            } else if (totalLen > index + 2 &&
                wordPos + originWords[index + 1].length + 1 < pos) {
              clearOverlay();
            }
          }
        }
      });
    }
  }

  onFlag(FlagInfo flagInfo, bool isFirst, bool allowSpace) async {
    await getItems(flagInfo, isFirst, allowSpace);
  }

  AssetService assetService = Get.find();
  SearchService searchService = Get.find();
  int itemLen = 0;
  int page = 0;
  int pageLimit = 10;

  selectAutoCompleteItem({required String text, bool allowSpace = false}) {
    final String oldText = widget.textEditingController.text;
    final int oldPosition = widget.textEditingController.selection.start;
    if (oldPosition == oldText.length) {
      // cash tag at the end of the text
      final List<String> allWords =
          widget.textEditingController.text.split(RegExp(r'\s'));
      String lastWord = allWords[allWords.length - 1];
      if (allowSpace && allWords.length > 1) {
        lastWord =
            allWords[allWords.length - 2] + ' ' + allWords[allWords.length - 1];
      }
      final int newLen = oldText.length - lastWord.length;
      final String newText = oldText.substring(0, newLen) + text + ' ';
      widget.textEditingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection(
              baseOffset: newText.length, extentOffset: newText.length));
    } else {
      // cash tag in the middle of the text
      final List<String> prevAllWords =
          oldText.substring(0, oldPosition).split(RegExp(r'\s'));
      String lastWord = prevAllWords[prevAllWords.length - 1];
      if (allowSpace && prevAllWords.length > 1) {
        lastWord = prevAllWords[prevAllWords.length - 2] +
            ' ' +
            prevAllWords[prevAllWords.length - 1];
      }
      final int newLen =
          oldText.substring(0, oldPosition).length - lastWord.length;
      final String newText = oldText.substring(0, newLen) +
          text +
          oldText.substring(oldPosition, oldText.length) +
          ' ';
      widget.textEditingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection(
              baseOffset: newLen + text.length,
              extentOffset: newLen + text.length));
    }

    clearOverlay();
  }

  getItems(FlagInfo flagInfo, bool isFirst, bool allowSpace) async {
    if (flagInfo.flagType == FLAG_TYPE.CASHTAG) {
      if (isFirst) {
        page = 0;
        selectWidgets = [];
      }
      if (!isloading$.value) {
        isloading$.value = true;
        final List<Asset> assets = await assetService.assetSearch(
            offset: page * pageLimit,
            searchValue: flagInfo.flagValue,
            limit: pageLimit);

        itemLen = assets.length;
        for (var i = 0; i < assets.length; i++) {
          final Asset asset = assets[i];

          selectWidgets.add(AutoCompleteAssetRow(
            asset: asset,
            onTap: (asset, str) {
              selectAutoCompleteItem(text: str, allowSpace: false);
            },
          ));
          if (i != assets.length - 1) {
            selectWidgets.add(Container(
              height: 5,
              color: const Color(0xFF000000).withOpacity(.2),
              width: double.infinity,
            ));
          }
        }
        isloading$.value = false;
      }
    } else if (flagInfo.flagType == FLAG_TYPE.USERMENTION) {
      if (isFirst) {
        page = 0;
        selectWidgets = [];
      }
      if (!isloading$.value) {
        isloading$.value = true;
        final textType = widget.createTextType!.textType;
        CONTEXT_TYPE contextType = CONTEXT_TYPE.GENERAL;
        int? contextKey;
        if (textType == TEXT_TYPE.POST) {
          contextType = CONTEXT_TYPE.GENERAL;
        } else if (textType == TEXT_TYPE.COMMENT) {
          contextType = CONTEXT_TYPE.TEXT;
          contextKey = widget.createTextType!.parentKey!;
        } else if (textType == TEXT_TYPE.MESSAGE) {
          contextType = CONTEXT_TYPE.COLLECTION;
          contextKey = widget.createTextType!.collectionKey!;
        }
        final List<User> users = await searchService.relevantUsersSearch(
            name: flagInfo.flagValue,
            offset: page * pageLimit,
            contextKey: contextKey,
            contextType: contextType);
        itemLen = users.length;
        for (var i = 0; i < users.length; i++) {
          final User user = users[i];

          selectWidgets.add(AutoCompleteUserRow(
            user: user,
            onTap: (user, str) {
              selectAutoCompleteItem(text: str, allowSpace: allowSpace);
            },
          ));
          selectWidgets.add(Container(
            height: 5,
            color: const Color(0xFF000000).withOpacity(.2),
            width: double.infinity,
          ));
        }
        isloading$.value = false;
      }
    }
    updateOverlay();
    if (listSuggestionsEntry != null) {
      listSuggestionsEntry!.markNeedsBuild();
    }
  }

  Widget getTextField(BuildContext context) {
    final RichTextSpanBuilder spanBuilder = RichTextSpanBuilder(
        context: context, spanBuilderType: SPAN_BUILDER_TYPE.TEXT_FIELD);
    return ExtendedTextField(
      // keyboardAppearance: Brightness.dark,
      textCapitalization: TextCapitalization.sentences,
      specialTextSpanBuilder: spanBuilder,
      autofocus: widget.autofocus,
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      maxLines: widget.maxLines,
      minLines: 1,

      onChanged: (newText) async {
        await textValueChanged();
      },
      onTap: () {
        // updateOverlay(currentText);
      },
      onSubmitted: (submittedText) {},
      textInputAction: widget.textInputAction,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.suffix,
          suffixIconConstraints: const BoxConstraints(minHeight: 29),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          // disabledBorder,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300,
            color: widget.hintColor ??
                context.theme.colorScheme.secondary.withOpacity(.4),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 20)),
      style: TextStyle(
        color: context.theme.colorScheme.secondary,
        fontSize: 16.0,
        fontWeight: FontWeight.w300,
      ),
      // onChanged: (query) => updateSearchQuery(query),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
        link: _layerLink, child: getTextField(context));
  }
}
