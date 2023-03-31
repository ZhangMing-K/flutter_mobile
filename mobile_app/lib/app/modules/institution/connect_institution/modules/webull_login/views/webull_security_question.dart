import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/webull_login_controller.dart';

class WebullSecurityQuestion extends GetView<WebullLoginController> {
  const WebullSecurityQuestion({Key? key}) : super(key: key);

  Widget main() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: FormBuilder(
          key: controller.questionFormKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Builder(builder: (context) {
                  return FormBuilderTextField(
                    name: 'answer',
                    style:
                        TextStyle(color: context.theme.colorScheme.secondary),
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Answer',
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: IrisColor.irisBlueLight)),
                    ),
                    // onChanged: _onChanged,
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    keyboardType: TextInputType.emailAddress,
                  );
                }),
              ])),
    );
  }

  Widget birthdayForm() {
    return Builder(builder: (context) {
      return Obx(() {
        String buttonText;
        Color color;

        if (controller.dateTime$.value == null) {
          buttonText = 'Select your birthday...';
          color = context.theme.primaryColor;
        } else {
          buttonText = DateFormat.yMMMd().format(controller.dateTime$.value!);
          color = context.theme.colorScheme.secondary;
        }

        return TextButton(
            child:
                Text(buttonText, style: TextStyle(color: color, fontSize: 17)),
            onPressed: () {
              openDatePickerPannel(
                  context: context,
                  onDateChange: (date) => controller.dateTime$.value = date);
            });
      });
    });
  }

  Widget nextQuestion() {
    const String prefixText = "Don't remember?";

    return Container(
      padding: const EdgeInsets.only(left: 4, top: 8),
      child: Builder(builder: (context) {
        final Color color = context.theme.hintColor;
        return Row(
          children: [
            Text(
              prefixText,
              style: TextStyle(color: color, fontSize: 14),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () async {
                await controller.submitAnswer(nextQuestion: true);
              },
              child: Text(
                'Next Question',
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget submit() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await controller.submitAnswer();
        },
        child: const Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget question() {
    return Obx(() {
      final text =
          controller.connectResponse$.value?.challengeOptions?[0] ?? '';
      return Container(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: Builder(builder: (context) {
            return Text(
              text,
              style: TextStyle(
                  fontSize: 22, color: context.theme.colorScheme.secondary),
            );
          }));
    });
  }

  Widget invalidCreds() {
    return Obx(() {
      return Container(
        height: 60,
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        alignment: Alignment.centerLeft,
        child: controller.invalidAnswerErrorText$.value.isNotEmpty
            ? Text(
                controller.invalidAnswerErrorText$.value,
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 14, color: IrisColor.sellColor),
              )
            : Container(),
      );
    });
  }

  Widget content() {
    return Obx(() {
      final bool isBirthdayQuestion =
          controller.connectResponse$.value?.challengeId ==
              controller.birthdayWebullQuestionId;
      return Column(children: [
        if (controller.connectResponse$.value != null &&
            controller.connectResponse$.value!.challengeOptions != null &&
            controller.connectResponse$.value!.challengeOptions!.isNotEmpty)
          question(),
        if (isBirthdayQuestion)
          birthdayQuestionBody()
        else
          standardQuestionBody(),
        invalidCreds(),
        submit()
      ]);
    });
  }

  Widget standardQuestionBody() {
    return Column(
      children: [
        main(),
        nextQuestion(),
      ],
    );
  }

  Widget birthdayQuestionBody() {
    return Column(
      children: [
        birthdayForm(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return content();
  }
}
