import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

const String DEFAULT_ERROR_MESSAGE =
    'Oops! \u{1F625} Something went wrong. Help us improve your experience by letting us know what happened.';
const String IRIS_CONTACT_US_LINK = 'https://www.iris.finance/contact';

const String LABEL = 'CONTACT US';

void showTempErrorSnackbar(
    {String? technicalMessage, String? userFriendlyMessage}) {
  // gracefully/silently try to report the error to PostHog
  reportErrorToPostHog(
      technicalMessage: technicalMessage,
      userFriendlyMessage: userFriendlyMessage);

  try {
    Get.rawSnackbar(
      padding: const EdgeInsets.only(
          left: SpaceUnit.small,
          top: SpaceUnit.extraSmall,
          right: SpaceUnit.small),
      titleText: Text(
        userFriendlyMessage ?? DEFAULT_ERROR_MESSAGE,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: TextUnit.small, color: Colors.white, height: 1.5),
      ),
      messageText: const UnconstrainedBox(
          alignment: AlignmentDirectional.bottomEnd,
          //padding: EdgeInsets.only(left: HorizontalUnit.extraSmall),
          child: ContactUsTextButton()),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(
          top: SpaceUnit.small,
          left: SpaceUnit.extraSmall,
          right: SpaceUnit.extraSmall),
      boxShadows: [
        BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1)
      ],
      backgroundColor: const Color(0xFF323232),
      borderRadius: 5,
      isDismissible: true,
      dismissDirection: DismissDirection.vertical,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(milliseconds: 5000),
      animationDuration: const Duration(milliseconds: 500),
    );
  } catch (err) {
    // if everything fails, lets at least try to capture this
    // so that we might become aware of it
    reportErrorToPostHog(technicalMessage: err.toString());
  }
}

// NOTE(Taro): This function doesn't behave like a normal widget, since GetX
// handles insertion of it.
class ContactUsTextButton extends StatelessWidget {
  const ContactUsTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
        child: const Text(LABEL),
        onPressed: () async {
          try {
            // NOTE(Taro): not using our GetX service for PostHog since...
            // it would only increase the odds of something going wrong here.
            if (GetPlatform.isMobile) {
              Posthog().capture(eventName: 'tap', properties: {
                'widget_name': 'ContactUsTextButton',
                'text': LABEL
              });
            }
          } catch (err) {
            debugPrint(err.toString());
          }
          const url = IRIS_CONTACT_US_LINK;
          UrlUtils.open(url);
        },
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all(context.theme.primaryColor),
            textStyle: MaterialStateProperty.all(const TextStyle(
                fontWeight: FontWeight.w700, fontSize: TextUnit.extraSmall))),
      );
}
