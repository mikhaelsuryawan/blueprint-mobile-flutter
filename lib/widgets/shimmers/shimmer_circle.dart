import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

// Loading shimmer Circle
class ShimmerCircle extends StatelessWidget {
  final double radius;

  const ShimmerCircle({Key? key, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: CircleAvatar(
        radius: 25.sp,
      ),
      baseColor: Theme.of(context).disabledColor.withValues(alpha: 0.5),
      highlightColor: Theme.of(context).disabledColor,
    );
  }
}
