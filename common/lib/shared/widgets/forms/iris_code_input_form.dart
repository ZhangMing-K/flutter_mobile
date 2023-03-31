import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../themes/colors.dart';

class IrisCodeInputForm extends StatelessWidget {
  const IrisCodeInputForm({
    Key? key,
    required this.name,
    required this.codeLength,
    this.error,
    this.onChange,
    this.top,
    this.bottom,
    this.autoSubmitOnValid,
  }) : super(key: key);
  final double? top;
  final double? bottom;
  final String name;
  final String? error;
  final Function? onChange;
  final int codeLength;
  final bool? autoSubmitOnValid;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'verification',
      autofocus: true,
      keyboardType: TextInputType.phone,
      style: TextStyle(
        color: context.theme.colorScheme.secondary,
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
          // contentPadding: const EdgeInsets.symmetric(horizontal: 18),
          prefix: const SizedBox(width: 16),
          hintText: 'x' * codeLength,
          errorText: error,
          errorStyle: const TextStyle(fontSize: 14),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: IrisColor.sellColor),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              )),
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              )),
          fillColor: context.theme.backgroundColor,
          filled: true),
      textCapitalization: TextCapitalization.none,
      onChanged: (String? code) => onChange!(code),
      valueTransformer: (item) => item?.trim().toLowerCase(),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.numeric(errorText: 'Invalid Code'),
          FormBuilderValidators.maxLength(codeLength,
              errorText: 'That is an invalid number'),
          FormBuilderValidators.minLength(codeLength,
              errorText: 'That is an invalid number'),
        ],
      ),
      autofillHints: const <String>[AutofillHints.oneTimeCode],
      autocorrect: false,
    );
  }
}
