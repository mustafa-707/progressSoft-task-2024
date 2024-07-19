import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progressofttask/logic/cubit/auth/cubit.dart';
import 'package:progressofttask/logic/cubit/auth/states.dart';
import 'package:progressofttask/presentation/common/navbar.dart';
import 'package:progressofttask/presentation/screens/auth/login.dart';
import 'package:progressofttask/presentation/screens/profile_screen.dart';
import 'package:progressofttask/presentation/screens/home/home_screen.dart';
import 'package:progressofttask/utils/constants.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/theme/images.dart';

class MainScreen extends StatefulHookWidget {
  final int initIndex;
  const MainScreen({
    super.key,
    this.initIndex = HomeScreen.routeIndex,
  });
  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? currentScreen;

  Widget buildScreens() {
    if (widget.initIndex == HomeScreen.routeIndex) {
      return const HomeScreen();
    } else if (widget.initIndex == ProfileScreen.routeIndex) {
      return const ProfileScreen();
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        currentScreen = buildScreens();
        return null;
      },
      [],
    );

    final selectedSvgColor = ColorFilter.mode(
      context.primaryColor,
      BlendMode.srcIn,
    );
    final unSelectedSvgColor = ColorFilter.mode(
      context.onPrimaryColor,
      BlendMode.srcIn,
    );
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      if (state is LogOutState) {
        context.navigator.pushNamedAndRemoveUntil(
          LoginScreen.routeName,
          (_) => false,
        );
      }
    }, builder: (context, state) {
      return SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: context.backgroundColor,
          bottomNavigationBar: AppNavBar(
            initalIndex: widget.initIndex,
            items: [
              AppNavBarItemBuilder(
                icon: SvgPicture.asset(
                  AppImages.homeIcon,
                  colorFilter: unSelectedSvgColor,
                ),
                selectedIcon: SvgPicture.asset(
                  AppImages.homeIcon,
                  colorFilter: selectedSvgColor,
                ),
                label: context.translate.home,
                onTap: () => setState(
                  () => currentScreen = const HomeScreen(),
                ),
              ),
              AppNavBarItemBuilder(
                icon: SvgPicture.asset(
                  AppImages.profileIcon,
                  colorFilter: unSelectedSvgColor,
                ),
                selectedIcon: SvgPicture.asset(
                  AppImages.profileIcon,
                  colorFilter: selectedSvgColor,
                ),
                label: context.translate.profile,
                onTap: () => setState(
                  () => currentScreen = const ProfileScreen(),
                ),
              ),
            ],
          ),
          body: AnimatedSwitcher(
            duration: pPageTransitionDuration,
            child: currentScreen,
          ),
        ),
      );
    });
  }
}
