import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../themes/colors.dart';

class UserEmailInputForm extends StatelessWidget {
  final String name;
  final String? hint;
  final ValueChanged<String?>? onChanged;
  final String? errorText;
  final String? prefix;

  const UserEmailInputForm(
      {Key? key,
      required this.name,
      this.hint,
      this.onChanged,
      this.errorText,
      this.prefix})
      : super(key: key);

  validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      autofillHints: const <String>[AutofillHints.email],
      autocorrect: false,
      autofocus: true,
      onChanged: onChanged,
      style: TextStyle(
        color: context.theme.colorScheme.secondary,
      ),
      validator: FormBuilderValidators.compose(
        [FormBuilderValidators.required(), FormBuilderValidators.email()],
      ),
      decoration: InputDecoration(
        hintText: hint,
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
