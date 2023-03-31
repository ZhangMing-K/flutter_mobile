import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utils/show_sheet/show_bottom_action_sheet.dart';
import 'iris_date_picker.dart';

// ignore: non_constant_identifier_names
openDatePickerPannel(
    {required BuildContext context, required Function(DateTime) onDateChange}) {
  showSheet(
      context: context,
      child: SizedBox(
        height: 200,
        child: IrisCupertinoDatePicker(
            backgroundColor: context.theme.backgroundColor,
            mode: IrisCupertinoDatePickerMode.date,
            textColor: context.theme.colorScheme.secondary,
            onDateTimeChanged: (dateTime) {
              onDateChange(dateTime);
            }),
      ),
      cancelButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.theme.backgroundColor,
        ),
        child: CupertinoActionSheetAction(
            child: SizedBox(
                height: 30,
                child: Text(
                  'Done',
                  style: TextStyle(color: context.theme.primaryColor),
                )),
            onPressed: () {
              Get.back();
            }),
      ));
}
