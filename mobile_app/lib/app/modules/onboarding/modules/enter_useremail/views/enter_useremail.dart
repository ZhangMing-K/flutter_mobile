import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iris_common/iris_common.dart';

import '../../../components/onboarding_wrapper.dart';
import '../controllers/enter_useremail_controller.dart';

class EnterUseremailScreen extends GetView<EnterUseremailController> {
  const EnterUseremailScreen({Key? key}) : super(key: key);

  Widget actionButton() {
    return ActionButton(
      padding: EdgeInsets.zero,
      height: ScreenUtil().setHeight(60),
      disabled: false,
      text: 'Next',
      textColor: Colors.white,
      onPressed: controller.createOrEditUser,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IrisAutoScrollContent(
      child: OnboardingWrapper(
          resizeToAvoidBottomInset: false,
          child: IrisInstructionForm(
            fontSize: IrisScreenUtil.dFontSize(28),
            actionButton: actionButton(),
            title: 'Great! What\'s your email?',
            content: content(),
            subtitle: '',
          )),
    );
  }

  Widget content() {
    return Column(
      children: [
        inputForm(),
      ],
    );
  }

  Widget inputForm() {
    return FormBuilder(
      key: controller.emailFormKey,
      initialValue: {
        'email': controller.email.value,
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: IrisScreenUtil.dWidth(24)),
                child: UserEmailInputForm(
                  name: 'email',
                  hint: 'traderjoe@gmail.com',
                  onChanged: (val) => controller.onEmailChanged(val),
                )),
          ),
        ],
      ),
    );
  }
}
