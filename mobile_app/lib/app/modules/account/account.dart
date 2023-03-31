import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';
import 'account_mobile.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BasicAppBar(
        title: 'Account',
      ),
      body: AccountMobile(),
    );
  }

  static String routeName() {
    return '/account';
  }
}
