import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/theme/colors.dart';
import 'package:progressofttask/utils/theme/images.dart';

class AppDropdown<T> extends StatefulWidget {
  const AppDropdown({
    super.key,
    required this.hintText,
    required this.itemList,
    required this.onTap,
    this.textBoxDecoration,
    this.isTrailingIcon = true,
    this.onCloseTrailingIcon = Icons.arrow_drop_down,
    this.onOpenTrailingIcon = Icons.arrow_drop_up,
    this.spacing = 8,
    this.menuTextpadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 20,
    ),
    this.menuBorderRadius = const BorderRadius.all(
      Radius.circular(5),
    ),
    required this.itemListStrings,
  });
  static OverlayEntry? _floatingOverlayMenu;
  static close() {
    _floatingOverlayMenu?.remove();
    _floatingOverlayMenu = null;
  }

  final String hintText;
  final List<T> itemList;
  final List<String> itemListStrings;

  final void Function(int index, T value) onTap;
  final BoxDecoration? textBoxDecoration;
  final bool isTrailingIcon;
  final IconData onCloseTrailingIcon;
  final IconData onOpenTrailingIcon;
  final int spacing;
  final EdgeInsetsGeometry menuTextpadding;
  final BorderRadius menuBorderRadius;

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  GlobalKey? actionKey;
  double height = 0;
  double width = 0;
  double xPosition = 0;
  double yPosition = 0;
  int? selectedIndex;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.hintText);
    selectedIndex = 0;
    super.initState();
  }

  void dropdownData() {
    final renderBox = actionKey!.currentContext!.findRenderObject()! as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    final offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  @override
  void dispose() {
    AppDropdown._floatingOverlayMenu?.dispose();
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      canSizeOverlay: true,
      builder: (context) => Positioned(
        left: xPosition,
        width: width,
        top: yPosition + height + widget.spacing,
        child: SizedBox(
          height: widget.itemList.length * 62.0 + widget.spacing,
          width: width,
          child: Material(
            color: context.backgroundColor,
            key: const Key('menuCardKey'),
            shape: RoundedRectangleBorder(
              borderRadius: widget.menuBorderRadius,
              side: BorderSide(
                color: AppColors.muted,
              ),
            ),
            elevation: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  widget.itemList.length,
                  (index) => InkWell(
                    onTap: () {
                      if (widget.itemList[index] == null) return;
                      setState(() {
                        selectedIndex = index;
                        AppDropdown._floatingOverlayMenu?.remove();
                        AppDropdown._floatingOverlayMenu = null;
                      });
                      widget.onTap(index, widget.itemList[index]!);
                    },
                    child: Container(
                      padding: widget.menuTextpadding,
                      width: width,
                      decoration: BoxDecoration(
                        color: index == selectedIndex ? AppColors.muted100.withOpacity(.1) : null,
                      ),
                      child: Text(
                        widget.itemListStrings[index].toString(),
                        textAlign: TextAlign.start,
                        style: context.bodyMedium.copyWith(
                          fontSize: 20,
                          color: context.onPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        setState(() {
          AppDropdown._floatingOverlayMenu?.remove();
          AppDropdown._floatingOverlayMenu = null;
        });
      },
      child: GestureDetector(
        key: actionKey,
        onTap: () {
          setState(() {
            if (AppDropdown._floatingOverlayMenu != null) {
              AppDropdown._floatingOverlayMenu?.remove();
              AppDropdown._floatingOverlayMenu = null;
            } else {
              AppDropdown._floatingOverlayMenu = _createOverlayEntry();

              if (widget.itemList.isEmpty) {
                return;
              }
              dropdownData();
              Overlay.of(context).insert(AppDropdown._floatingOverlayMenu!);
            }
          });
        },
        child: Container(
          key: const Key('textBoxKey'),
          height: 62,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          decoration: BoxDecoration(
            color: context.onBackgroundColor,
            border: Border.all(
              color: AppColors.muted,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  selectedIndex != null && widget.itemList.isNotEmpty
                      ? widget.itemListStrings[selectedIndex!].toString()
                      : widget.hintText,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyMedium.copyWith(
                    color: context.onPrimaryColor,
                    height: 0,
                  ),
                ),
              ),
              if (widget.isTrailingIcon && AppDropdown._floatingOverlayMenu != null)
                Transform.rotate(
                  angle: -math.pi,
                  child: SvgPicture.asset(AppImages.chevronDown),
                )
              else if (widget.isTrailingIcon && !(AppDropdown._floatingOverlayMenu != null))
                SvgPicture.asset(AppImages.chevronDown)
            ],
          ),
        ),
      ),
    );
  }
}
