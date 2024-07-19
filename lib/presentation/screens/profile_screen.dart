import 'package:flutter/material.dart';
import 'package:progressofttask/logic/cubit/auth/cubit.dart';
import 'package:progressofttask/models/user.dart';
import 'package:progressofttask/presentation/common/appbar/sub_screen.dart';
import 'package:progressofttask/presentation/common/buttons/locale.dart';
import 'package:progressofttask/presentation/common/buttons/outline.dart';
import 'package:progressofttask/presentation/common/top_fade.dart';
import 'package:progressofttask/utils/extensions/context.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const routeIndex = 1;

  @override
  Widget build(BuildContext context) {
    final user = AuthCubit.get(context).user!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: SubScreenAppBar(
        title: context.translate.profile,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopFadeWidget(
            isAnimate: false,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.name,
                      style: context.titleSmall,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: CircleAvatar(
                        child: Text(
                          user.name.substring(0, 2),
                          style: context.titleLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user.phoneNumber,
                      style: context.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.country,
                          style: context.titleSmall,
                        ),
                        const SizedBox(width: 8),
                        const Text("|"),
                        const SizedBox(width: 8),
                        Text(
                          user.gender == Gender.male
                              ? context.translate.male
                              : context.translate.female,
                          style: context.titleSmall,
                        ),
                        const SizedBox(width: 8),
                        const Text("|"),
                        const SizedBox(width: 8),
                        Text(
                          user.age.toString(),
                          style: context.titleSmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Row(
                      children: [
                        LocaleChangeButton(),
                      ],
                    ),
                    const SizedBox(height: 32),
                    OutlineButton(
                      text: context.translate.logout,
                      color: Colors.red,
                      textColor: Colors.red,
                      onTap: () => AuthCubit.get(context).logout(),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
