import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progressofttask/logic/cubit/app/states.dart';
import 'package:progressofttask/utils/lang/locale.dart';
import 'package:progressofttask/utils/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCubit extends Cubit<AppStates> {
  SharedPreferencesCubit() : super(AppInitState()) {
    _init();
  }

  static SharedPreferencesCubit get(context) => BlocProvider.of<SharedPreferencesCubit>(context);

  late SharedPreferences _prefs;

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    emit(AppSettingsLoadedState());
  }

  String getLocale() {
    return _prefs.getString(PrefKeys.locale) ?? LocaleService.getDefaultLocale();
  }

  Future<void> setLocale(String locale) async {
    await _prefs.setString(PrefKeys.locale, locale);
  }

  String getTheme() {
    return _prefs.getString(PrefKeys.theme) ?? ThemeService.getDefaultTheme();
  }

  Future<void> setTheme(String theme) async {
    await _prefs.setString(PrefKeys.theme, theme);
  }

  AuthCredential? getStoredUserAuth() {
    final id = _prefs.getString(PrefKeys.providerId);
    final method = _prefs.getString(PrefKeys.signInMethod);
    return id != null && method != null
        ? AuthCredential(
            providerId: id,
            signInMethod: method,
          )
        : null;
  }

  Future<void> storeUserAuth(AuthCredential auth) async {
    await Future.wait([
      _prefs.setString(PrefKeys.providerId, auth.providerId),
      _prefs.setString(PrefKeys.signInMethod, auth.signInMethod),
    ]);
  }

  Future<void> removeStoredUserAuth() async {
    await Future.wait([
      _prefs.remove(PrefKeys.providerId),
      _prefs.remove(PrefKeys.signInMethod),
    ]);
  }
}

class PrefKeys {
  static const theme = 'app_theme';
  static const locale = 'app_locale';
  static const providerId = 'provider_id';
  static const signInMethod = 'auth_method';
}
