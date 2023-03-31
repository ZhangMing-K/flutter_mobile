import 'package:iris_common/iris_common.dart';

extension UserContactExt on UserContact {
  String get fullName {
    String fullName = '';

    if (firstName != null) {
      fullName += '${firstName!.trim()} ';
    }

    if (lastName != null) {
      fullName += lastName!.trim();
    }
    return fullName;
  }

  get initials {
    var nameArray = fullName.split(' ');

    // if (nameArray == null) return '';

    nameArray = nameArray.where((name) => name.isNotEmpty).toList();
    final initialsArray = nameArray.map((e) => e[0]);

    return initialsArray.join();
  }

  get profilePictureUrl {
    return 'http://via.placeholder.com/150?text=$initials';
  }
}
