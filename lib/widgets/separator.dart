import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// this widget using for line in modal bottom sheet
class Separator extends StatelessWidget {
  final height, width, color;

  Separator({this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(11.5.sp),
        ),
      ),
    );
  }
}
