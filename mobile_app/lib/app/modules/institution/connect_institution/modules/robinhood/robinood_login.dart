import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../views/institution_image.dart';
import 'controllers/robinhood_login_controller.dart';
import 'views/robinhood_add_accounts.dart';
import 'views/robinhood_verify_code.dart';

class RobinhoodLogin extends GetView<RobinhoodLoginController> {
  const RobinhoodLogin({Key? key}) : super(key: key);

  Widget body() {
    return Column(
      children: [
        welcome(),
        loginBody(),
        invalidCreds(),
        connect(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: main());
  }

  Widget connect() {
    return SizedBox(
      width: double.maxFinite,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(IrisColor.robinhoodGreen)),
        onPressed: () async {
          await controller.connect();
        },
        child: const Text('Connect',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget content() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          header(),
          indexedContent(),
        ],
      ),
    );
  }

  Widget header() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        SizedBox(
          height: 40,
        ),
        InstitutionImage(
          institionName: INSTITUTION_NAME.ROBINHOOD,
        ),
        SizedBox(
          height: 40,
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
              const RobinhoodVerifyCode(),
              const RobinhoodAddAccounts()
            ],
          ));
    });
  }

  Widget invalidCreds() {
    return Obx(() {
      if (controller.invalidCreds$.value) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: 40,
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
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Builder(builder: (context) {
                  return FormBuilderTextField(
                    // focusNode: controller.usernameFocusNode,
                    name: 'username',
                    // required

                    decoration: const InputDecoration(
                      labelText: 'Email/Username',
                    ),
                    autocorrect: false,
                    // onChanged: _onChanged,
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      // FormBuilderValidators.email(context),
                      FormBuilderValidators.required(),
                    ]),
                    style:
                        TextStyle(color: context.theme.colorScheme.secondary),
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
                    // onChanged: _onChanged,
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                      ],
                    ),
                    style:
                        TextStyle(color: context.theme.colorScheme.secondary),
                    keyboardType: TextInputType.text,
                  );
                }),
              ])),
    );
  }

  Widget main() {
    return SingleChildScrollView(
        child: Container(
      child: content(),
    ));
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
