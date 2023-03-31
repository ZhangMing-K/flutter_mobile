import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/institution/connect_institution/modules/etrade/views/etrade_add_accounts.dart';
import 'package:iris_mobile/app/modules/institution/connect_institution/modules/etrade/views/etrade_header.dart';

import 'controllers/etrade_login_controller.dart';

class EtradeLogin extends GetWidget<EtradeLoginController> {
  const EtradeLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: content());
  }

  Widget content() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [header(), indexedContent()],
      ),
    );
  }

  Widget header() {
    return Column(
      children: const [
        SizedBox(
          height: 60,
        ),
        EtradeHeader(),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }

  Widget indexedContent() {
    return Obx(() {
      return PageTransitionSwitcher(
          reverse: false,
          transitionBuilder: (Widget child, Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation) {
            return SharedAxisTransition(
              fillColor: Colors.transparent,
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
          child: IndexedStack(
            index: controller.currentStep$.value,
            children: [
              body(),
              const EtradeAddAccounts(),
            ],
          ));
    });
  }

  Widget body() {
    return Column(
      children: [welcome(), loginBody(), invalidCreds(), connect()],
    );
  }

  Widget connect() {
    return SizedBox(
      width: double.maxFinite,
      height: 45,
      child: ElevatedButton(
        child: const Text('Connect',
            style: TextStyle(fontSize: 20, color: Colors.white)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(IrisColor.etradePurple)),
        onPressed: () async {
          await controller.connect();
        },
      ),
    );
  }

  Widget invalidCreds() {
    return Obx(() {
      if (controller.invalidCreds$.value == true) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3)),
          child: const Text('Invalid username or password',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
        );
      } else {
        return Container();
      }
    });
  }

  Widget loginBody() {
    return Container(
      height: 255,
      padding: const EdgeInsets.only(top: 20),
      child: FormBuilder(
          key: controller.formKey,
          child: Column(children: <Widget>[
            Builder(builder: (context) {
              return FormBuilderTextField(
                name: 'username',
                decoration: const InputDecoration(
                  labelText: 'User ID',
                ),
                autocorrect: false,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                style: TextStyle(color: context.theme.colorScheme.secondary),
                keyboardType: TextInputType.emailAddress,
              );
            }),
            const SizedBox(
              height: 30,
            ),
            Builder(builder: (context) {
              return FormBuilderTextField(
                name: 'password',
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                  ],
                ),
                style: TextStyle(color: context.theme.colorScheme.secondary),
                keyboardType: TextInputType.text,
              );
            }),
          ])),
    );
  }

  Widget welcome() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        'Enter your credentials',
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
      ),
    );
  }
}
