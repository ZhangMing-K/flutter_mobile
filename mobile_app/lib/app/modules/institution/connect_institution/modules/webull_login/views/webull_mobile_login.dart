import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/webull_login_controller.dart';

class WebullMobileLogin extends GetView<WebullLoginController> {
  const WebullMobileLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: FormBuilder(
          key: controller.mobileFormKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IrisPhoneNumberInputForm(
                  name: 'mobile',
                  filled: false,
                  style: TextStyle(color: context.theme.colorScheme.secondary),
                  onDialCodeChange: (countryCode) =>
                      controller.dialCode$.value = countryCode.dialCode!,
                  border: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: IrisColor.irisBlueLight, width: 1)),
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
}
