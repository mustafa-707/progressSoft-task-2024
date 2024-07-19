import 'package:flutter/material.dart';
import 'package:progressofttask/presentation/common/direction_aware.dart';
import 'package:progressofttask/presentation/common/flag_icon.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/theme/colors.dart';

class CountryCodePrefix extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? countryCode;
  final String callingCode;

  const CountryCodePrefix({
    super.key,
    this.onTap,
    required this.callingCode,
    this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    return DirectionalityAware(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.transparent,
          borderRadius: const BorderRadiusDirectional.horizontal(
            start: Radius.circular(
              10,
            ),
          ),
          child: InkWell(
            customBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.horizontal(
                start: Radius.circular(
                  12,
                ),
              ),
            ),
            onTap: () => onTap?.call(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 19),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: FlagIcon(
                      countryCode: countryCode,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 62),
                    child: Text(
                      callingCode,
                      style: context.bodyMedium.copyWith(
                        height: 0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    width: 1,
                    height: 18,
                    color: AppColors.muted,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
