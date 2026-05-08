import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/language/app_localizations.dart';
import '../../config/themes/notifiers/theme_manager.dart';
import '../buttons/edge_border_button_medium.dart';
import '../buttons/edge_button_medium.dart';
import '../../utils/responsive_configuration.dart';

class DialogExitApp extends StatelessWidget {
  const DialogExitApp({
    Key? key,
    required this.onSubmit,
    required this.onCancel,
  }) : super(key: key);

  final VoidCallback? onSubmit, onCancel;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
        title: Text(
          GetAppLocalizations(context).areYouSure,
          textAlign: TextAlign.center,
          style: AppThemeNotifier.getTextStyleFromTheme(
            baseStyle: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              GetAppLocalizations(context).exitApp,
              style: AppThemeNotifier.getTextStyleFromTheme(
                baseStyle: Theme.of(context).textTheme.bodyMedium,
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
                    onPressed: onCancel,
                    text: GetAppLocalizations(context).cancel,
                  ),
                ),
                SizedBox(
                  width: 12.sp,
                ),
                Expanded(
                  child: EdgeBorderButtonMedium(
                    onPressed: onSubmit,
                    text: GetAppLocalizations(context).yes,
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
