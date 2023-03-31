import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class IrisScreenshotController {
  final key = GlobalKey();
  Future<void> share({String imagePath = ''}) async {
    final context = key.currentContext;

    if (GetPlatform.isWeb || context == null) {
      return;
    }
    final pixelRatio = context.mediaQuery.devicePixelRatio;
    final boundary = context.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: pixelRatio);

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();

    if (byteData == null || pngBytes == null) {
      return;
    }

    String path = imagePath;

    if (imagePath.isEmpty) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      final fileName = DateTime.now().toIso8601String();
      path = '$directory/$fileName.png';
    }

    final imgFile = File(path);
    imgFile.writeAsBytesSync(pngBytes);

    await Share.shareFiles(
      [path],
      mimeTypes: ['image/png'],
      text: 'https://iris.finance',
    );

    //  imgFile.deleteSync();
  }
}
