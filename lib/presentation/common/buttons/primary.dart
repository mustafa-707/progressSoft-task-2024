import 'package:flutter/material.dart';
import 'package:progressofttask/utils/constants.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final GestureTapCallback? onTap;

  const PrimaryButton({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            pButtonRadius,
          ),
        ),
        color: onTap != null ? color ?? context.primaryColor : AppColors.disabledPrimary,
        elevation: 0,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              pButtonRadius,
            ),
          ),
          onTap: onTap != null
              ? () {
                  onTap?.call();
                }
              : null,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: context.titleMedium.copyWith(
                color: textColor ?? context.onPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
