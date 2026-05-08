import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/language/app_localizations.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/notifiers/theme_manager.dart';
import '../buttons/edge_button_small.dart';

class DialogSuccess extends StatelessWidget {
  const DialogSuccess(
      {Key? key,
      required this.onSubmit,
      required this.title,
      required this.desc})
      : super(key: key);

  final VoidCallback onSubmit;
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
            Container(
              margin: EdgeInsets.only(bottom: 11.5.sp),
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            EdgeButtonSmall(
              isFullWidth: true,
              text: GetAppLocalizations(context).back,
              buttonColor: AppColors.accent_light,
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showDialogError({
  required BuildContext context,
  required String title,
  required String desc,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext bc) {
      return DialogSuccess(
        title: title,
        desc: desc,
        onSubmit: () {
          Navigator.pop(bc);
        },
      );
    },
  );
}
