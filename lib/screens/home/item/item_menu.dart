import 'package:blueprint_mobile_flutter/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/notifiers/theme_manager.dart';
import '../../../core/models/menu/menu_model.dart';
import '../../../utils/responsive_configuration.dart';

class ItemMenu extends StatelessWidget {
  const ItemMenu({Key? key, required this.menuModel, required this.onTap})
      : super(key: key);

  final MenuModel menuModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 5,
      shadowColor: AppColors.gray_primary_300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.7.sp),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11.7.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: pxToSp(context, 25), right: pxToSp(context, 25), bottom: 12.sp, top: 12.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            menuModel.name,
                            textAlign: TextAlign.left,
                            style: AppThemeNotifier.getTextStyleFromTheme(
                              baseStyle:
                                  Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        Assets.chevronRight,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
