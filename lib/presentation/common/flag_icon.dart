import 'package:country_code_helper/country_code_helper.dart';
import 'package:flutter/material.dart';

class FlagIcon extends StatelessWidget {
  final String? countryCode;

  const FlagIcon({
    super.key,
    this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    final code = countryCode == null ? null : CountryCode.getCountryByCountryCode(countryCode!);
    return Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            99,
          ),
        ),
        child: Image.asset(
          code == null ? placeholderImgPath : (code.flag),
          fit: BoxFit.fill,
          height: 50,
          width: 50,
          package: countryCodePackageName,
          errorBuilder: (context, _, __) => const SizedBox(width: 22),
        ),
      ),
    );
  }
}
