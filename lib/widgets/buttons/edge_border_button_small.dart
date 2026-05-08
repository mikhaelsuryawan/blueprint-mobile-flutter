import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/notifiers/theme_manager.dart';
import '../../utils/responsive_configuration.dart';

// Widget edge border button small
class EdgeBorderButtonSmall extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? buttonColor, borderColor, textColor, iconColor;
  final bool isFullWidth;
  final String? icon;
  final double? textSize;
  final double? padding;
  Widget? customText;
  MainAxisAlignment alignment;
  EdgeInsets? paddingContent;
  BorderSide? borderSide;

  EdgeBorderButtonSmall({
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
    this.alignment = MainAxisAlignment.center,
    this.paddingContent,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isFullWidth
          ? SizedBox(
              width: 100.h,
              child: _makeButton(context),
            )
          : _makeButton(context),
    );
  }

  Widget _makeButton(BuildContext context) {
    if (paddingContent == null) {
      paddingContent = EdgeInsets.symmetric(horizontal: pxToSp(context, 16));
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
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: pxToSp(context, 2),
            color: borderColor ?? AppColors.accent_light,
          ),
          borderRadius: BorderRadius.circular(pxToSp(context, 12)),
        ),
        padding: paddingContent,
        elevation: 0,
        fixedSize: Size.fromHeight(pxToSp(context, 24)),
      ),
      onPressed: onPressed,
      child: (icon != null)
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: alignment,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  SvgPicture.asset(
                    icon ?? '',
                    width: pxToSp(context, 20),
                    colorFilter: ColorFilter.mode(
                        iconColor ?? AppColors.accent_light, BlendMode.srcIn),
                  ),
                if (icon != null) SizedBox(width: pxToSp(context, 8)),
                Flexible(
                  child: customText ??
                      Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppThemeNotifier.getTextStyleFromTheme(
                          baseStyle: Theme.of(context).textTheme.bodySmall,
                          color: textColor,
                          fontSize: textSize ?? pxToSp(context, 14),
                        ),
                      ),
                ),
              ],
            )
          : Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: AppThemeNotifier.getTextStyleFromTheme(
                baseStyle: Theme.of(context).textTheme.bodySmall,
                color: textColor,
                fontSize: textSize ?? pxToSp(context, 14),
              ),
            ),
    );
  }
}
