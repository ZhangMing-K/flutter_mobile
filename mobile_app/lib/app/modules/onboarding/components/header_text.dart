import 'package:flutter/material.dart';

class OnboardingHeaderText extends StatelessWidget {
  const OnboardingHeaderText({Key? key, this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: const TextStyle(fontSize: 24),
    );
  }
}
