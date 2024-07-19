import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/theme/colors.dart';

class _BottomSheet extends StatelessWidget {
  final Widget child;
  final bool isModal;
  final Animation<double> animation;
  final bool isFullPage;
  final double? topPadding;
  static double sheetRadius = 32.0;
  const _BottomSheet({
    required this.child,
    required this.isModal,
    required this.animation,
    required this.isFullPage,
    this.topPadding,
  });

  @override
  Widget build(BuildContext context) {
    if (isFullPage) {
      return CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        child: child,
      );
    } else {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: CupertinoPageScaffold(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: topPadding),
              const SafeArea(
                bottom: false,
                child: SizedBox.shrink(),
              ),
              Flexible(
                flex: isModal ? 0 : 1,
                fit: FlexFit.loose,
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        sheetRadius,
                      ),
                      topRight: Radius.circular(
                        sheetRadius,
                      ),
                    ),
                    side: BorderSide(
                      width: 1,
                      color: AppColors.muted,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        sheetRadius,
                      ),
                      topRight: Radius.circular(
                        sheetRadius,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.backgroundColor,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black12,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

Future<T?> showSheetPage<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color barrierColor = Colors.black87,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool isModal = false,
  bool replacePreviousPage = false,
  bool isFullPage = false,
  double topPadding = 44,
}) async {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));
  if (replacePreviousPage) {
    Navigator.of(context).pop();
  }
  return await Navigator.of(context, rootNavigator: useRootNavigator).push(
    CupertinoModalBottomSheetRoute<T>(
      builder: builder,
      containerBuilder: (_, animation, child) => _BottomSheet(
        isModal: isModal,
        animation: animation,
        isFullPage: isFullPage,
        topPadding: topPadding,
        child: child,
      ),
      bounce: true,
      expanded: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      isDismissible: isDismissible,
      modalBarrierColor: barrierColor,
      enableDrag: enableDrag,
    ),
  );
}
