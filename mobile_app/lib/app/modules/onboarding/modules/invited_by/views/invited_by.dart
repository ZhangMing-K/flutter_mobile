import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import '../../../components/onboarding_wrapper.dart';
import '../controllers/invited_by_controller.dart';

class InvitedByScreen extends GetView<InvitedByController> {
  const InvitedByScreen({Key? key}) : super(key: key);

  Widget header(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${controller.invitedBy.value!.firstName} invited you! Lets see who else you know on Iris.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
            padding: const EdgeInsets.only(top: 20, left: 14, right: 14),
            child: Text(
                'We sync your contacts so we can show you friends on Iris.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: context.theme.hintColor)))
      ],
    );
  }

  Widget main(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IgnorePointer(
              child: ProfileImage(
                url: controller.invitedBy.value!.profilePictureUrl,
                radius: 100,
                uuid: uuid.v4(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget name(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          controller.invitedBy.value!.fullName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 8),
        portfoliosRow(portfolios: controller.invitedBy.value!.portfolios!)
      ],
    );
  }

  Widget connect(BuildContext context) {
    return ActionButton(
      text: 'Connect contacts',
      textColor: Colors.white,
      onPressed: () {
        controller.syncContacts();
        controller.goToBuildYourCommunity();
      },
    );
  }

  Widget portfoliosRow({required List<Portfolio> portfolios}) {
    final List<Widget> images = [];
    for (var portfolio in portfolios) {
      images.add(BrokerIcon(height: 20, brokerName: portfolio.brokerName));
      images.add(const SizedBox(width: 8));
    }
    return Row(
      children: [...images],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingWrapper(
      child: Column(
        children: [
          header(context),
          main(context),
          name(context),
          connect(context)
        ],
      ),
    );
  }
}
