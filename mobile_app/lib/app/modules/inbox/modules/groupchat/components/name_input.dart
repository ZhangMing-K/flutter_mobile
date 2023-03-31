import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../groupchat_controller.dart';

class GroupChatNameInput extends StatelessWidget {
  const GroupChatNameInput({Key? key, required this.controller})
      : super(key: key);
  final GroupChatController controller;

  @override
  Widget build(BuildContext context) {
    final nameValidator = FormBuilderValidators.match(
        r'^[a-zA-Z0-9._-\s]+$', // allow letters, numbers, -, _, ., and space
        errorText: 'Contains invalid characters');

    return FormBuilder(
      key: controller.fbKey,
      initialValue: const {
        'groupName': '',
        'description': '',
      },
      // autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormBuilderTextField(
              name: 'groupName',
              decoration: InputDecoration(
                  labelText: 'Group Name',
                  labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary)),
              maxLength: 50,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required(), nameValidator],
              )),
          FormBuilderTextField(
            name: 'groupDescription',
            maxLength: 280,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            decoration: InputDecoration(
                labelText: 'Description',
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
          ),
        ],
      ),
    );
  }
}
