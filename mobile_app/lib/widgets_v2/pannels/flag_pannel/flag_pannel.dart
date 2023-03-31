import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'flag_pannel_controller.dart';

//TODO: refactor to bindings
class FlagPannel extends StatelessWidget {
  FlagPannelController c = FlagPannelController();
  int? flagEntityKey;

  FLAG_ENTITY_TYPE? flagEntityType;
  FlagPannel({
    this.flagEntityType,
    this.flagEntityKey,
  }) {
    c.flagEntityKey = flagEntityKey;
    c.flagEntityType = flagEntityType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      // padding: EdgeInsets.symmetric(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          flagContent(context),
        ],
      ),
    );
  }

  flagContent(context) {
    final List<Widget> list = [];

    for (var element in c.reasons) {
      list.add(const Divider());
      list.add(PannelTile(
          text: Flags.getFlagText(element),
          color: Theme.of(context).colorScheme.secondary,
          onTap: () async {
            HapticFeedback.lightImpact();
            if (element == FLAG_REASON_TYPE.OTHER) {
              c.otherView.value = true;
            } else {
              await c.createFlag(c.flagEntityType, c.flagEntityKey, element);
            }
          }));
    }

    warning() {
      final actionText =
          c.flagEntityType == FLAG_ENTITY_TYPE.USER ? 'suspend' : 'delete';
      final entityText =
          c.flagEntityType == FLAG_ENTITY_TYPE.USER ? 'user' : 'post/comment';

      return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.warning_sharp, color: IrisColor.negativeChange),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: names(
                  text:
                      'Warning to the admins: flagging this $entityText as anything other than "Other" will $actionText this $entityText.',
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).hintColor,
                  fontSize: 14),
            )
          ]));
    }

    return Obx(() => !c.otherView.value
        ? Column(children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      names(
                          text: 'Report',
                          // color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      names(
                          text: 'Why are you reporting this?',
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                      if (c.authUserStore.loggedUser!.userAccessType ==
                          USER_ACCESS_TYPE.ADMIN)
                        warning(),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      ...list
                    ]))
          ])
        : otherView(context));
  }

  Widget names(
      {required String text,
      Color? color,
      FontWeight? fontWeight,
      required double fontSize}) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: ScreenUtil().setSp(fontSize),
      ),
    );
  }

  otherView(context) {
    final GlobalKey reasonFormKey = GlobalKey<FormBuilderState>();
    c.reasonFormKey = reasonFormKey as GlobalKey<FormBuilderState>?;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            names(text: 'Report', fontWeight: FontWeight.w500, fontSize: 18),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            names(
                text: 'Tell us what you would like to report',
                fontWeight: FontWeight.w300,
                fontSize: 14),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            FormBuilder(
              key: c.reasonFormKey,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    name: 'reason',
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                            errorText: 'A reason is required to submit'),
                      ],
                    ),
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w300)),
                    expands: false,
                    minLines: 1,
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  submit(context)
                ],
              ),
            ),
          ],
        ));
  }

  Widget submit(context) {
    return DefaultButton(
      backgroundColor: IrisColor.buyColor,
      onPressed: () async {
        final flag = await c.createFlag(
            c.flagEntityType, c.flagEntityKey, FLAG_REASON_TYPE.OTHER);
        if (flag != null) c.baseController.closePanelFully(context: context);
      },
      textColor: Colors.white,
      text: 'Submit',
      spFont: ScreenUtil().setSp(17),
      height: ScreenUtil().setHeight(44),
      width: ScreenUtil().setWidth(346),
      borderColor: IrisColor.buyColor,
    );
  }

  thankYou() {
    return Container();
  }

  static openPannel({
    int? flagEntityKey,
    FLAG_ENTITY_TYPE? flagEntityType,
  }) {
    Get.bottomSheet(
        CustomBottomSheet(
          child: FlagPannel(
            flagEntityKey: flagEntityKey,
            flagEntityType: flagEntityType,
          ),
        ),
        isScrollControlled: true);
  }
}
