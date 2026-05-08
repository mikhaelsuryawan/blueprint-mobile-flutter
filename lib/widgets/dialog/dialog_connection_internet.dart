import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/language/app_localizations.dart';
import '../../config/themes/notifiers/theme_manager.dart';
import '../buttons/edge_button_small.dart';

class DialogConnectionInternet extends StatelessWidget {
  const DialogConnectionInternet({Key? key, required this.onSubmitYes})
      : super(key: key);

  final VoidCallback onSubmitYes;

  @override
  Widget build(BuildContext context) {
    return DialogCancelReasonBody(onSubmitYes: onSubmitYes);
  }
}

class DialogCancelReasonBody extends StatefulWidget {
  DialogCancelReasonBody({Key? key, required this.onSubmitYes})
      : super(key: key);
  final VoidCallback onSubmitYes;

  @override
  _DialogCancelReasonBodyState createState() => _DialogCancelReasonBodyState();
}

class _DialogCancelReasonBodyState extends State<DialogCancelReasonBody> {
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
          GetAppLocalizations(context).connectionDialogTitle,
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
                GetAppLocalizations(context).connectionDialogCheckInternet,
                textAlign: TextAlign.center,
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            EdgeButtonSmall(
              isFullWidth: true,
              text: GetAppLocalizations(context).ok,
              onPressed: widget.onSubmitYes,
            ),
          ],
        ),
      ),
    );
  }
}
