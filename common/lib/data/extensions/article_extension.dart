import 'package:simple_moment/simple_moment.dart';

import '../../iris_common.dart';

extension ArticleExt on Article {
  String get dateFrom {
    if (postedAt == null) {
      return 'Unknown';
    }
    final moment = Moment.now();
    return moment.from(postedAt!);
  }
}
