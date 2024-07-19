import 'package:flutter/material.dart';
import 'package:progressofttask/utils/global_navigator.dart';
import 'package:progressofttask/utils/theme/colors.dart';

class AppThemes {
  final String locale;

  AppThemes(this.locale);

  ThemeData lightTheme() => ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          secondary: AppColors.secondary,
          onSecondary: AppColors.onSecondary,
          error: AppColors.error,
          onError: AppColors.onError,
          background: AppColors.background,
          onBackground: AppColors.onBackground,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          shadow: AppColors.shadow,
        ),
        textTheme: TextTheme(
          labelMedium: TextStyle(
            fontWeight: FontWeight.w600,
            height: 1.4,
            fontSize: 14,
            color: AppColors.onPrimary,
            fontFamily: _getBoldFontByLocale(locale),
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w700,
            height: 1.4,
            fontSize: 12,
            color: AppColors.onPrimary,
            fontFamily: _getBoldFontByLocale(locale),
          ),
          titleSmall: TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.4,
            fontSize: 16,
            color: AppColors.onPrimary,
            fontFamily: _getBoldFontByLocale(locale),
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.4,
            fontSize: 18,
            color: AppColors.onPrimary,
            fontFamily: _getBoldFontByLocale(locale),
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.4,
            fontSize: 20,
            color: AppColors.onPrimary,
            fontFamily: _getBoldFontByLocale(locale),
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.normal,
            height: 1.4,
            fontSize: 14,
            color: AppColors.onPrimary,
            fontFamily: _getRegularFontByLocale(locale),
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.normal,
            height: 1.4,
            fontSize: 16,
            color: AppColors.onPrimary,
            fontFamily: _getRegularFontByLocale(locale),
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.w300,
            height: 1.4,
            fontSize: 12,
            color: AppColors.onPrimary,
            fontFamily: _getRegularFontByLocale(locale),
          ),
          displayLarge: TextStyle(
            fontWeight: FontWeight.w300,
            height: 1.4,
            fontSize: 18,
            color: AppColors.onPrimary,
            fontFamily: _getRegularFontByLocale(locale),
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.normal,
            height: 1.4,
            fontSize: 12,
            color: AppColors.onPrimary,
            fontFamily: _getRegularFontByLocale(locale),
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w300,
            height: 1.4,
            fontSize: 16,
            color: AppColors.onPrimary,
            fontFamily: _getRegularFontByLocale(locale),
          ),
        ),
      );

  ThemeData darkTheme() => lightTheme().copyWith(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primaryDark,
          onPrimary: AppColors.onPrimaryDark,
          secondary: AppColors.secondaryDark,
          onSecondary: AppColors.onSecondaryDark,
          error: AppColors.errorDark,
          onError: AppColors.onErrorDark,
          background: AppColors.backgroundDark,
          onBackground: AppColors.onBackgroundDark,
          surface: AppColors.surfaceDark,
          onSurface: AppColors.onSurfaceDark,
          shadow: AppColors.shadowDark,
        ),
        textTheme: lightTheme().textTheme.merge(
              TextTheme(
                labelMedium: TextStyle(
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                  fontSize: 14,
                  color: AppColors.onPrimaryDark,
                  fontFamily: _getBoldFontByLocale(locale),
                ),
                labelLarge: TextStyle(
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  fontSize: 12,
                  color: AppColors.onPrimaryDark,
                  fontFamily: _getBoldFontByLocale(locale),
                ),
                titleSmall: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  fontSize: 16,
                  color: AppColors.onPrimaryDark,
                  fontFamily: _getBoldFontByLocale(locale),
                ),
                titleMedium: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  fontSize: 18,
                  color: AppColors.onPrimaryDark,
                  fontFamily: _getBoldFontByLocale(locale),
                ),
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  fontSize: 20,
                  color: AppColors.onPrimaryDark,
                  fontFamily: _getBoldFontByLocale(locale),
                ),
                bodyMedium: TextStyle(
                  fontWeight: FontWeight.normal,
                  height: 1.4,
                  fontSize: 14,
                  color: AppColors.onPrimaryDark,
                  fontFamily: _getRegularFontByLocale(locale),
                ),
                bodyLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  height: 1.4,
                  fontSize: 16,
                  color: AppColors.onPrimaryDark,
                  fontFamily: _getRegularFontByLocale(locale),
                ),
                displaySmall: TextStyle(
                  fontWeight: FontWeight.w300,
                  height: 1.4,
                  fontSize: 12,
                  color: AppColors.onPrimaryDark,
                  fontFamily: _getRegularFontByLocale(locale),
                ),
                displayLarge: TextStyle(
                  fontWeight: FontWeight.w300,
                  height: 1.4,
                  fontSize: 18,
                  color: AppColors.onPrimaryDark,
                  fontFamily: _getRegularFontByLocale(locale),
                ),
                bodySmall: TextStyle(
                  fontWeight: FontWeight.normal,
                  height: 1.4,
                  fontSize: 12,
                  color: AppColors.onPrimaryDark,
                  fontFamily: _getRegularFontByLocale(locale),
                ),
                displayMedium: TextStyle(
                  fontWeight: FontWeight.w300,
                  height: 1.4,
                  fontSize: 16,
                  color: AppColors.onPrimaryDark,
                  fontFamily: _getRegularFontByLocale(locale),
                ),
              ),
            ),
      );

  String _getRegularFontByLocale(String locale) {
    return locale == 'ar' ? 'IBMPlexSansArabic-Regular' : 'IBMPlexSans-Regular';
  }

  String _getBoldFontByLocale(String locale) {
    return locale == 'ar' ? 'IBMPlexSansArabic-Bold' : 'IBMPlexSans-Bold';
  }
}

class ThemeService {
  static const defaultTheme = 'light';

  static String getDefaultTheme() {
    final context = rootNavigator.currentContext;
    if (context != null) {
      bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
      return isDarkMode ? 'dark' : 'light';
    } else {
      return ThemeMode.system.name;
    }
  }
}
