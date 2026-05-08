import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/responsive_configuration.dart';
// Widget edge button using icon small
class EdgeButtonIcon extends StatelessWidget {
  final String icon;
  final VoidCallback? onPressed;
  final double? sizeIcon;
  final Color buttonColor, iconColor;
  final bool isFullWidth;

  EdgeButtonIcon({
    required this.icon,
    required this.sizeIcon,
    required this.buttonColor,
    this.onPressed,
    this.iconColor = Colors.white,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isFullWidth
          ? SizedBox(
              width: double.infinity,
              child: _makeButton(context),
            )
          : SizedBox(
              child: _makeButton(context),
            ),
    );
  }

  Widget _makeButton(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      child: Container(
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(pxToSp(context, 12)),
                side: BorderSide(
                  color: buttonColor,
                  width: pxToSp(context, 1),
                )),
            color: buttonColor),
        padding: EdgeInsets.all(pxToSp(context, 18)),
        child: SvgPicture.asset(
          icon,
          height: sizeIcon,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
