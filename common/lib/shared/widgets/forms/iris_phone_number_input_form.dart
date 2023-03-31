import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../themes/colors.dart';

class IrisPhoneNumberInputForm extends StatelessWidget {
  const IrisPhoneNumberInputForm({
    Key? key,
    this.name,
    this.error,
    this.onChange,
    this.onDialCodeChange,
    this.top,
    this.bottom,
    this.filled = true,
    this.border,
    this.style,
    this.customFormatter,
  }) : super(key: key);
  final double? top;
  final double? bottom;
  final String? name;
  final String? error;
  final InputBorder? border;
  final Function? onChange;
  final Function? onDialCodeChange;
  final bool? filled;
  final TextStyle? style;
  final TextInputFormatter? customFormatter;

  //final _mobileFormatter = NumberTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: bottom ?? 0, top: top ?? 0),
      child: FormBuilderTextField(
        name: name!,
        autofocus: true,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.number,
        style: style,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          if (customFormatter != null) customFormatter!,
          // _mobileFormatter,
        ],
        decoration: InputDecoration(
            prefix: CountryCodePicker(
              onChanged: (countryCode) => onDialCodeChange!(countryCode),
              searchDecoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      )),
                  fillColor: context.theme.backgroundColor,
                  filled: true),
              initialSelection: 'US',
              showCountryOnly: true,
              dialogBackgroundColor: context.theme.scaffoldBackgroundColor,
            ),
            hintText: '(000) 000-0000',
            errorText: error,
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: IrisColor.sellColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                )),
            border: border,
            focusedBorder: border,
            fillColor: context.theme.backgroundColor,
            filled: filled),
        textCapitalization: TextCapitalization.none,
        onChanged: (String? number) {
          if (onChange != null) onChange!(number);
        },
        valueTransformer: (item) => item?.trim().toLowerCase(),
        validator: FormBuilderValidators.compose(
          [
            // FormBuilderValidators.numeric(context,
            //     errorText: 'Invalid phone number'),
            FormBuilderValidators.maxLength(14,
                errorText: 'That is an invalid number'),
            FormBuilderValidators.minLength(4,
                errorText: 'That is an invalid number'),
          ],
        ),
        autofillHints: const <String>[AutofillHints.telephoneNumber],
        autocorrect: false,
      ),
    );
  }
}

// class NumberTextInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     final String newText = newValue.text.replaceAll(RegExp(r'(\(|\))'), '');
//     return TextEditingValue(
//       text: newText,
//       selection: TextSelection.collapsed(offset: newText.length),
//     );
//   }
// }
