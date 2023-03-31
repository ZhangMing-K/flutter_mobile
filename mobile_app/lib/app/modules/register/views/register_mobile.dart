// import 'dart:ui';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/widgets.dart';

// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:get/get.dart';

// import '../../../../shared/constants/units.dart';
// import '../../../shared/widgets/default_text_title.dart';
// import '../../../../widgets_v2/bases/full_screen_dialog.dart';
// import '../../../routes/pages.dart';
// import '../controllers/register_controller.dart';

// class RegisterMobileScreen extends GetView<RegisterController> {
//   Widget header() {
//     return DefaultTextTitle(
//       bottom: SpaceUnit.small,
//       top: SpaceUnit.large,
//       textTitle: 'Create your account',
//       fontSize: TextUnit.large,
//       fontWeight: FontWeight.w800,
//     );
//   }

//   Widget nameTextField(BuildContext context) {
//     return AutofillGroup(
//         child: Container(
//       margin: EdgeInsets.only(
//           top: SpaceUnit.small,
//           left: SpaceUnit.extraSmall,
//           right: SpaceUnit.extraSmall),
//       width: double.infinity,
//       child: Focus(
//           onFocusChange: (isFocused) {
//             if (!isFocused) {
//               final bool hasContent = controller.registerUserKey.currentState!
//                   .fields['name']!.value.isNotEmpty;
//               final bool emailHasError = controller
//                   .registerUserKey.currentState!.fields['email']!.hasError;
//               final bool passwordHasError = controller
//                   .registerUserKey.currentState!.fields['password']!.hasError;
//               if (hasContent && (!emailHasError && !passwordHasError)) {
//                 controller.registerUserKey.currentState!.fields['name']!
//                     .validate();
//               }
//             }
//           },
//           child: FormBuilderTextField(
//             autofocus: true,
//             name: 'name',
//             decoration: InputDecoration(labelText: 'Full Name'),
//             textCapitalization: TextCapitalization.words,
//             onChanged: (v) {
//               // cleans up stale errors
//               if (controller
//                   .registerUserKey.currentState!.fields['name']!.isValid) {
//                 controller.registerUserKey.currentState!.fields['name']!
//                     .validate();
//               }
//             },
//             valueTransformer: (item) => item?.trim(),
//             validator: FormBuilderValidators.compose(
//               [
//                 FormBuilderValidators.required(context,
//                     errorText: 'Fill out your name'),
//                 FormBuilderValidators.minLength(context, 2,
//                     errorText: 'Please provide a valid name'),
//               ],
//             ),
//             keyboardType: TextInputType.name,
//             autofillHints: const <String>[AutofillHints.name],
//             autocorrect: false,
//           )),
//     ));
//   }

//   Widget emailTextField(BuildContext context) {
//     return AutofillGroup(
//         child: Container(
//       margin: EdgeInsets.only(
//           top: SpaceUnit.small,
//           left: SpaceUnit.extraSmall,
//           right: SpaceUnit.extraSmall),
//       width: double.infinity,
//       child: Focus(
//           onFocusChange: (isFocused) {
//             if (!isFocused) {
//               final bool hasContent = !controller
//                   .registerUserKey.currentState!.fields['email']!.value.isEmpty;
//               final bool nameHasError = controller
//                   .registerUserKey.currentState!.fields['name']!.hasError;
//               final bool passwordHasError = controller
//                   .registerUserKey.currentState!.fields['password']!.hasError;
//               if (hasContent && (!nameHasError && !passwordHasError)) {
//                 controller.registerUserKey.currentState!.fields['email']!
//                     .validate();
//               }
//             }
//           },
//           child: FormBuilderTextField(
//             name: 'email',
//             decoration: InputDecoration(
//               labelText: 'Email',
//             ),
//             textCapitalization: TextCapitalization.none,
//             onChanged: (v) {
//               // cleans up stale errors
//               if (controller
//                   .registerUserKey.currentState!.fields['email']!.isValid) {
//                 controller.registerUserKey.currentState!.fields['email']!
//                     .validate();
//               }
//             },
//             valueTransformer: (item) => item?.trim().toLowerCase(),
//             validator: FormBuilderValidators.compose(
//               [
//                 FormBuilderValidators.required(context,
//                     errorText: 'Fill out your email'),
//                 FormBuilderValidators.email(context,
//                     errorText: 'Please provide a valid email')
//               ],
//             ),
//             keyboardType: TextInputType.emailAddress,
//             autofillHints: const <String>[AutofillHints.email],
//             autocorrect: false,
//           )),
//     ));
//   }

