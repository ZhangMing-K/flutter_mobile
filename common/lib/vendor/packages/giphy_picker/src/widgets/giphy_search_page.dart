import 'package:flutter/material.dart';

import '../../src/widgets/giphy_search_view.dart';
import 'giphy_context.dart';

class GiphySearchPage extends StatelessWidget {
  final Widget? title;

  const GiphySearchPage({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final giphyDecorator = GiphyContext.of(context).decorator;
      return Theme(
        data: giphyDecorator.giphyTheme ?? Theme.of(context),
        child: Scaffold(
          appBar: giphyDecorator.showAppBar ? AppBar(title: title) : null,
          body: SafeArea(
            bottom: false,
            child: GiphySearchView(),
          ),
        ),
      );
    });
  }
}
