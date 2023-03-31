import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/pages.dart';
import '../../../components/onboarding_wrapper.dart';
import '../controllers/contacts_permission_controller.dart';

class ContactsPermissionScreen extends GetView<ContactsPermissionController> {
  const ContactsPermissionScreen({Key? key}) : super(key: key);

  // final VoidCallback onCompleteCallBack;
  // final VoidCallback? onSkip;

  Widget actionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // if (onSkip != null)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ActionButton(
              height: 60,
              fontSize: 16,
              text: 'Connect contacts',
              textColor: Colors.white,
              onPressed: () async {
                await controller.syncContacts();
                Get.toNamed(Paths.BuildYourCommunity);
                //  onCompleteCallBack.call();
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return OnboardingWrapper(
      onSkip: controller.onNext,
      child: Container(
        alignment: Alignment.topCenter,
        child: controller.apiStatus$.value == API_STATUS.PENDING
            ? const IrisLoading(
                loadingText: 'Syncing your contacts :)',
              )
            : SizedBox(
                height: context.height,
                child: IrisInstructionForm(
                  excludeKeyboard: false,
                  fontSize: 28,
                  actionButton: actionButton(),
                  title: 'Connect with your friends',
                  subtitle:
                      'We can show you who is already a member and when new friends sign up',
                  content: Container(
                    padding: EdgeInsets.only(top: IrisScreenUtil.dWidth(20)),
                    margin: EdgeInsets.only(
                        top: IrisScreenUtil.dWidth(100),
                        bottom: IrisScreenUtil.dWidth(80)),
                    width: IrisScreenUtil.dWidth(238),
                    height: IrisScreenUtil.dWidth(180),
                    child: Image.asset(Images.connectionsBlue),
                  ),
                )),
      ),
    );
  }
}
