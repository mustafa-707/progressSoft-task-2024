import 'package:flutter/material.dart';
import 'package:progressofttask/logic/cubit/app/cubit.dart';
import 'package:progressofttask/logic/cubit/app/states.dart';
import 'package:progressofttask/logic/cubit/auth/cubit.dart';
import 'package:progressofttask/logic/cubit/config/cubit.dart';
import 'package:progressofttask/presentation/common/copy_write.dart';
import 'package:progressofttask/presentation/common/top_fade.dart';
import 'package:progressofttask/presentation/screens/auth/login.dart';
import 'package:progressofttask/presentation/screens/main_screen.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/global_navigator.dart';
import 'package:progressofttask/utils/theme/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/';

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _initializeApp() async {
    final appCubit = AppCubit.get(context);
    final configCubit = ConfigCubit.get(context);
    final authCubit = AuthCubit.get(context);

    await appCubit.sharedPreferencesCubit.stream.firstWhere(
      (state) => state is AppSettingsLoadedState,
    );
    await configCubit.fetchConfig();
    await authCubit.initUser();

    await Future.delayed(Duration(seconds: configCubit.config.delay));

    if (!mounted) return;

    // Assuming you have some logic to determine if the user is logged in
    if (authCubit.user != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        MainScreen.routeName,
        (_) => false,
      );
    } else {
      context.navigator.pushNamedAndRemoveUntil(
        LoginScreen.routeName,
        (_) => false,
      );
    }
  }

  @override
  void initState() {
    _initializeApp();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(
      const AssetImage(
        AppImages.splashLogo,
      ),
      rootNavigator.currentContext ?? context,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        body: Column(
          children: [
            const TopFadeWidget(),
            SizedBox(height: context.height * .12),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.asset(AppImages.splashLogo),
            ),
            const Spacer(),
            const CopyWriteWidget(),
            const SizedBox(height: 42),
          ],
        ),
      ),
    );
  }
}
