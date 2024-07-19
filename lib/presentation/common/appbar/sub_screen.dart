import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progressofttask/presentation/common/direction_aware.dart';
import 'package:progressofttask/utils/constants.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/theme/images.dart';

class SubScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isWithBackButton;
  const SubScreenAppBar({
    super.key,
    required this.title,
    this.isWithBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      // toolbarHeight: pAppBarHeight,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: context.titleMedium,
      ),
      surfaceTintColor: Colors.transparent,
      leading: context.navigator.canPop() && isWithBackButton
          ? IconButton(
              icon: SizedBox(
                width: 24,
                height: 24,
                child: Center(
                  child: DirectionAware(
                    child: SvgPicture.asset(
                      AppImages.backArrow,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                context.navigator.pop();
              },
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(pAppBarHeight);
}
