import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/notifiers/theme_manager.dart';
import '../../utils/responsive_configuration.dart';

// Widget edge button default
class EdgeButtonLarge extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? buttonColor, textColor, iconColor;
  final bool isFullWidth;
  final String? icon;
  final double? textSize;
  final double? padding;
  Widget? iconLeft;
  Widget? customText;
  MainAxisAlignment alignment;
  EdgeInsets? paddingContent;
  BorderSide? borderSide;

  EdgeButtonLarge({
    required this.text,
    this.onPressed,
    this.buttonColor = AppColors.accent_light,
    this.iconColor,
    this.textColor = Colors.white,
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
      paddingContent = EdgeInsets.all(pxToSp(context, 12));
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
            borderRadius: BorderRadius.circular(pxToSp(context, 12)),
            side: borderSide!),
        padding: paddingContent,
        elevation: 0,
        fixedSize: Size.fromHeight(pxToSp(context, 32)),
      ),
      onPressed: onPressed,
      child: (icon != null)
          ? Row(
              mainAxisAlignment: alignment,
              children: [
                if (iconLeft != null)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: pxToSp(context, 4)),
                    child: iconLeft!,
                  ),
                if (icon != null)
                  SvgPicture.asset(
                    icon!,
                    width: pxToSp(context, 18),
                    colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
                  ),
                if (icon != null) SizedBox(width: pxToSp(context, 12)),
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
