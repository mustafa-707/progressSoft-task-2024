import 'dart:developer';

import 'package:bcrypt/bcrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progressofttask/logic/cubit/auth/states.dart';
import 'package:progressofttask/logic/exceptions.dart';
import 'package:progressofttask/logic/firebase/firebase_collections.dart';
import 'package:progressofttask/logic/firebase/firestore.dart';
import 'package:progressofttask/logic/shared_preferences.dart';
import 'package:progressofttask/models/user.dart';

class AuthCubit extends Cubit<AuthStates> {
  final SharedPreferencesCubit sharedPreferencesCubit;

  AuthCubit(this.sharedPreferencesCubit) : super(AuthInitState()) {
    init();
  }

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  AppUser? user;
  User? userAuth;
  final _auth = FirebaseAuth.instance;

  late FireStoreService<AppUser> firestore;
  Future<void> init() async {
    firestore = FireStoreService<AppUser>(
      path: FirebaseCollections.users,
      fromJsonT: (d) => AppUser.fromJson(d),
      toJsonT: (c) => c.toJson(),
    );
  }

  Future<void> initUser() async {
    try {
      await verifyCredentialsAndLogin(null);

      userAuth = _auth.currentUser;
      if (userAuth == null) throw const UnauthenticatedException();
      fetchUser(userAuth!.uid);
    } catch (e) {
      log("init User Error: $e");
    }
  }

  Future<void> fetchUser(String id) async {
    try {
      if (userAuth == null) throw const UnauthenticatedException();
      final user = await firestore.get(userAuth!.uid);
      if (user == null) {
        emit(UserCreatedState());
      } else {
        this.user = user.first;
        emit(UserEnterState());
      }
    } catch (e) {
      emit(AuthErrorState(e));
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      user = null;
      userAuth = null;
      sharedPreferencesCubit.removeStoredUserAuth();
      emit(LogOutState());
    } catch (e) {
      emit(AuthErrorState(e));
    }
  }

  Future<void> register({
    required String phoneNumber,
    required String password,
    required String fullName,
    required int age,
    required Gender gender,
    required String country,
  }) async {
    try {
      final passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());

      user = AppUser(
        uid: userAuth!.uid,
        name: fullName,
        phoneNumber: phoneNumber,
        age: age,
        gender: gender,
        country: country,
        passwordHash: passwordHash,
      );

      await firestore.upsert(user!, userAuth!.uid);

      emit(UserLoadedState());
    } catch (e) {
      emit(AuthErrorState(e));
    }
  }

  Future<void> login(String password) async {
    try {
      final fetchedUser = await firestore.get(userAuth!.uid);
      if (fetchedUser == null) throw const UnauthenticatedException();

      final isValidPassword = BCrypt.checkpw(password, fetchedUser.first.passwordHash);
      if (!isValidPassword) {
        throw const PasswordUncorrectException();
      }
      emit(UserLoadedState());
    } catch (e) {
      emit(AuthErrorState(e));
    }
  }

  Future<void> requestOTP({required String phoneNumber}) async {
    emit(AuthLoadingState());
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval scenario
          await verifyCredentialsAndLogin(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthErrorState(e));
        },
        codeSent: (String verificationId, int? resendToken) {
          // OTP code sent
          emit(
            OTPRequestedState(
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout
        },
      );
    } catch (e) {
      emit(AuthErrorState(e));
    }
  }

  Future<void> verifyCredentialsAndLogin(AuthCredential? credential) async {
    try {
      if (credential == null) {
        final userCredentials = sharedPreferencesCubit.getStoredUserAuth();
        if (userCredentials != null) {
          final auth = await _auth.signInWithCredential(userCredentials);
          userAuth = auth.user;
          await fetchUser(userAuth!.uid);
        }
      } else {
        final userCredentials = await _auth.signInWithCredential(credential);
        userAuth = userCredentials.user;
        sharedPreferencesCubit.storeUserAuth(credential);
        await fetchUser(userAuth!.uid);
      }
    } catch (e) {
      emit(AuthErrorState(e));
    }
  }
}
