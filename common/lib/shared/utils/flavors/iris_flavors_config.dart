// import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class IrisFlavorConfig {
  static const flavor = String.fromEnvironment('flavor', defaultValue: 'dev');
  static Future<void> init() async {
    // try {
    //   await const MethodChannel('flavor').invokeMethod<String>('getFlavor');
    // } catch (err) {
    //   debugPrint(err);
    // }

    debugPrint('*********** Current flavor is: $flavor ************');
    if (flavor == 'local') {
      await dotenv.load(fileName: './env/local.env');
    } else if (flavor == 'dev') {
      await dotenv.load(fileName: './env/dev.env');
    } else if (flavor == 'prod') {
      await dotenv.load(fileName: './env/prod.env');
    } else if (flavor == 'localWindows') {
      await dotenv.load(fileName: './env/local.android.env');
    } else {
      await dotenv.load(fileName: './env/dev.env');
      debugPrint('flavor not known, callback DEV');
    }
  }
}
