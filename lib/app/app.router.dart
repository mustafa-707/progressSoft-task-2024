import 'package:flutter/material.dart';
import 'package:progressofttask/presentation/screens/auth/login.dart';
import 'package:progressofttask/presentation/screens/auth/signup.dart';
import 'package:progressofttask/presentation/screens/main_screen.dart';
import 'package:progressofttask/presentation/screens/splash_screen.dart';

final appRoutes = <String, WidgetBuilder>{
  SplashScreen.routeName: (context) => const SplashScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
};
