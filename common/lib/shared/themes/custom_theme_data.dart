import 'package:iris_common/shared/themes/custom_color_theme.dart';
import 'package:iris_common/shared/themes/custom_text_theme.dart';

class CustomThemeData {
  final CustomColorScheme colorScheme;
  final CustomTextTheme textTheme;

  factory CustomThemeData.dark() => CustomThemeData(
        textTheme: CustomTextTheme.dark(),
        colorScheme: CustomColorScheme.dark(),
      );

  factory CustomThemeData.light() => CustomThemeData(
        textTheme: CustomTextTheme.light(),
        colorScheme: CustomColorScheme.light(),
      );

  CustomThemeData({required this.textTheme, required this.colorScheme});
}
