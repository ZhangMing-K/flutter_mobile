import 'package:flutter/material.dart';
import 'views/login_with_phone.dart';

export 'bindings/login_binding.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginWithPhone();
  }
}