//   Widget passwordTextField(BuildContext context) {
//     return AutofillGroup(
//         child: Container(
//       margin: EdgeInsets.only(
//           top: SpaceUnit.small,
//           left: SpaceUnit.extraSmall,
//           right: SpaceUnit.extraSmall),
//       width: double.infinity,
//       child: Focus(
//           onFocusChange: (isFocused) {
//             if (!isFocused) {
//               final bool hasContent = !controller.registerUserKey.currentState!
//                   .fields['password']!.value.isEmpty;
//               final bool nameHasError = controller
//                   .registerUserKey.currentState!.fields['name']!.hasError;
//               final bool emailHasError = controller
//                   .registerUserKey.currentState!.fields['email']!.hasError;
//               if (hasContent && (!nameHasError && !emailHasError)) {
//                 controller.registerUserKey.currentState!.fields['password']!
//                     .validate();
//               }
//             }
//           },
//           child: FormBuilderTextField(
//             name: 'password',
//             decoration: InputDecoration(
//               labelText: 'Password',
//             ),
//             textCapitalization: TextCapitalization.none,
//             validator: FormBuilderValidators.compose(
//               [
//                 FormBuilderValidators.required(context,
//                     errorText: 'Fill out your password'),
//                 FormBuilderValidators.minLength(context, 4,
//                     errorText: 'Password is too short')
//               ],
//             ),
//             onChanged: (v) {
//               // cleans up stale errors
//               if (controller
//                   .registerUserKey.currentState!.fields['password']!.isValid) {
//                 controller.registerUserKey.currentState!.fields['password']!
//                     .validate();
//               }
//             },
//             keyboardType: TextInputType.visiblePassword,
//             autofillHints: const <String>[
//               AutofillHints.newPassword,
//             ],
//             autocorrect: false,
//             obscureText: true,
//           )),
//     ));
//   }

//   Widget nextButton({required bool isEnabled}) {
//     return Align(
//         alignment: Alignment.bottomCenter,
//         child: SafeArea(
//             child: Container(
//                 margin: EdgeInsets.only(bottom: SpaceUnit.extraSmall),
//                 width: double.infinity,
//                 child: ElevatedButton(
//                     style: ButtonStyle(
//                         padding: MaterialStateProperty.all(EdgeInsets.symmetric(
//                             vertical: SpaceUnit.extraSmall))),
//                     child: Text('Next',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: TextUnit.medium,
//                             fontWeight: FontWeight.w500)),
//                     onPressed: isEnabled
//                         ? () {
//                             WidgetsBinding.instance!.focusManager.primaryFocus
//                                 ?.unfocus();
//                             return controller.register();
//                           }
//                         : null))));
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO(Taro): Listen to this value more carefully.
//     // Currently, it can get stale in an edge case.
//     return ValueBuilder<bool>(
//       initialValue: false,
//       builder: (isAllFilled, setIsAllFilled) => FullScreenDialog(
//         alternativeAction: TextButton(
//             child: Text('Log in'),
//             onPressed: () {
//               Get.toNamed(Paths.Login.createPath([true]));
//             }),
//         replaceTitleWithLogo: true,
//         children: [
//           header(),
//           Expanded(
//               child: Container(
//             child: FormBuilder(
//                 onChanged: () {
//                   controller.registerUserKey.currentState!.save();
//                   try {
//                     setIsAllFilled(!controller
//                         .registerUserKey.currentState!.fields.values
//                         .any((e) => e.value.isEmpty));
//                   } catch (err) {
//                     // just in case an obscure error occurs, we don't want to block users
//                     setIsAllFilled(true);
//                   }
//                 },
//                 key: controller.registerUserKey,
//                 initialValue: const {
//                   'name': '',
//                   'email': '',
//                   'password': '',
//                 },
//                 child: Column(
//                   children: <Widget>[
//                     nameTextField(context),
//                     emailTextField(context),
//                     passwordTextField(context)
//                   ],
//                 )),
//           )),
//           nextButton(isEnabled: isAllFilled),
//         ],
//       ),
//     );
//   }
// }
