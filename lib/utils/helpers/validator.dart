import 'package:progressofttask/models/config.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/global_navigator.dart';
import 'package:progressofttask/utils/lang/locale.export.dart';

class FieldValidator {
  static String? nameValidator(
    String? input, {
    List<RegexInfo>? regexList,
  }) {
    final translate = AppLocalizations.of(getRootNavigator().context)!;

    final trimmedInput = input ?? "";
    if (trimmedInput.isEmpty) {
      return translate.pleaseEnterFullName;
    } else {
      for (var regex in regexList ?? <RegexInfo>[]) {
        final regexEx = RegExp('^${regex.value}\$');
        if (!regexEx.hasMatch(trimmedInput)) {
          return getRootNavigator().context.isArabic ? regex.ar : regex.en;
        }
      }
      return null;
    }
  }

  static String? validatePhoneNumber(
    String? input, {
    bool isValidPhoneNumber = false,
    List<RegexInfo>? regexList,
  }) {
    final trimmedInput = input?.trim() ?? "";
    final translate = AppLocalizations.of(getRootNavigator().context)!;

    if (trimmedInput.isEmpty) {
      return translate.pleaseEnterPhoneNumber;
    }

    for (var regex in regexList ?? <RegexInfo>[]) {
      final regexEx = RegExp('^${regex.value}\$');
      if (!regexEx.hasMatch(trimmedInput)) {
        return getRootNavigator().context.isArabic ? regex.ar : regex.en;
      }
    }

    if (!isValidPhoneNumber) {
      return translate.correctPhoneNumber;
    }

    return null;
  }

  static String? validatePassword(
    String? input, {
    List<RegexInfo>? regexList,
    String? confirmPassword,
  }) {
    final translate = AppLocalizations.of(getRootNavigator().context)!;
    final trimmedInput = input?.trim() ?? "";

    if (trimmedInput.isEmpty) {
      return translate.pleaseEnterPasswrod;
    }
    if (confirmPassword != null) {
      final trimmedConfirmPassword = confirmPassword.trim();
      if (trimmedInput != trimmedConfirmPassword) {
        return translate.passwordsDontMatch;
      }
    }

    for (var regex in regexList ?? <RegexInfo>[]) {
      final regexEx = RegExp(regex.value.contains('[') ? regex.value : '^${regex.value}\$');
      if (!regexEx.hasMatch(trimmedInput)) {
        return getRootNavigator().context.isArabic ? regex.ar : regex.en;
      }
    }
    return null;
  }
}
