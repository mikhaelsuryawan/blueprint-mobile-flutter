import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/themes/notifiers/theme_manager.dart';
import '../../constants/assets_path.dart';
import '../../utils/responsive_configuration.dart';

// Default widget Chevron menu
class MenuChevron extends StatelessWidget {
  final String asset;
  final String text;
  final VoidCallback? onPressed;

  MenuChevron({
    required this.asset,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(pxToSp(context, 12)),
      splashColor: Theme.of(context).colorScheme.primary,
      highlightColor: Theme.of(context).colorScheme.primary,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
            top: pxToSp(context, 12),
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
            bottom: pxToSp(context, 12)),
        child: Row(
          children: [
            SvgPicture.asset(
              asset,
              width: pxToSp(context, 20),
              height: pxToSp(context, 20),
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: pxToSp(context, 18)),
                child: Text(
                  text,
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    baseStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
            SvgPicture.asset(
              Assets.chevronRight,
              width: pxToSp(context, 20),
              height: pxToSp(context, 20),
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
