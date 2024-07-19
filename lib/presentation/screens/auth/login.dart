import 'package:country_code_helper/country_code_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:progressofttask/logic/cubit/app/cubit.dart';
import 'package:progressofttask/logic/cubit/app/states.dart';
import 'package:progressofttask/logic/cubit/auth/cubit.dart';
import 'package:progressofttask/logic/cubit/auth/states.dart';
import 'package:progressofttask/logic/cubit/config/cubit.dart';
import 'package:progressofttask/logic/exceptions.dart';
import 'package:progressofttask/presentation/common/appbar/sub_screen.dart';
import 'package:progressofttask/presentation/common/buttons/locale.dart';
import 'package:progressofttask/presentation/common/buttons/primary.dart';
import 'package:progressofttask/presentation/common/country_code_prefix.dart';
import 'package:progressofttask/presentation/common/primary_field.dart';
import 'package:progressofttask/presentation/common/snackbar.dart';
import 'package:progressofttask/presentation/common/top_fade.dart';
import 'package:progressofttask/presentation/screens/auth/otp.dart';
import 'package:progressofttask/presentation/screens/auth/signup.dart';
import 'package:progressofttask/presentation/screens/main_screen.dart';
import 'package:progressofttask/presentation/sheet/bottom_sheet.dart';
import 'package:progressofttask/presentation/sheet/country_picker.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/helpers/keyboard.dart';
import 'package:progressofttask/utils/helpers/validator.dart';
import 'package:progressofttask/utils/theme/colors.dart';
import 'package:progressofttask/utils/theme/images.dart';

