import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/notifiers/theme_manager.dart';
import '../../utils/responsive_configuration.dart';

// Widget edge button default
class OvalBorderButtonLarge extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? buttonColor, borderColor, textColor, iconColor;
  final bool isFullWidth;
  final String? icon;
  final double? textSize;
  final double? padding;
  Widget? iconLeft;
  Widget? customText;
  MainAxisAlignment alignment;
  EdgeInsets? paddingContent;
  BorderSide? borderSide;

  OvalBorderButtonLarge({
    required this.text,
    this.onPressed,
    this.buttonColor = AppColors.white_FFFFFF,
    this.borderColor = AppColors.accent_light,
    this.iconColor,
    this.textColor = AppColors.accent_light,
    this.isFullWidth = false,
    this.icon,
    this.textSize,
    this.padding,
    this.customText,
    this.iconLeft,
    this.alignment = MainAxisAlignment.center,
    this.paddingContent,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isFullWidth
          ? SizedBox(
              width: 100.w,
              child: _makeButton(context),
            )
          : _makeButton(context),
    );
  }

  Widget _makeButton(BuildContext context) {
    if (paddingContent == null) {
      paddingContent = EdgeInsets.all(11.sp);
    }

    if (borderSide == null) {
      borderSide = BorderSide(
        width: 0,
        color: Colors.transparent,
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: pxToSp(context, 2),
            color: borderColor ?? AppColors.accent_light,
          ),
          borderRadius: BorderRadius.circular(30.sp),
        ),
        padding: paddingContent,
        elevation: 0,
        fixedSize: Size.fromHeight(32.sp),
      ),
      onPressed: onPressed,
      child: (icon != null)
          ? Row(
              mainAxisAlignment: alignment,
              children: [
                if (iconLeft != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.sp),
                    child: iconLeft!,
                  ),
                if (icon != null)
                  SvgPicture.asset(
                    icon!,
                    width: pxToSp(context, 25),
                    colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
                  ),
                if (icon != null) SizedBox(width: 12.sp),
                Flexible(
                  child: customText ??
                      Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        style: AppThemeNotifier.getTextStyleFromTheme(
                          baseStyle: Theme.of(context).textTheme.bodyLarge,
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: textSize ?? pxToSp(context, 18),
                        ),
                      ),
                ),
              ],
            )
          : Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: AppThemeNotifier.getTextStyleFromTheme(
                baseStyle: Theme.of(context).textTheme.bodyLarge,
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: textSize ?? pxToSp(context, 18),
              ),
            ),
    );
  }
}
