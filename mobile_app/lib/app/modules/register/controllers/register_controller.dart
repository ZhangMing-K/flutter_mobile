// import 'package:flutter/material.dart';

// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:get/get.dart';
// import 'package:iris_mobile/app/shared/widgets/overlay_loader.dart';
// import 'package:random_string/random_string.dart';

// import '../../../../shared/classes/v2/controller_base.dart';
// import '../../../../shared/stores/auth_user_store.dart';
// import '../../../../widgets_v2/snackbar.dart';
// import '../../../routes/pages.dart';
// import '../../../shared/themes/colors.dart';
// import '../../../vendor/packages/iris_event/iris_event.dart';

// // NOTE(Taro): Copying Twitter, who appends 8 random digits.
// const int kRandomNumberLenght = 8;

// class RegisterController extends ControllerBase {
//   final IAuthUserService authUserStore;
//   final IrisEvent irisEvent;
//   GlobalKey<FormBuilderState> registerUserKey = GlobalKey<FormBuilderState>();

//   RegisterController({required this.authUserStore, required this.irisEvent});

//   @override
//   onReady() {
//     irisEvent.add(eventType: EVENT_TYPE.REGISTER);
//     super.onClose();
//   }

//   @override
//   onClose() {
//     WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
//     super.onClose();
//   }

//   validateInOrder() {
//     try {
//       return registerUserKey.currentState!.fields['name']!.validate() &&
//           registerUserKey.currentState!.fields['email']!.validate() &&
//           registerUserKey.currentState!.fields['password']!.validate();
//     } catch (e) {
//       // just in case an obscure error occurs, we don't want to block users
//       registerUserKey.currentState!.validate();
//     }
//   }
// }
