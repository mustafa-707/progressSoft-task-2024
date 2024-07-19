import 'package:flutter/material.dart';
import 'package:progressofttask/presentation/common/direction_aware.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/extensions/input_border.dart';
import 'package:progressofttask/utils/theme/colors.dart';

class PrimaryTextField extends StatelessWidget {
  //# Properties
  final TextEditingController controller;
  final String hintText;
  //# CallBacks
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Iterable<String>? autofillHints;

  //# Styles
  final int maxLines;
  final bool readOnly;
  final bool enabled;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextDirection? textDirection;
  final bool isHidden;
  final bool autoFocus;
  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onTap,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.maxLines = 1,
    this.enabled = true,
    this.autofillHints,
    this.suffixIcon,
    this.prefixIcon,
    this.textDirection,
    this.isHidden = false,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return DirectionalityAware(
      textDirection: textDirection,
      child: GestureDetector(
        onTap: onTap,
        child: TextFormField(
          controller: controller,
          style: context.bodyMedium.copyWith(
            height: 0,
          ),
          enabled: enabled,
          readOnly: readOnly,
          keyboardType: keyboardType,
          validator: validator,
          onTap: onTap,
          autofocus: autoFocus,
          obscureText: isHidden,
          autofillHints: autofillHints,
          onChanged: onChanged,
          maxLines: maxLines,
          autocorrect: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: context.onBackgroundColor,
            counterText: '',
            hintText: hintText,
            hintStyle: context.bodyMedium.copyWith(
              height: 0,
              color: AppColors.muted100,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
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
        ),
      ),
    );
  }
}
