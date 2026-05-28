import 'package:blueprint_mobile_flutter/constants/assets_path.dart';
import 'package:blueprint_mobile_flutter/widgets/buttons/edge_border_button_large.dart';
import 'package:blueprint_mobile_flutter/widgets/buttons/edge_border_button_small.dart';
import 'package:blueprint_mobile_flutter/widgets/buttons/edge_button_large.dart';
import 'package:blueprint_mobile_flutter/widgets/buttons/oval_button_medium.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../config/themes/notifiers/theme_manager.dart';
import '../../../../widgets/buttons/edge_border_button_icon.dart';
import '../../../../widgets/buttons/edge_border_button_medium.dart';
import '../../../../widgets/buttons/edge_button_icon.dart';
import '../../../../widgets/buttons/edge_button_medium.dart';
import '../../../../widgets/buttons/edge_button_small.dart';
import '../../../../widgets/buttons/oval_border_button_large.dart';
import '../../../../widgets/buttons/oval_border_button_medium.dart';
import '../../../../widgets/buttons/oval_border_button_small.dart';
import '../../../../widgets/buttons/oval_button_large.dart';
import '../../../../widgets/buttons/oval_button_small.dart';
import '../../../../widgets/default_appbar.dart';
import '../../../../utils/responsive_configuration.dart';

class ButtonBody extends StatefulWidget {
  const ButtonBody({super.key});

  @override
  State<ButtonBody> createState() => _ButtonBodyState();
}

class _ButtonBodyState extends State<ButtonBody> {
  Color colorMain = AppColors.blue_main_500;

