import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../themes/colors.dart';

class UserNameInputForm extends StatelessWidget {
  final String name;
  final String? hint;
  final ValueChanged<String?>? onChanged;
  final String? errorText;
  final String? prefix;

  const UserNameInputForm(
      {Key? key,
      required this.name,
      this.hint,
      this.onChanged,
      this.errorText,
      this.prefix})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    const regex = r'^[a-zA-Z0-9._-\s]+$';

    final nameValidator = FormBuilderValidators.match(
        regex, // allow letters, numbers, -, _, ., and space
        errorText: 'Contains invalid characters');
    return FormBuilderTextField(
      name: name,
      autofillHints: const <String>[AutofillHints.name],
      autocorrect: false,
      autofocus: true,
      onChanged: onChanged,
      style: TextStyle(
        color: context.theme.colorScheme.secondary,
      ),
      validator: FormBuilderValidators.compose(
        [FormBuilderValidators.required(), nameValidator],
      ),
      decoration: InputDecoration(
        hintText: hint,
        // prefixText: prefix,
        prefix: Container(
          padding: const EdgeInsets.only(left: 8),
          child: Text(prefix ?? ''),
        ),
        errorStyle: const TextStyle(fontSize: 14),
        errorText: errorText,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: IrisColor.sellColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        fillColor: context.theme.backgroundColor,
        filled: true,
      ),
    );
  }
}
