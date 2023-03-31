import 'package:flutter/material.dart';

import '../../src/model/giphy_client.dart';
import '../../src/widgets/giphy_image.dart';

/// Presents a Giphy preview image.
class GiphyPreviewPage extends StatelessWidget {
  final GiphyGif gif;
  final Widget? title;
  final ValueChanged<GiphyGif>? onSelected;

  const GiphyPreviewPage(
      {Key? key, required this.gif, required this.onSelected, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(title: title, actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => onSelected?.call(gif))
        ]),
        body: SafeArea(
            bottom: false,
            child: Center(
                child: GiphyImage.original(
              gif: gif,
              width: media.orientation == Orientation.portrait
                  ? double.maxFinite
                  : null,
              height: media.orientation == Orientation.landscape
                  ? double.maxFinite
                  : null,
              fit: BoxFit.contain,
            ))));
  }
}
