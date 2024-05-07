import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_accent_color.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_material_color.dart';

class AppColors {
  static final AppMaterialColor primaryLight = AppMaterialColor(
    const Color(0xFF57559B).value,
    const {
      100: Color(0xFFF4F3FD),
      400: Color(0xFF7372B4),
      500: Color(0xFF57559B),
    },
  );

  static final AppAccentColor info = AppAccentColor(
    const Color(0xFF1466FE).value,
    const {
      100: Color(0xFFEEF4FF),
      500: Color(0xFF1466FE),
    },
  );

  static final AppAccentColor warning = AppAccentColor(
    const Color(0xFFFBC02D).value,
    const {
      100: Color(0xFFFFFDE7),
      500: Color(0xFFFBC02D),
    },
  );

  static final AppAccentColor feedback = AppAccentColor(
    const Color(0xFFFF4538).value,
    const {
      100: Color(0xFFFFECEB),
      500: Color(0xFFFF4538),
    },
  );

  static MaterialColor grey = MaterialColor(
    const Color(0xFF91979F).value,
    const {
      50: Color(0xFFFFFFFF),
      100: Color(0xFFEEF1F7),
      200: Color(0xFFDFE5EC),
      300: Color(0xFFCBD0D6),
      400: Color(0xFFAFB4BB),
      500: Color(0xFF91979F),
      600: Color(0xFF636972),
      700: Color(0xFF474F5C),
      800: Color(0xFF343C46),
      900: Color(0xFF1D2530),
    },
  );

  static final Color backgroundColor = grey.shade50;

  static const Color highlightColor = Color(0xFFEEF1F7);

  static const Color borderLayout = Color(0xFFE0E5EB);

  static const Color borderElement = Color(0xFFCBD0D6);

  static const Color green = Color(0xFF006636);
}
