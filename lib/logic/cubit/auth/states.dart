import 'dart:developer';

abstract class AuthStates {}

class AuthInitState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final Object e;

  AuthErrorState(this.e) {
    log(e.toString());
  }
}

class OTPRequestedState extends AuthStates {
  final String verificationId;
  final int? resendToken;
  OTPRequestedState({
    required this.verificationId,
    this.resendToken,
  });
}

class UserLoadedState extends AuthStates {}

class UserEnterState extends AuthStates {}

class UserCreatedState extends AuthStates {}

class LogOutState extends AuthStates {}
