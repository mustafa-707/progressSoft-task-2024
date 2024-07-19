import 'package:flutter/material.dart';
import 'package:progressofttask/utils/global_navigator.dart';

class KeyboardHelper {
  static bool isOpened() {
    final currentFocus = FocusScope.of(getRootNavigator().context);
    return !currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null;
  }

  static void hide() {
    final currentFocus = FocusScope.of(getRootNavigator().context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  }
}
