import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progressofttask/logic/cubit/app/cubit.dart';
import 'package:progressofttask/logic/cubit/app/states.dart';
import 'package:progressofttask/presentation/common/snackbar.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/lang/locale.dart';
import 'package:progressofttask/utils/theme/images.dart';

class LocaleChangeButton extends StatefulHookWidget {
  const LocaleChangeButton({super.key});

  @override
  State<StatefulWidget> createState() => _LocaleChangeButtonState();
}

class _LocaleChangeButtonState extends State<LocaleChangeButton> {
  Future<void> onProcessing = Future.value();

  @override
  Widget build(BuildContext context) {
    final isLoading = useFuture(onProcessing);

    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, _) {
        final appCubit = AppCubit.get(context);
        final locale = appCubit.appSettings.locale;

        const languages = LocaleService.supportedLocales;

        final unSelectedLocale = languages.firstWhere(
          (element) => element.code != locale,
        );
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                14,
              ),
            ),
            onTap: isLoading.connectionState == ConnectionState.waiting
                ? null
                : () async {
                    try {
                      setState(() {
                        onProcessing = appCubit.updateLocale(unSelectedLocale.code);
                      });
                    } catch (e) {
                      handleException(e);
                    }
                  },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    14,
                  ),
                ),
                border: Border.all(
                  color: context.onPrimaryColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 7.5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      unSelectedLocale.name,
                      style: context.bodySmall,
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(AppImages.translateIcon),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
