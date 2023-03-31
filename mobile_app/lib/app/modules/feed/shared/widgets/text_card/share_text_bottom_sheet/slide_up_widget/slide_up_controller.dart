import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SlideUpProvider with ChangeNotifier {
  bool isShow = false;

  void updateState(bool newState) {
    isShow = newState;
    notifyListeners();
  }
}

class SlideUpController {
  SlideUpController._private();

  static final SlideUpController instance = SlideUpController._private();

  factory SlideUpController() => instance;

  BuildContext? _providerContext;

  // TODO: what kind of hack does that make? BuildContext should
  // never be stored in a variable
  set providerContext(BuildContext context) {
    if (_providerContext != context) {
      _providerContext = context;
    }
  }

  void toggle() {
    if (_providerContext != null) {
      final provider = _providerContext!.read<SlideUpProvider>();
      provider.updateState(!provider.isShow);
    } else {
      debugPrint('Need init provider context');
    }
  }
}
