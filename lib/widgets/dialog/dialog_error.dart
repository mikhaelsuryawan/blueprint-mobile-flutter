import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../config/language/app_localizations.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/notifiers/theme_manager.dart';
import '../../constants/assets_path.dart';
import '../buttons/edge_button_medium.dart';
import '../../utils/responsive_configuration.dart';

class DialogError extends StatelessWidget {
  const DialogError({
    Key? key,
    required this.onSubmit,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.4.sp),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColors.white_FFFFFF,
                borderRadius: BorderRadius.all(Radius.circular(12.sp)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: pxToSp(context, 25)),
                      child: Lottie.asset(
                        Assets.loadingLottie,
                        width: 20.w,
                        height: 20.w,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        right: pxToSp(context, 25),
                        left: pxToSp(context, 25),
                        bottom: 12.sp,
                      ),
                      child: Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: AppThemeNotifier.getTextStyleFromTheme(
                          baseStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: pxToSp(context, 25),
                      left: pxToSp(context, 25),
                    ),
                    color: AppColors.gray_primary_100,
                    height: 0.5.sp,
                    width: 100.w,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 7.sp,
                      bottom: 25.5.sp,
                      right: 17.5.sp,
                      left: 17.5.sp,
                    ),
                    child: Text(
                      GetAppLocalizations(context).back,
                      textAlign: TextAlign.center,
                      style: AppThemeNotifier.getTextStyleFromTheme(
                        fontSize: 5.4.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.neutral_surface_800,
                        baseStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 7.sp),
              child: EdgeButtonMedium(
                isFullWidth: true,
                text: GetAppLocalizations(context).back,
                buttonColor: AppColors.accent_light,
                onPressed: onSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
