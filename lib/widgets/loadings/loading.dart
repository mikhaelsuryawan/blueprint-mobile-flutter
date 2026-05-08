import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/responsive_configuration.dart';

// Widget loading for button
class Loading extends StatelessWidget {
  final bool isShow;
  final color;

  const Loading({
    Key? key,
    required this.isShow,
    this.color = AppColors.accent_light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isShow,
      child: Container(
        margin: EdgeInsets.all(pxToSp(context, 11.5)),
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: color,
          size: pxToSp(context, 28),
        ),
      ),
    );
  }
}
