import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class PrivateChannelsWarningDialog extends StatelessWidget {
  const PrivateChannelsWarningDialog(
      {Key? key,
      required this.isParentWorkspace,
      this.nbrWorkspaceWithoutBot,
      this.workspacesWithoutBot})
      : super(key: key);
  final bool isParentWorkspace;
  final int? nbrWorkspaceWithoutBot;
  final List<Workspace>? workspacesWithoutBot;

  header(BuildContext context) {
    final String channelsText = isParentWorkspace && nbrWorkspaceWithoutBot! > 1
        ? 'channels'
        : 'channel';
    final String headerText = isParentWorkspace
        ? '$nbrWorkspaceWithoutBot Private $channelsText detected!'
        : 'A private channel detected!';

    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        headerText,
        style: TextStyle(
            color: context.theme.colorScheme.secondary,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  channels(BuildContext context) {
    final int remainingChannelsNumber =
        nbrWorkspaceWithoutBot! - workspacesWithoutBot!.length;
    final String remainingChannelsText =
        remainingChannelsNumber > 1 ? 'Others' : 'Other';

    return Container(
      padding: const EdgeInsets.only(
        right: 20,
        left: 20,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListView.separated(
            shrinkWrap: true,
            addAutomaticKeepAlives: false,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 6,
              );
            },
            itemCount: workspacesWithoutBot?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final Workspace workspace = workspacesWithoutBot![index];
              return Text(
                workspace.channelName,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              );
            }),
        if (remainingChannelsNumber > 0)
          Container(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '+$remainingChannelsNumber $remainingChannelsText',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ))
      ]),
    );
  }

  directions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
      child: const Text(
        'You need to go to Discord and manually add the Iris bot to private channels, then you may enable them here.',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  nextStepHeader(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30, bottom: 8),
        child: Text(
          'Already added the bot in Discord?',
          style: TextStyle(
              color: context.theme.colorScheme.secondary,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ));
  }

  nextStep(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
      child: const Text(
        'Click the refresh button next to the "Categories/Channels" heading to update your workspace',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  dismiss(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
      child: Column(
        children: [
          AppButtonV2(
            onPressed: () async {
              Get.back();
            },
            borderRadius: 12,
            width: double.infinity,
            child: const Text('Dismiss'),
            height: 40,
            buttonType: APP_BUTTON_TYPE.OUTLINE,
          ),
        ],
      ),
    );
  }

  Widget dialog(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21.0),
        ),
        // insetPadding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              header(context),
              if (isParentWorkspace) channels(context),
              directions(context),
              nextStepHeader(context),
              nextStep(context),
              dismiss(context)
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return dialog(context);
  }
}
