import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'views/feed_mobile.dart';
import 'views/feed_web.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return kIsWeb ? const FeedWebView() : const FeedMobileView();
  }
}
