import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart' hide Share, File;
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unicons/unicons.dart';

class ExportableTextCard extends StatelessWidget {
  const ExportableTextCard({Key? key, required this.text}) : super(key: key);

  final TextModel text;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: IrisTheme.light(),
      child: Material(
        color: Colors.white,
        child: MediaQuery(
          data: const MediaQueryData(),
          child: AspectRatio(
            aspectRatio: 1,
            child: Column(
              children: [
                const Spacer(),
                TextCard(
                  text: text.obs,
                  isShareable: false,
                  textCardDisplayType: TEXT_CARD_DISPLAY_TYPE.IMAGE_SHARE,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShareTextAsImageButton extends StatefulWidget {
  const ShareTextAsImageButton({
    Key? key,
    required this.text,
  }) : super(key: key);
  final TextModel? text;

  @override
  State<ShareTextAsImageButton> createState() => _ShareTextAsImageButtonState();
}

class _ShareTextAsImageButtonState extends State<ShareTextAsImageButton> {
  final ScreenshotController screenshotController = ScreenshotController();
  bool loading = false;
  final Completer<String> _imageCompleter = Completer();
  File? tempFile;

  @override
  void initState() {
    /// Start the image generation process as soon as the button is shown.
    /// Depending on how fast the user is to click the button this will greatly reduce or eliminate the loading time when the button is clicked.
    _imageCompleter.future;
    Future(startImageGeneration);
    super.initState();
  }

  void startImageGeneration() {
    generateTempFile().then((filePath) {
      if (filePath != null) {
        _imageCompleter.complete(filePath);
      } else {
        _imageCompleter.completeError('Failed to generate shareable image');
      }
    });
  }

  Future<String?> generateTempFile() async {
    if (widget.text == null) {
      return null;
    }
    String? filePath;
    Uint8List imageInUnit8List = await screenshotController
        .captureFromWidget(ExportableTextCard(text: widget.text!));
    Directory tempDir = await getTemporaryDirectory();
    filePath = '${tempDir.path}/${widget.text!.textKey}.png';
    File file = await File(filePath).create();
    file.writeAsBytesSync(imageInUnit8List);
    if (mounted) {
      setState(() {
        tempFile = file;
      });
    }

    return filePath;
  }

  void shareAsImage(TextModel? text) async {
    setState(() {
      loading = true;
    });
    try {
      String filePath = await _imageCompleter.future;
      Share.shareFiles([filePath]);
    } catch (e) {
      print('error happened while generating image $e');
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.text == null) {
      return Container();
    }
    return IrisElevatedIconButton(
      icon: loading
          ? const IrisLoading(size: kIconSize)
          : Icon(
              UniconsLine.upload,
              size: kIconSize,
              color: context.theme.colorScheme.secondary.withOpacity(.8),
            ),
      buttonSize: const Size.square(64),
      onPressed: () => loading ? null : shareAsImage(widget.text),
      label: 'Share Via',
    );
  }
}