class LoginScreen extends StatefulHookWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final dataForm = GlobalKey<FormState>();
  bool isValidForm = true;
  bool isPhoneNumberInvalid = false;
  Country? selectedCountry;
  late final PhoneNumberTools phoneTools;
  bool isHiddenPassword = true;

  @override
  void initState() {
    trySelectDefaultCountry();
    phoneTools = PhoneNumberTools();

    super.initState();
  }

  Future<void> trySelectDefaultCountry() async {
    try {
      final configCubit = ConfigCubit.get(context);

      final country = await CountryCode.initCountry(
        exclude: configCubit.config.countries,
      );

      if (mounted) {
        setState(() {
          selectedCountry = country;
        });
      }
    } catch (e) {
      return;
    }
  }

  void _showCountryPicker() async {
    final configCubit = ConfigCubit.get(context);
    // Note : support one country, won't show sheet
    if (configCubit.config.countries.length <= 1) return;

    final country = await showSheetPage<Country>(
      context: context,
      isModal: false,
      builder: (_) => const CountryCodeWidget(),
    );

    if (country != null && mounted) {
      setState(() {
        selectedCountry = country;
      });
    }
  }

  Future<void> _validateForm({
    required String phoneNumber,
  }) async {
    final isValidNumber = phoneTools.validate(
      phoneNumber,
      regionCode: selectedCountry?.countryCode,
    );
    if (mounted) {
      setState(() {
        isPhoneNumberInvalid = isValidNumber;
      });
    }

    try {
      if (dataForm.currentState!.validate()) {
        final formatedPhoneNumber = await phoneTools.parse(
          phoneNumber,
          regionCode: selectedCountry?.countryCode,
        );

        if (!mounted) return;

        final authCubit = AuthCubit.get(context);
        await authCubit.requestOTP(
          phoneNumber: formatedPhoneNumber.e164,
        );
      } else {
        setState(() {
          isValidForm = false;
        });
      }
    } catch (e) {
      return showErrorMsg(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);

    final phoneNumberController = useTextEditingController();
    final passwordController = useTextEditingController();
    final configCubit = ConfigCubit.get(context);

    return SafeArea(
      top: false,
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) async {
          if (state is UserEnterState) {
            await authCubit.login(passwordController.text);
          } else if (state is UserLoadedState) {
            if (authCubit.user != null) {
              showSuccessMsg(context.translate.signInSuccess);
              context.navigator.pushNamedAndRemoveUntil(
                MainScreen.routeName,
                (_) => false,
              );
            }
          } else if (state is AuthErrorState) {
            if (state.e is PasswordUncorrectException) {
              showErrorMsg(context.translate.passwordUnCorrect);
              context.navigator.pop();
            } else {
              showErrorMsg(context.translate.unknownErrorOccurred);
            }
          } else if (state is OTPRequestedState) {
            phoneTools
                .parse(
              phoneNumberController.text,
              regionCode: selectedCountry?.countryCode,
            )
                .then(
              (formatedPhoneNumber) {
                if (mounted) {
                  context.navigator.push(
                    MaterialPageRoute(
                      builder: (_) => OTPScreen(
                        phoneNumber: formatedPhoneNumber.e164,
                        verificationId: state.verificationId,
                        verifyCredentials: authCubit.verifyCredentialsAndLogin,
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoadingState;
          return Builder(builder: (context) {
            return GestureDetector(
              onTap: () => KeyboardHelper.hide(),
              child: Scaffold(
                backgroundColor: context.backgroundColor,
                extendBodyBehindAppBar: true,
                appBar: SubScreenAppBar(
                  title: context.translate.loginScreen,
                  isWithBackButton: false,
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopFadeWidget(
                      isAnimate: isLoading,
                      color: (isValidForm || isPhoneNumberInvalid) ? null : context.errorColor,
                    ),
                    Stack(
                      children: [
                        const PositionedDirectional(
                          start: 24,
                          child: LocaleChangeButton(),
                        ),
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: SizedBox(
                            height: 164,
                            child: Image.asset(
                              AppImages.splashLogo,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: BlocConsumer<AppCubit, AppStates>(
                            listener: (_, state) {
                              if (state is AppChangeLanguageState) {
                                // wating locle to full load
                                Future.delayed(const Duration(milliseconds: 250), () {
                                  if (phoneNumberController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty) {
                                    dataForm.currentState!.validate();
                                  }
                                });
                              }
                            },
                            builder: (_, __) => Form(
                              key: dataForm,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.translate.loginTitle,
                                    style: context.titleSmall,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    context.translate.loginSubtitle,
                                    style: context.bodyMedium,
                                  ),
                                  const SizedBox(height: 32),
                                  Text(
                                    context.translate.phoneNumber,
                                    style: context.titleSmall,
                                  ),
                                  const SizedBox(height: 12),
                                  PrimaryTextField(
                                    controller: phoneNumberController,
                                    autofillHints: const [
                                      AutofillHints.telephoneNumberDevice,
                                      AutofillHints.telephoneNumber,
                                    ],
                                    keyboardType: TextInputType.phone,
                                    hintText: context.translate.phoneNumberHint,
                                    validator: (input) => FieldValidator.validatePhoneNumber(
                                      input,
                                      isValidPhoneNumber: isPhoneNumberInvalid,
                                      regexList: configCubit.config.regex.mobile,
                                    ),
                                    prefixIcon: CountryCodePrefix(
                                      countryCode: selectedCountry?.countryCode ?? "",
                                      callingCode: selectedCountry?.callingCode ?? "",
                                      onTap: _showCountryPicker,
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  Text(
                                    context.translate.password,
                                    style: context.titleSmall,
                                  ),
                                  const SizedBox(height: 12),
                                  PrimaryTextField(
                                    controller: passwordController,
                                    hintText: context.translate.passwordHint,
                                    autofillHints: const [
                                      AutofillHints.password,
                                      AutofillHints.newPassword,
                                    ],
                                    validator: (input) => FieldValidator.validatePassword(
                                      input,
                                      regexList: configCubit.config.regex.password,
                                    ),
                                    isHidden: isHiddenPassword,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isHiddenPassword = !isHiddenPassword;
                                          });
                                        },
                                        icon: Icon(
                                          isHiddenPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: context.onPrimaryColor,
                                        )),
                                  ),
                                  const SizedBox(height: 120),
                                ],
                              ),
                            ),
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
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    context.translate.dontHaveAccount,
                                    style: context.bodyMedium,
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      context.navigator.pushNamed(
                                        SignUpScreen.routeName,
                                      );
                                    },
                                    child: Text(
                                      context.translate.signUp,
                                      style: context.bodyMedium.copyWith(
                                        color: AppColors.ancor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              PrimaryButton(
                                text: context.translate.login,
                                onTap: isLoading
                                    ? null
                                    : () {
                                        setState(() {
                                          isValidForm = true;
                                          _validateForm(
                                            phoneNumber: phoneNumberController.text,
                                          );
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
          });
        },
      ),
    );
  }
}
