import 'package:flutter/material.dart';

class AppColors {
  // light theme
  static Color get primary => const Color(0xff052F48);
  static Color get onPrimary => const Color(0xFFFBFBFB);
  static Color get secondary => const Color(0xFF363640);
  static Color get onSecondary => const Color(0xFFE5E5E5);
  static Color get error => const Color(0xFFF3E6E6);
  static Color get onError => const Color(0xFFE65369);
  static Color get background => const Color(0xFFFFFFFF);
  static Color get onBackground => const Color(0xff000000);
  static Color get surface => const Color(0xFFFBFBFB);
  static Color get onSurface => const Color(0xff000000);
  static Color get shadow => const Color(0xffC7C7C7);

  // Dark theme
  static Color get primaryDark => const Color.fromARGB(255, 6, 79, 153);
  static Color get onPrimaryDark => const Color(0xFFFAFAFA);
  static Color get secondaryDark => const Color(0xFFB0B6C0);
  static Color get onSecondaryDark => const Color(0xFF0F0F0F);
  static Color get errorDark => const Color(0xFFEEB104);
  static Color get onErrorDark => const Color(0xFFFAFAFA);
  static Color get backgroundDark => const Color(0xFF0F0F0F);
  static Color get onBackgroundDark => const Color(0xFF1A1A1A);
  static Color get surfaceDark => const Color(0xFF0F0F0F);
  static Color get onSurfaceDark => const Color(0xFFFFFFFF);
  static Color get shadowDark => const Color(0xFFC7C7C7);

  // custom colors
  static Color get ancor => const Color(0xff4785FC);
  static Color get muted => const Color(0xFF292929);
  static Color get muted100 => const Color(0xFF737373);
  static Color get disabledPrimary => const Color.fromARGB(255, 8, 48, 93);
}