  void _openColorPicker() async {
    final selectedColor = await showModalBottomSheet<Color>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Wrap(
              children: [
                StatefulBuilder(builder: (context, StateSetter setState) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26.3.sp),
                        topRight: Radius.circular(26.3.sp),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: pxToSp(context, 25),
                        ),
                        SvgPicture.asset(
                          Assets.indicator,
                        ),
                        SizedBox(
                          height: pxToSp(context, 25),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: pxToSp(context, 25),
                              right: pxToSp(context, 25)),
                          width: 100.w,
                          child: Text(
                            'Change Color',
                            style: AppThemeNotifier.getTextStyleFromTheme(
                              baseStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: pxToSp(context, 25),
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.pop(bc, AppColors.red_main_500),
                          borderRadius: BorderRadius.circular(7.sp),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: pxToSp(context, 25),
                                right: pxToSp(context, 25),
                                bottom: 5.7.sp,
                                top: 5.7.sp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      'Red',
                                      textAlign: TextAlign.left,
                                      style: AppThemeNotifier
                                          .getTextStyleFromTheme(
                                        color: AppColors.red_main_500,
                                        baseStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 14.sp,
                                  height: 14.sp,
                                  decoration: BoxDecoration(
                                    color: AppColors.red_main_500,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: pxToSp(context, 25),
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.pop(bc, AppColors.blue_main_500),
                          borderRadius: BorderRadius.circular(7.sp),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: pxToSp(context, 25),
                                right: pxToSp(context, 25),
                                bottom: 5.7.sp,
                                top: 5.7.sp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      'Blue',
                                      textAlign: TextAlign.left,
                                      style: AppThemeNotifier
                                          .getTextStyleFromTheme(
                                        color: AppColors.blue_main_500,
                                        baseStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 14.sp,
                                  height: 14.sp,
                                  decoration: BoxDecoration(
                                    color: AppColors.blue_main_500,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: pxToSp(context, 25),
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.pop(bc, AppColors.warning_primary_500),
                          borderRadius: BorderRadius.circular(7.sp),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: pxToSp(context, 25),
                                right: pxToSp(context, 25),
                                bottom: 5.7.sp,
                                top: 5.7.sp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      'Yellow',
                                      textAlign: TextAlign.left,
                                      style: AppThemeNotifier
                                          .getTextStyleFromTheme(
                                        color: AppColors.warning_primary_500,
                                        baseStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 14.sp,
                                  height: 14.sp,
                                  decoration: BoxDecoration(
                                    color: AppColors.warning_primary_500,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: pxToSp(context, 25),
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.pop(bc, AppColors.green_main_500),
                          borderRadius: BorderRadius.circular(7.sp),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: pxToSp(context, 25),
                                right: pxToSp(context, 25),
                                bottom: 5.7.sp,
                                top: 5.7.sp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      'Green',
                                      textAlign: TextAlign.left,
                                      style: AppThemeNotifier
                                          .getTextStyleFromTheme(
                                        color: AppColors.green_main_500,
                                        baseStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 14.sp,
                                  height: 14.sp,
                                  decoration: BoxDecoration(
                                    color: AppColors.green_main_500,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18.2.sp,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            );
          },
        );
      },
    );

    if (selectedColor != null) {
      setState(() {
        colorMain = selectedColor;
      });
    }
  }

  _widgetSmall() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              top: pxToSp(context, 25)),
          child: Text(
            "Small",
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 25)),
          alignment: Alignment(-1, 0),
          child: Row(
            children: [
              Text(
                "Edge",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: pxToSp(context, 25), right: pxToSp(context, 25)),
                  child: Divider(
                    height: 1.sp,
                    color: AppColors.disabled_light,
                  ),
                ),
              ),
              Text(
                "Small",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeButtonSmall(
            isFullWidth: true,
            text: 'Submit',
            buttonColor: colorMain,
            onPressed: () {},
            // textSize: 11.7.sp,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeButtonSmall(
            isFullWidth: true,
            text: 'Submit',
            buttonColor: colorMain,
            icon: Assets.edit,
            iconColor: AppColors.white_FFFFFF,
            onPressed: () {},
            // textSize: 11.7.sp,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeBorderButtonSmall(
            text: "Submit",
            isFullWidth: true,
            textColor: colorMain,
            borderColor: colorMain,
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeBorderButtonSmall(
            text: "Submit",
            isFullWidth: true,
            icon: Assets.edit,
            iconColor: colorMain,
            textColor: colorMain,
            borderColor: colorMain,
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 25)),
          alignment: Alignment(-1, 0),
          child: Row(
            children: [
              Text(
                "Oval",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: pxToSp(context, 25), right: pxToSp(context, 25)),
                  child: Divider(
                    height: 1.sp,
                    color: AppColors.disabled_light,
                  ),
                ),
              ),
              Text(
                "Small",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalButtonSmall(
            isFullWidth: true,
            text: 'Submit',
            buttonColor: colorMain,
            onPressed: () {},
            // textSize: 11.7.sp,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalButtonSmall(
            isFullWidth: true,
            text: 'Submit',
            buttonColor: colorMain,
            icon: Assets.edit,
            iconColor: AppColors.white_FFFFFF,
            onPressed: () {},
            // textSize: 11.7.sp,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalBorderButtonSmall(
            text: "Submit",
            isFullWidth: true,
            textColor: colorMain,
            borderColor: colorMain,
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalBorderButtonSmall(
            text: "Submit",
            isFullWidth: true,
            icon: Assets.edit,
            iconColor: colorMain,
            textColor: colorMain,
            borderColor: colorMain,
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 25)),
          alignment: Alignment(-1, 0),
          child: Row(
            children: [
              Text(
                "Icon Edge",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: pxToSp(context, 25), right: pxToSp(context, 25)),
                  child: Divider(
                    height: 1.sp,
                    color: AppColors.disabled_light,
                  ),
                ),
              ),
              Text(
                "Small",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeButtonIcon(
            icon: Assets.edit,
            onPressed: () {},
            sizeIcon: pxToSp(context, 25),
            iconColor: Colors.white,
            isFullWidth: false,
            buttonColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeBorderButtonIcon(
            icon: Assets.edit,
            onPressed: () {},
            sizeIcon: pxToSp(context, 25),
            iconColor: colorMain,
            isFullWidth: false,
            buttonColor: AppColors.white_FFFFFF,
          ),
        ),
      ],
    );
  }

  _widgetMedium() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              top: 14.sp),
          child: Divider(
            height: 5.sp,
            color: AppColors.disabled_light,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              top: 14.sp),
          child: Text(
            "Medium",
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 25)),
          alignment: Alignment(-1, 0),
          child: Row(
            children: [
              Text(
                "Edge",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: pxToSp(context, 25), right: pxToSp(context, 25)),
                  child: Divider(
                    height: 1.sp,
                    color: AppColors.disabled_light,
                  ),
                ),
              ),
              Text(
                "Medium",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeButtonMedium(
            text: "Submit",
            onPressed: () {},
            isFullWidth: true,
            textColor: Colors.white,
            buttonColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeButtonMedium(
            text: "Submit",
            onPressed: () {},
            isFullWidth: true,
            textColor: Colors.white,
            icon: Assets.edit,
            iconColor: AppColors.white_FFFFFF,
            buttonColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeBorderButtonMedium(
            text: "Submit",
            isFullWidth: true,
            textColor: colorMain,
            borderColor: colorMain,
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeBorderButtonMedium(
            text: "Submit",
            isFullWidth: true,
            icon: Assets.edit,
            iconColor: colorMain,
            textColor: colorMain,
            borderColor: colorMain,
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 25)),
          alignment: Alignment(-1, 0),
          child: Row(
            children: [
              Text(
                "Oval",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: pxToSp(context, 25), right: pxToSp(context, 25)),
                  child: Divider(
                    height: 1.sp,
                    color: AppColors.disabled_light,
                  ),
                ),
              ),
              Text(
                "Medium",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalButtonMedium(
            text: "Submit",
            onPressed: () {},
            isFullWidth: true,
            textColor: Colors.white,
            buttonColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalButtonMedium(
            text: "Submit",
            onPressed: () {},
            isFullWidth: true,
            textColor: Colors.white,
            icon: Assets.edit,
            iconColor: AppColors.white_FFFFFF,
            buttonColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalBorderButtonMedium(
            text: "Submit",
            isFullWidth: true,
            onPressed: () {},
            textColor: colorMain,
            borderColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalBorderButtonMedium(
            text: "Submit",
            isFullWidth: true,
            icon: Assets.edit,
            iconColor: colorMain,
            textColor: colorMain,
            borderColor: colorMain,
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 25)),
          alignment: Alignment(-1, 0),
          child: Row(
            children: [
              Text(
                "Icon Edge",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: pxToSp(context, 25), right: pxToSp(context, 25)),
                  child: Divider(
                    height: 1.sp,
                    color: AppColors.disabled_light,
                  ),
                ),
              ),
              Text(
                "Medium",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeButtonIcon(
            icon: Assets.edit,
            onPressed: () {},
            sizeIcon: 14.sp,
            iconColor: Colors.white,
            isFullWidth: false,
            buttonColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeBorderButtonIcon(
            icon: Assets.edit,
            onPressed: () {},
            sizeIcon: 14.sp,
            iconColor: colorMain,
            isFullWidth: false,
            buttonColor: AppColors.white_FFFFFF,
          ),
        ),
      ],
    );
  }

  _widgetLarge() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              top: 14.sp),
          child: Divider(
            height: 5.sp,
            color: AppColors.disabled_light,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              top: 14.sp),
          child: Text(
            "Large",
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 25)),
          alignment: Alignment(-1, 0),
          child: Row(
            children: [
              Text(
                "Edge",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: pxToSp(context, 25), right: pxToSp(context, 25)),
                  child: Divider(
                    height: 1.sp,
                    color: AppColors.disabled_light,
                  ),
                ),
              ),
              Text(
                "Large",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeButtonLarge(
            text: "Submit",
            onPressed: () {},
            isFullWidth: true,
            textColor: Colors.white,
            buttonColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeButtonLarge(
            text: "Submit",
            onPressed: () {},
            isFullWidth: true,
            textColor: Colors.white,
            icon: Assets.edit,
            iconColor: AppColors.white_FFFFFF,
            buttonColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeBorderButtonLarge(
            text: "Submit",
            isFullWidth: true,
            textColor: colorMain,
            borderColor: colorMain,
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeBorderButtonLarge(
            text: "Submit",
            isFullWidth: true,
            icon: Assets.edit,
            iconColor: colorMain,
            textColor: colorMain,
            borderColor: colorMain,
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 25)),
          alignment: Alignment(-1, 0),
          child: Row(
            children: [
              Text(
                "Oval",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: pxToSp(context, 25), right: pxToSp(context, 25)),
                  child: Divider(
                    height: 1.sp,
                    color: AppColors.disabled_light,
                  ),
                ),
              ),
              Text(
                "Large",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalButtonLarge(
            text: "Submit",
            onPressed: () {},
            isFullWidth: true,
            textColor: Colors.white,
            buttonColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalButtonLarge(
            text: "Submit",
            onPressed: () {},
            isFullWidth: true,
            textColor: Colors.white,
            icon: Assets.edit,
            iconColor: AppColors.white_FFFFFF,
            buttonColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalBorderButtonLarge(
            text: "Submit",
            isFullWidth: true,
            textColor: colorMain,
            borderColor: colorMain,
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: OvalBorderButtonLarge(
            text: "Submit",
            isFullWidth: true,
            icon: Assets.edit,
            iconColor: colorMain,
            textColor: colorMain,
            borderColor: colorMain,
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 25)),
          alignment: Alignment(-1, 0),
          child: Row(
            children: [
              Text(
                "Icon Edge",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: pxToSp(context, 25), right: pxToSp(context, 25)),
                  child: Divider(
                    height: 1.sp,
                    color: AppColors.disabled_light,
                  ),
                ),
              ),
              Text(
                "Large",
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeButtonIcon(
            icon: Assets.edit,
            onPressed: () {},
            sizeIcon: 18.sp,
            iconColor: Colors.white,
            isFullWidth: false,
            buttonColor: colorMain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: pxToSp(context, 25)),
          child: EdgeBorderButtonIcon(
            icon: Assets.edit,
            onPressed: () {},
            sizeIcon: 18.sp,
            iconColor: colorMain,
            isFullWidth: false,
            buttonColor: AppColors.white_FFFFFF,
          ),
        ),
      ],
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _widgetSmall(),
          _widgetMedium(),
          _widgetLarge(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: DefaultAppBar(
        context: context,
        textTitle: 'Button',
        showBackButton: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5.7.sp, left: pxToSp(context, 25)),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                setState(() {
                  _openColorPicker();
                });
              },
            ),
          ),
        ],
      ),
      body: _body(),
    );
  }
}
