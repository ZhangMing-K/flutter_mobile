import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:iris_common/iris_common.dart';

class ContactInfo extends ISuspensionBean {
  String? tagIndex;
  User? user;

  ContactInfo({
    this.user,
    this.tagIndex,
  });

  ContactInfo.setUser(User newUser) : user = newUser;

  @override
  String getSuspensionTag() => tagIndex!;

  String getFullName() => user!.fullName;

  @override
  String toString() => json.encode(user);
}
