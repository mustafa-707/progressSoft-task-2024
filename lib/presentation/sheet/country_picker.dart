import 'package:flutter/material.dart';
import 'package:country_code_helper/country_code_helper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/extensions/input_border.dart';
import 'package:progressofttask/utils/theme/colors.dart';
import 'package:progressofttask/utils/theme/images.dart';

class CountryCodeWidget extends StatefulWidget {
  const CountryCodeWidget({super.key});

  @override
  State<CountryCodeWidget> createState() => _CountryCodeWidgetState();
}

class _CountryCodeWidgetState extends State<CountryCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.backgroundColor,
      body: SizedBox(
        height: context.height,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Stack(
              children: <Widget>[
                PositionedDirectional(
                  end: 0,
                  child: Container(
                    width: 32,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 4,
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => context.navigator.pop(),
                        child: SvgPicture.asset(
                          AppImages.closeIcon,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    context.translate.selectCountryCode,
                    style: context.titleLarge.copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CountryPickerWidget(
                onSelected: (country) => context.navigator.pop(country),
                searchHintText: context.translate.search,
                searchInputDecoration: InputDecoration(
                  filled: true,
                  fillColor: context.onBackgroundColor,
                  counterText: '',
                  hintText: context.translate.search,
                  hintStyle: context.bodyMedium.copyWith(
                    height: 0,
                  ),
                  errorMaxLines: 1,
                  errorStyle: context.bodyMedium.copyWith(
                    color: context.errorColor,
                    height: 0,
                  ),
                  border: OutlineInputBorderExtension.border(
                    color: AppColors.muted,
                  ),
                  enabledBorder: OutlineInputBorderExtension.border(
                    color: AppColors.muted,
                  ),
                  errorBorder: OutlineInputBorderExtension.border(
                    color: context.errorColor,
                  ),
                  focusedErrorBorder: OutlineInputBorderExtension.border(
                    color: context.errorColor,
                  ),
                  focusedBorder: OutlineInputBorderExtension.border(
                    color: context.primaryColor,
                  ),
                  disabledBorder: OutlineInputBorderExtension.border(
                    color: AppColors.muted,
                  ),
                ),
                locale: context.locale.languageCode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
