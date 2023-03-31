import 'package:flutter/foundation.dart';

import '../../iris_common.dart';

const socialsToInclude = [SOCIAL_SOURCE.TWITTER, SOCIAL_SOURCE.DISCORD];

List<String> getSocialsInput() {
  return socialsToInclude.map((e) => describeEnum(e)).toList();
}

// enum SOCIAL_SOURCE {
//   FACEBOOK,
//   GOOGLE,
//   LINKEDIN,
//   APPLE,
//   TWITTER,
//   DISCORD,
//   SLACK,
// }
