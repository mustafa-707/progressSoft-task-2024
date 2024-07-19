import 'package:flutter/material.dart';
import 'package:progressofttask/utils/constants.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/theme/colors.dart';

class OutlineButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final GestureTapCallback? onTap;

  const OutlineButton({
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
        color: Colors.transparent,
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  pButtonRadius,
                ),
              ),
              border: Border.all(
                color: onTap != null ? color ?? context.primaryColor : AppColors.disabledPrimary,
              ),
            ),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: context.titleMedium.copyWith(
                  color:
                      onTap != null ? textColor ?? context.primaryColor : AppColors.disabledPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
