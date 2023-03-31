import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({Key? key}) : super(key: key);

  Widget body() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: form(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaveAppBar(
        title: 'Edit Profile',
        onCancel: () {
          Get.back();
        },
        onDone: () async {
          await overlayLoader(
            context: context,
            asyncFunction: () async {
              try {
                final result = await controller.userEdit();
                if (result != null) {
                  Get.back(); //using get.toNamed here allows user to be stuck in loop. Get.back will close the modal and prevent this
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            opacity: .8,
            loaderColor: context.theme.primaryColor,
          );
        },
      ),
      body: SizedBox(
        width: double.infinity,
        child: ScrollListView(
          children: [
            picture(),
            divider(),
            body(),
            LinkSocialsView(),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(
      indent: 10,
      endIndent: 10,
      thickness: 1,
    );
  }

  Widget form() {
    return Builder(builder: (context) {
      return Theme(
        data: context.theme.copyWith(
          canvasColor: context.theme.backgroundColor,
        ),
        child: FormBuilder(
          key: controller.fbKey,
          initialValue: {
            'firstName': controller.authUserStore.loggedUser!.firstName,
            'lastName': controller.authUserStore.loggedUser!.lastName,
            'username': controller.authUserStore.loggedUser!.username,
            'bio': controller.authUserStore.loggedUser!.description,
            'userPrivacyType':
                controller.authUserStore.loggedUser!.userPrivacyType
          },
          // autovalidateMode: AutovalidateMode.always,
          child: Builder(builder: (context) {
            // GlobalKey fbKey = controller.fbKey;
            final nameValidator = FormBuilderValidators.match(
                r'^[a-zA-Z0-9._-\s]+$', // allow letters, numbers, -, _, ., and space
                errorText: 'Contains invalid characters');
            final userNameValidator = FormBuilderValidators.match(
                r'^[a-zA-Z0-9_.]+$', // allow letters, numbers, -, _, ., and space
                errorText: 'Contains invalid characters');
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderTextField(
                    name: 'firstName',
                    decoration: InputDecoration(
                        labelText: 'First Name',
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary)),
                    maxLength: 15,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(), nameValidator],
                    )),
                FormBuilderTextField(
                    name: 'lastName',
                    maxLength: 15,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    decoration: InputDecoration(
                        labelText: 'Last Name',
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary)),
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(), nameValidator],
                    )),
                FormBuilderTextField(
                  name: 'username',
                  maxLength: 20,
                  autovalidateMode: AutovalidateMode.always,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  autocorrect: true,
                  decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                  validator: FormBuilderValidators.compose([userNameValidator]),
                ),
                FormBuilderDropdown(
                  name: 'userPrivacyType',

                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  items: const [
                    DropdownMenuItem(
                      value: USER_PRIVACY_TYPE.PUBLIC,
                      child: Text('Public'),
                    ),
                    DropdownMenuItem(
                      value: USER_PRIVACY_TYPE.PRIVATE,
                      child: Text('Private'),
                    ),
                  ],
                  autovalidateMode: AutovalidateMode.always,

                  // ignore: prefer_single_quotes
                  decoration: InputDecoration(
                      labelText: 'Privacy',
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                ),
                const SizedBox(height: 15),
                FormBuilderTextField(
                  name: 'bio',
                  maxLength: 500,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                  maxLines: 4,
                  minLines: 1,
                ),
              ],
            );
          }),
        ),
      );
    });
  }

  Widget picture() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Obx(() => ProfileImage(
            onTap: controller.uploadFile,
            url: controller.authUserStore.loggedUser!.profilePictureUrl,
            radius: 40,
            uuid: uuid.v4())),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () => controller.uploadFile(),
          child: Builder(builder: (context) {
            return Text(
              'Change Profile Photo',
              style: TextStyle(
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.bold),
            );
          }),
        ),
      ],
    );
  }
}
