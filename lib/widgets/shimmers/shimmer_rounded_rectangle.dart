import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/themes/app_colors.dart';

// Loading shimmer rounded rectangle
class ShimmerRoundedRectangle extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerRoundedRectangle(
      {Key? key,
      required this.width,
      required this.height,
      this.borderRadius = 10.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).disabledColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      baseColor: Theme.of(context).disabledColor.withValues(alpha: 0.5),
      highlightColor: Theme.of(context).disabledColor,
    );
  }
}
