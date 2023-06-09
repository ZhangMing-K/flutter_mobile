library giphy_picker;

import 'dart:async';

import 'package:flutter/material.dart';

import 'src/model/giphy_client.dart';
import 'src/model/giphy_decorator.dart';
import 'src/model/giphy_preview_types.dart';
import 'src/widgets/giphy_context.dart';
import 'src/widgets/giphy_search_page.dart';

export 'src/model/giphy_client.dart';
export 'src/model/giphy_decorator.dart';
export 'src/model/giphy_preview_types.dart';
export 'src/widgets/giphy_image.dart';

typedef ErrorListener = void Function(dynamic error);

/// Provides Giphy picker functionality.
class GiphyPicker {
  /// Renders a full screen modal dialog for searching, and selecting a Giphy image.
  static Future<GiphyGif?> pickGif({
    required BuildContext context,
    required String apiKey,
    String rating = GiphyRating.g,
    String lang = GiphyLanguage.english,
    bool sticker = false,
    Widget? title,
    ErrorListener? onError,
    bool showPreviewPage = true,
    GiphyDecorator decorator = const GiphyDecorator(),
    bool fullScreenDialog = true,
    String searchText = 'Search GIPHY',
    GiphyPreviewType? previewType,
  }) async {
    GiphyGif? result;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => GiphyContext(
          decorator: decorator,
          previewType: previewType ?? GiphyPreviewType.previewGif,
          apiKey: apiKey,
          rating: rating,
          language: lang,
          sticker: sticker,
          onError: onError ?? (error) => _showErrorDialog(context, error),
          onSelected: (gif) {
            result = gif;
            // pop preview page if necessary
            if (showPreviewPage) {
              Navigator.pop(context);
            }
            // pop giphy_picker
            Navigator.pop(context);
          },
          showPreviewPage: showPreviewPage,
          searchText: searchText,
          child: GiphySearchPage(
            title: title,
          ),
        ),
        fullscreenDialog: fullScreenDialog,
      ),
    );

    return result;
  }

  static void _showErrorDialog(BuildContext context, dynamic error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Giphy error'),
          content: Text('An error occurred. $error'),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
