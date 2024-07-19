import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:progressofttask/presentation/common/appbar/sub_screen.dart';
import 'package:progressofttask/presentation/common/buttons/primary.dart';
import 'package:progressofttask/presentation/common/snackbar.dart';
import 'package:progressofttask/presentation/common/top_fade.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/theme/colors.dart';
import 'package:progressofttask/utils/theme/images.dart';

typedef VerifyCredentials = Future<void> Function(AuthCredential credential);

class OTPScreen extends StatefulHookWidget {
  final String verificationId;
  final String phoneNumber;
  final VerifyCredentials verifyCredentials;

  const OTPScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.verifyCredentials,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late final OTPTextEditController otpTextController;
  final OTPInteractor otpInteractor = OTPInteractor();
  final formKey = GlobalKey<FormState>();

  late Timer resendTimer;
  int resendRemainingSeconds = 30;

  bool isValidOtp = false;
  Future<void> onVerify = Future.value();

  void resetTextField() {
    formKey.currentState?.reset();
    otpTextController.text = '';
  }

  void restartResendTimer() {
    resendRemainingSeconds = 30;

    resendTimer = Timer.periodic(const Duration(seconds: 1), (time) {
      if (resendRemainingSeconds > 0) {
        if (mounted) {
          setState(() => resendRemainingSeconds--);
        }
      } else {
        time.cancel();
      }
    });
  }

  void initAutoFill() {
    try {
      if (Platform.isAndroid) {
        otpInteractor.getAppSignature();
      }

      otpTextController = OTPTextEditController(
        codeLength: 6,
        autoStop: false,
        otpInteractor: otpInteractor,
        onCodeReceive: (code) async {
          // the received or wrote on field code
          setState(() {
            onVerify = verifyOTP(code);
          });
        },
      );

      if (Platform.isAndroid) {
        otpTextController.startListenUserConsent((code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        });
      }
    } catch (e) {
      log('error to receive code - $e');
    }
  }

  Future<void> verifyOTP(String code) async {
    try {
      await widget.verifyCredentials(
        PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: code,
        ),
      );
    } catch (e) {
      handleException(e);
    }
  }

  @override
  void initState() {
    initAutoFill();
    restartResendTimer();
    super.initState();
  }

  @override
  void dispose() {
    otpTextController.stopListen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = useFuture(onVerify).connectionState == ConnectionState.waiting;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: SubScreenAppBar(
          title: context.translate.otpScreen,
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopFadeWidget(
              isAnimate: isLoading,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      SvgPicture.asset(AppImages.otp),
                      const SizedBox(height: 18),
                      Text(
                        context.translate.confirmCode,
                        style: context.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 240,
                        child: Text(
                          context.translate.enterSixNums + context.translate.yourPhoneNumber,
                          textAlign: TextAlign.center,
                          style: context.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          widget.phoneNumber,
                          textAlign: TextAlign.right,
                          style: context.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 300,
                            maxHeight: 43,
                          ),
                          child: Form(
                            key: formKey,
                            child: PinInputTextFormField(
                              autofillHints: const [AutofillHints.oneTimeCode],
                              keyboardType: TextInputType.phone,
                              controller: otpTextController,
                              pinLength: 6,
                              textInputAction: TextInputAction.go,
                              validator: (value) {
                                if (!isValidOtp) {
                                  return ' ';
                                } else {
                                  return null;
                                }
                              },
                              decoration: BoxLooseDecoration(
                                strokeColorBuilder: PinListenColorBuilder(
                                  AppColors.muted,
                                  AppColors.muted,
                                ),
                                errorTextStyle: context.bodyLarge.copyWith(
                                  color: context.errorColor,
                                  fontSize: 0,
                                ),
                                gapSpace: 10,
                                textStyle: context.titleLarge.copyWith(
                                  height: 1.1,
                                ),
                                hintText: '------',
                                hintTextStyle: context.bodyMedium.copyWith(
                                  color: AppColors.muted,
                                ),
                                radius: const Radius.circular(6.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 62),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: resendRemainingSeconds != 0 && !isLoading,
                              child: Text(
                                '${context.translate.didntReceiveOTP} $resendRemainingSeconds ${context.translate.second}',
                                textAlign: TextAlign.center,
                                style: context.bodyMedium.copyWith(
                                  height: 1.6,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: resendRemainingSeconds == 0 && !isLoading,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: TextButton(
                                  onPressed: () {
                                    resetTextField();
                                    restartResendTimer();
                                  },
                                  child: Text(
                                    context.translate.reSend,
                                    style: context.titleSmall,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 32),
                      PrimaryButton(
                        text: context.translate.verify,
                        onTap: isLoading
                            ? null
                            : () {
                                setState(() {
                                  onVerify = verifyOTP(otpTextController.text);
                                });
                              },
                      ),
                      const SizedBox(height: 44),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
