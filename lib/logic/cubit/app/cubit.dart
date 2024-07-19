import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progressofttask/logic/shared_preferences.dart';
import 'package:progressofttask/logic/cubit/app/states.dart';
import 'package:progressofttask/models/app_settings.dart';
import 'package:progressofttask/utils/lang/locale.dart';
import 'package:progressofttask/utils/theme/app_theme.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit(this.sharedPreferencesCubit) : super(AppInitState()) {
    _loadSettings();
  }

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  final SharedPreferencesCubit sharedPreferencesCubit;

  AppSettings appSettings = const AppSettings(
    locale: LocaleService.defaultLocale,
    theme: ThemeService.defaultTheme,
  );

  Future<void> _loadSettings() async {
    await sharedPreferencesCubit.stream.firstWhere((state) => state is AppSettingsLoadedState);
    appSettings = AppSettings(
      locale: sharedPreferencesCubit.getLocale(),
      theme: sharedPreferencesCubit.getTheme(),
    );
    emit(AppChangeLanguageState());
    emit(AppChangeThemeState());
  }

  Future<void> updateLocale(String locale) async {
    if (!LocaleService.isSupportedLocale(locale)) return;

    await sharedPreferencesCubit.setLocale(locale);
    appSettings = appSettings.copyWith(locale: locale);
    emit(AppChangeLanguageState());
  }

  Future<void> updateTheme(String theme) async {
    await sharedPreferencesCubit.setTheme(theme);
    appSettings = appSettings.copyWith(theme: theme);
    emit(AppChangeThemeState());
  }
}
