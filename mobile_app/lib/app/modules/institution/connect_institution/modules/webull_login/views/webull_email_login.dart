import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/webull_login_controller.dart';

class WebullEmailLogin extends GetWidget<WebullLoginController> {
  const WebullEmailLogin({Key? key}) : super(key: key);
  main(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: FormBuilder(
          key: controller.emailFormKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FormBuilderTextField(
                  name: 'email',
                  style: TextStyle(color: context.theme.colorScheme.secondary),
                  autocorrect: false,
                  // required
                  inputFormatters: [LowerCaseTextFormatter()],
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: IrisColor.irisBlueLight)),
                  ),
                  // onChanged: _onChanged,
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(),
                    FormBuilderValidators.required(),
                  ]),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 30,
                ),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: IrisColor.irisBlueLight)),
                  ),
                  style: TextStyle(color: context.theme.colorScheme.secondary),

                  // onChanged: _onChanged,
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  keyboardType: TextInputType.text,
                ),
              ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: main(context));
  }
}
