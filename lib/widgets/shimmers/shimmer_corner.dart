import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Loading shimmer corner
class ShimmerCorner extends StatelessWidget {
  final double height, width, radius;
  final baseColor, highlightColor;

  ShimmerCorner({
    required this.height,
    required this.width,
    this.radius = 30.0,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).disabledColor,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      baseColor: baseColor,
      highlightColor: highlightColor,
    );
  }
}
