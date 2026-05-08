import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/language/app_localizations.dart';
import '../../config/routes/go_route_generator.dart';
import '../../config/themes/notifiers/theme_manager.dart';
import '../buttons/edge_border_button_medium.dart';
import '../buttons/edge_button_medium.dart';
import '../../utils/responsive_configuration.dart';

class DialogDelete extends StatelessWidget {
  const DialogDelete(
      {Key? key,
      required this.onSubmitYes,
      required this.title,
      required this.desc})
      : super(key: key);

  final VoidCallback onSubmitYes;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: AlertDialog(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: AppThemeNotifier.getTextStyleFromTheme(
            baseStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              desc,
              style: AppThemeNotifier.getTextStyleFromTheme(
                baseStyle: Theme.of(context).textTheme.bodySmall,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: pxToSp(context, 25),
            ),
            Row(
              children: [
                Expanded(
                  child: EdgeButtonMedium(
                    text: GetAppLocalizations(context).cancel,
                    onPressed: () {
                      context.popRoute();
                    },
                    isFullWidth: false,
                  ),
                ),
                SizedBox(
                  width: 12.sp,
                ),
                Expanded(
                  child: EdgeBorderButtonMedium(
                    text: GetAppLocalizations(context).delete,
                    onPressed: () {
                      onSubmitYes.call();
                      context.popRoute();
                    },
                    isFullWidth: false,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> showDialogDelete({
  required BuildContext context,
  required VoidCallback onSubmitYes,
  required String title,
  required String desc,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext bc) {
      return DialogDelete(
        title: title,
        desc: desc,
        onSubmitYes: onSubmitYes,
      );
    },
  );
}
