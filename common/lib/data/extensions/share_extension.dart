import '../../iris_common.dart';

extension ShareExt on Share {
  String get imageUrl {
    // final username = sharedByUser?.username;
    final String url = ENV.IRIS_WEB_URL!;

    return url + '/api/image/$uri.png';
  }

  String get url {
    final username = sharedByUser?.username;
    final String url = ENV.IRIS_WEB_URL!;

    return url + '/$username/share/$uri';
  }
}
