import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import '../../../components/onboarding_wrapper.dart';
import '../controllers/enter_username_controller.dart';

class EnterUsernameScreen extends GetView<EnterUsernameController> {
  const EnterUsernameScreen({Key? key}) : super(key: key);

  Widget actionButton() {
    return Obx(
      () => ActionButton(
        disabled: controller.userName.value == null ||
            controller.userName.value!.isEmpty,
        text: 'Next',
        height: 60,
        fontSize: 16,
        textColor: Colors.white,
        // onPressed: controller.onUserNameSubmitted,
        onPressed: () {
          Get.focusScope?.unfocus();
          controller.onUserNameSubmitted();
          //controller.nextStep();
        },
      ),
    );
  }

  Widget inputForm() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: FormBuilder(
          key: controller.userNameFormKey,
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: {
            'userName': controller.userName.value,
          },
          child: Column(
            children: [
              Obx(
                () => UserNameInputForm(
                  name: 'userName',
                  hint: 'rocketman69420',
                  prefix: '@',
                  onChanged: (val) => controller.onUserNameChanged(val),
                  errorText: controller.usernameTakenError$.value,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingWrapper(
      canBack: false,
      canNotBackMessage: 'You have already started creating your account',
      child: SizedBox(
        // height: 280,
        child: SizedBox(
          // height: 280,
          child: IrisInstructionForm(
            fontSize: 28,
            actionButton: actionButton(),
            title: '...and your tradername?',
            content: inputForm(),
            subtitle: '',
          ),
        ),
      ),
    );
  }
}
