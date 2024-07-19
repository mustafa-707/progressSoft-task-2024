import 'package:country_code_helper/country_code_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:progressofttask/logic/cubit/auth/cubit.dart';
import 'package:progressofttask/logic/cubit/auth/states.dart';
import 'package:progressofttask/logic/cubit/config/cubit.dart';
import 'package:progressofttask/models/user.dart';
import 'package:progressofttask/presentation/common/app_dropdown.dart';
import 'package:progressofttask/presentation/common/appbar/sub_screen.dart';
import 'package:progressofttask/presentation/common/buttons/primary.dart';
import 'package:progressofttask/presentation/common/country_code_prefix.dart';
import 'package:progressofttask/presentation/common/primary_field.dart';
import 'package:progressofttask/presentation/common/snackbar.dart';
import 'package:progressofttask/presentation/common/top_fade.dart';
import 'package:progressofttask/presentation/screens/auth/login.dart';
import 'package:progressofttask/presentation/screens/auth/otp.dart';
import 'package:progressofttask/presentation/sheet/bottom_sheet.dart';
import 'package:progressofttask/presentation/sheet/country_picker.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/helpers/keyboard.dart';
import 'package:progressofttask/utils/helpers/validator.dart';

class SignUpScreen extends StatefulHookWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signup';

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        authCubit.requestOTP(
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
    final configCubit = ConfigCubit.get(context);
    final authCubit = AuthCubit.get(context);

    final fullNameController = useTextEditingController();
    final ageController = useTextEditingController();
    final phoneNumberController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final gender = useState<Gender?>(Gender.male);

    final now = DateTime.now();

    final selectedDate = useState<DateTime>(
      DateTime(
        now.year - 12,
        now.month,
        now.day,
      ),
    );

    Future<void> showDatePicker(BuildContext context) async {
      await showSheetPage(
        context: context,
        builder: (_) => SizedBox(
          height: context.height * .5,
          child: YearPicker(
            selectedDate: selectedDate.value,
            firstDate: DateTime(1900),
            lastDate: DateTime(
              now.year - 12,
              now.month,
              now.day,
            ),
            onChanged: (date) {
              int age = now.year - date.year;
              if (now.month < date.month || (now.month == date.month && now.day < date.day)) {
                age--;
              }
              selectedDate.value = date;
              ageController.text = age.toString();
              context.navigator.pop();
            },
          ),
        ),
      );
    }

    return SafeArea(
      top: false,
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) async {
          if (state is UserCreatedState) {
            authCubit.register(
              phoneNumber: phoneNumberController.text,
              password: passwordController.text,
              fullName: fullNameController.text,
              age: int.parse(ageController.text),
              gender: gender.value!,
              country: selectedCountry!.countryCode,
            );
          } else if (state is AuthErrorState) {
            showErrorMsg(context.translate.unknownErrorOccurred);
          } else if (state is UserLoadedState) {
            showSuccessMsg(context.translate.signUpSuccess);
            context.navigator.pushNamedAndRemoveUntil(
              LoginScreen.routeName,
              (_) => false,
            );
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
              onTap: () => {
                KeyboardHelper.hide(),
                AppDropdown.close(),
              },
              child: Scaffold(
                backgroundColor: context.backgroundColor,
                extendBodyBehindAppBar: true,
                appBar: SubScreenAppBar(
                  title: context.translate.signUp,
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopFadeWidget(
                      isAnimate: isLoading,
                      color: (isValidForm || isPhoneNumberInvalid) ? null : context.errorColor,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Form(
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
                                  context.translate.signUpTitle,
                                  style: context.bodyMedium,
                                ),
                                const SizedBox(height: 32),
                                Text(
                                  context.translate.fullName,
                                  style: context.titleSmall,
                                ),
                                const SizedBox(height: 12),
                                PrimaryTextField(
                                  controller: fullNameController,
                                  hintText: context.translate.fullNameHint,
                                  validator: (value) => FieldValidator.nameValidator(
                                    value,
                                    regexList: configCubit.config.regex.fullName,
                                  ),
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
                                  context.translate.age,
                                  style: context.titleSmall,
                                ),
                                const SizedBox(height: 12),
                                PrimaryTextField(
                                  controller: ageController,
                                  enabled: false,
                                  onTap: () async {
                                    await showDatePicker(context);
                                  },
                                  hintText: context.translate.ageHint,
                                ),
                                const SizedBox(height: 32),
                                Text(
                                  context.translate.gender,
                                  style: context.titleSmall,
                                ),
                                const SizedBox(height: 12),
                                AppDropdown<Gender>(
                                  onTap: (i, v) async {
                                    gender.value = v;
                                  },
                                  hintText: gender.value == Gender.male
                                      ? context.translate.male
                                      : context.translate.female,
                                  itemList: Gender.values,
                                  itemListStrings: Gender.values
                                      .map(
                                        (g) => g == Gender.male
                                            ? context.translate.male
                                            : context.translate.female,
                                      )
                                      .toList(),
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
                                    confirmPassword: confirmPasswordController.text,
                                  ),
                                  isHidden: isHiddenPassword,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isHiddenPassword = !isHiddenPassword;
                                      });
                                    },
                                    icon: Icon(
                                      isHiddenPassword ? Icons.visibility_off : Icons.visibility,
                                      color: context.onPrimaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Text(
                                  context.translate.confirmPassword,
                                  style: context.titleSmall,
                                ),
                                const SizedBox(height: 12),
                                PrimaryTextField(
                                  controller: confirmPasswordController,
                                  hintText: context.translate.confirmPasswordHint,
                                  autofillHints: const [
                                    AutofillHints.password,
                                    AutofillHints.newPassword,
                                  ],
                                  isHidden: isHiddenPassword,
                                ),
                                const SizedBox(height: 32),
                              ],
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
                              const SizedBox(height: 32),
                              PrimaryButton(
                                text: isLoading
                                    ? context.translate.signingUp
                                    : context.translate.signUp,
                                onTap: isLoading
                                    ? null
                                    : () async {
                                        setState(() {
                                          isValidForm = true;
                                        });
                                        if (mounted) {
                                          await _validateForm(
                                            phoneNumber: phoneNumberController.text,
                                          );
                                        }
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
