import 'package:flutter/material.dart';
import 'package:progressofttask/presentation/common/behaviors/bouncy.dart';
import 'package:progressofttask/utils/constants.dart';
import 'package:progressofttask/utils/extensions/context.dart';

class AppNavBar extends StatefulWidget {
  final List<AppNavBarItemBuilder> items;
  final int initalIndex;

  const AppNavBar({
    super.key,
    required this.items,
    this.initalIndex = 1,
  });

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initalIndex;
    super.initState();
  }

  void onNavBarItemTap(int index) {
    if (!widget.items[index].isNavgationOnly) {
      setState(() => currentIndex = index);
    }
    widget.items[index].onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: currentIndex == widget.initalIndex,
      onPopInvoked: (canPop) async {
        if (currentIndex != widget.initalIndex) {
          onNavBarItemTap(widget.initalIndex);
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.onBackgroundColor,
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: pAppNavBarHeight,
            width: context.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    widget.items.length,
                    (index) => BouncyButtonBehavior(
                      onTap: () => onNavBarItemTap(index),
                      child: Container(
                        color: Colors.transparent,
                        width: 125,
                        margin: const EdgeInsets.only(top: 12.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 25,
                                child: currentIndex == index &&
                                        widget.items[index].selectedIcon != null
                                    ? widget.items[index].selectedIcon
                                    : widget.items[index].icon,
                              ),
                              const SizedBox(height: 6),
                              if (widget.items[index].label != null)
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    widget.items[index].label!,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: context.labelLarge.copyWith(
                                      color: currentIndex == index
                                          ? context.primaryColor
                                          : context.onPrimaryColor,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppNavBarItemBuilder {
  final String? label;
  final Widget icon;
  final Widget? selectedIcon;
  final Function()? onTap;
  final bool isNavgationOnly;

  const AppNavBarItemBuilder({
    this.label,
    required this.icon,
    this.selectedIcon,
    this.onTap,
    this.isNavgationOnly = false,
  });
}
