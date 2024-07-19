import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progressofttask/app/app.router.dart';
import 'package:progressofttask/logic/cubit/app/cubit.dart';
import 'package:progressofttask/logic/cubit/auth/cubit.dart';
import 'package:progressofttask/logic/cubit/config/cubit.dart';
import 'package:progressofttask/logic/cubit/posts/cubit.dart';
import 'package:progressofttask/logic/shared_preferences.dart';
import 'package:progressofttask/logic/cubit/app/states.dart';
import 'package:progressofttask/presentation/common/behaviors/scroll.dart';
import 'package:progressofttask/presentation/screens/splash_screen.dart';
import 'package:progressofttask/utils/global_navigator.dart';
import 'package:progressofttask/utils/lang/locale.dart';
import 'package:progressofttask/utils/lang/locale.export.dart';
import 'package:progressofttask/utils/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SharedPreferencesCubit>(
          create: (context) => SharedPreferencesCubit(),
        ),
        BlocProvider<AppCubit>(
          create: (context) => AppCubit(SharedPreferencesCubit.get(context)),
        ),
        BlocProvider<ConfigCubit>(
          create: (context) => ConfigCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(SharedPreferencesCubit.get(context)),
        ),
        BlocProvider<PostCubit>(
          create: (context) => PostCubit(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, _) {
          final appCubit = AppCubit.get(context);
          final settings = appCubit.appSettings;
          return MaterialApp(
            title: 'ProgresSoft',
            navigatorKey: rootNavigator,
            themeMode: ThemeMode.values.firstWhere(
              (element) => element.name == settings.theme,
            ),
            theme: AppThemes(settings.locale).darkTheme(),
            darkTheme: AppThemes(settings.locale).darkTheme(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: [
              for (var supportedLocale in LocaleService.supportedLocales)
                Locale(supportedLocale.code)
            ],
            locale: Locale(settings.locale),
            initialRoute: SplashScreen.routeName,
            routes: appRoutes,
            builder: (_, child) {
              final MediaQueryData data = MediaQuery.of(context);
              return ScrollConfiguration(
                behavior: AppScrollBehavior(),
                child: MediaQuery(
                  data: data.copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: child ?? const SizedBox.shrink(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
