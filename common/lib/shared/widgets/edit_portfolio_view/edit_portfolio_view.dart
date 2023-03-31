import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

class EditPortfolioView extends StatelessWidget {
  final Portfolio? portfolio;

  const EditPortfolioView({Key? key, required this.portfolio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //c.initContext(context: context);
    return GetBuilder<EditPortfolioViewController>(
      init: EditPortfolioViewController(portfolio: portfolio),
      tag: '${portfolio!.portfolioKey}',
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(),
                  const SizedBox(height: 20),
                  form(controller),
                ],
              ),
              const SizedBox(height: 8),
              deletePortfolio(controller)
            ],
          ),
        );
      },
    );
  }

  Widget connectButton(EditPortfolioViewController controller) {
    return Obx(() {
      final CONNECTION_STATUS? portfolioStatus =
          controller.portfolio$.value?.connectionStatus;
      if (portfolioStatus == CONNECTION_STATUS.DISCONNECTED) {
        return AppButtonV2(
          width: double.infinity,
          borderRadius: 8,
          onPressed: controller.reconnectPortfolio,
          buttonType: APP_BUTTON_TYPE.OUTLINE,
          child: const Text('Reconnect'),
        );
      } else if (portfolioStatus == CONNECTION_STATUS.CONNECTED) {
        return AppButtonV2(
          width: double.infinity,
          borderRadius: 8,
          color: IrisColor.sellColor,
          onPressed: controller.disconnectPortfolio,
          buttonType: APP_BUTTON_TYPE.OUTLINE,
          child: const Text('Disconnect'),
        );
      }
      return Container();
    });
  }

  Widget deletePortfolio(EditPortfolioViewController controller) {
    return GestureDetector(
      onTap: () async => await controller.onDeleteTap(),
      child: const DefaultTextTitle(
        bottom: SpaceUnit.small,
        textTitle: 'Delete Portfolio',
        fontSize: TextUnit.extraSmall,
        fontWeight: FontWeight.w500,
        align: TextAlign.center,
        color: IrisColor.sellColor,
      ),
    );
  }

  Widget form(EditPortfolioViewController controller) {
    //TODO: why create globaykey instance here????
    final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
    controller.fbKey = fbKey;

    return Column(
      children: <Widget>[
        FormBuilder(
          key: controller.fbKey,
          initialValue: {
            'portfolioName': portfolio!.portfolioName,
            'portfolioVisibilitySetting': portfolio!.portfolioVisibilitySetting,
            // 'showPreview': showPreview,
          },
          // autovalidate: true,
          autovalidateMode: AutovalidateMode.always,
          child: Builder(builder: (context) {
            return Column(
              children: <Widget>[
                FormBuilderTextField(
                    name: 'portfolioName',
                    decoration:
                        const InputDecoration(labelText: 'Portfolio Name'),
                    maxLength: 20,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.max(70),
                      ],
                    )),
                FormBuilderChoiceChip(
                  name: 'portfolioVisibilitySetting',
                  spacing: 10,
                  enabled: true,
                  selectedColor: context.theme.primaryColor,
                  decoration: const InputDecoration(
                    labelText: 'Portfolio Visibility',
                  ),
                  crossAxisAlignment: WrapCrossAlignment.center,
                  // marginZero: EdgeInsets.symmetric(horizontal: 10),
                  options: const [
                    // FormBuilderFieldOption(
                    //   value: PORTFOLIO_VISIBILITY_SETTING.ONLY_ME,
                    //   child: Text(
                    //     'Only you',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                    FormBuilderFieldOption(
                      value: PORTFOLIO_VISIBILITY_SETTING.FOLLOWERS,
                      child: Text(
                        'Followers',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FormBuilderFieldOption(
                      value: PORTFOLIO_VISIBILITY_SETTING.EVERYONE,
                      child: Text(
                        'Everyone',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                // FormBuilderSwitch(
                //   title: const Text('Show preview to everyone'),
                //   name: 'showPreview',
                //   initialValue: showPreview,
                //   activeColor: Colors.white,
                //   inactiveTrackColor: IrisColor.inactive,
                //   activeTrackColor: IrisColor.active,
                // ),
                // FormBuilderTextField(
                //   initialValue: '0',
                //   name: 'cost',
                //   readOnly: true,
                //   decoration:
                //       const InputDecoration(labelText: 'Cost to follow'),
                // ),
              ],
            );
          }),
        ),
        const SizedBox(
          height: 30,
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // c.context = context;
                  controller.fbKey = fbKey;
                  controller.onSubmit();
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            connectButton(controller),
          ],
        )
      ],
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Portfolio Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
      ],
    );
  }

  static openPannel({
    required Portfolio? portfolio,
  }) async {
    return await Get.bottomSheet(
        CustomBottomSheet(
          maxHeight: .8,
          child: EditPortfolioView(
            portfolio: portfolio,
          ),
        ),
        isScrollControlled: true,
        enableDrag: true);
  }
}
