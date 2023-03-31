import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';
import 'account_portfolios_mobile.dart';

class AccountPortfoliosScreen extends StatelessWidget {
  const AccountPortfoliosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'Portfolios',
      ),
      body: AccountPortfoliosMobile(),
    );
  }

  static String routeName() {
    return '/account-portfolios';
  }
}
