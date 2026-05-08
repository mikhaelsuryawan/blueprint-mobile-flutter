import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Design `px` (passed to [pxToSp]) → mobile diagonal exponent.
/// Stops are descending in px; values between stops are linearly interpolated.
/// Below / above the table clamps to the 14 / 24 exponents.
const List<double> _mobileExponentPxStops = [
  50.0,
  48.0,
  46.0,
  44.0,
  42.0,
  40.0,
  38.0,
  36.0,
  34.0,
  32.0,
  30.0,
  28.0,
  26.0,
  24.0,
  22.0,
  20.0,
  18.0,
  16.0,
  14.0,
  12.0,
  10.0,
  8.0,
  6.0,
  4.0,
  2.0,
];
const List<double> _mobileExponentValues = [
  1.948,
  1.941,
  1.934,
  1.927,
  1.919,
  1.911,
  1.903,
  1.895,
  1.886,
  1.876,
  1.865,
  1.855,
  1.843,
  1.829,
  1.816,
  1.801,
  1.785,
  1.764,
  1.743,
  1.718,
  1.688,
  1.653,
  1.610,
  1.542,
  1.434,
];

/// Default mobile exponent when no segment matches (matches 18px row).
const double _mobileExponentFallback = 1.829;

/// Design `px` (passed to [pxToSp]) → tablet diagonal exponent.
/// Keeps tablet scaling smooth across text-size bands instead of one fixed value.
const List<double> _tabletExponentPxStops = [
  50.0,
  48.0,
  46.0,
  44.0,
  42.0,
  40.0,
  38.0,
  36.0,
  34.0,
  32.0,
  30.0,
  28.0,
  26.0,
  24.0,
  22.0,
  20.0,
  18.0,
  16.0,
  14.0,
  12.0,
];
const List<double> _tabletExponentValues = [
  2.196,
  2.190,
  2.183,
  2.176,
  2.169,
  2.161,
  2.153,
  2.145,
  2.135,
  2.125,
  2.115,
  2.105,
  2.092,
  2.080,
  2.066,
  2.051,
  2.034,
  2.015,
  1.995,
  1.970,
];

/// Default tablet exponent when no segment matches (matches 18px row).
const double _tabletExponentFallback = 2.055;

double _mobileExponentForPx(double px) {
  final pxStops = _mobileExponentPxStops;
  final exponents = _mobileExponentValues;
  if (pxStops.isEmpty || pxStops.length != exponents.length) {
    return _mobileExponentFallback;
  }

  if (px >= pxStops.first) return exponents.first;
  if (px <= pxStops.last) return exponents.last;

  for (var i = 0; i < pxStops.length - 1; i++) {
    final upperPx = pxStops[i];
    final lowerPx = pxStops[i + 1];
    if (px <= upperPx && px >= lowerPx) {
      final span = upperPx - lowerPx;
      if (span <= 0) return exponents[i + 1];
      final t = (px - lowerPx) / span;
      return exponents[i + 1] + t * (exponents[i] - exponents[i + 1]);
    }
  }

  return _mobileExponentFallback;
}

double _tabletExponentForPx(double px) {
  final pxStops = _tabletExponentPxStops;
  final exponents = _tabletExponentValues;
  if (pxStops.isEmpty || pxStops.length != exponents.length) {
    return _tabletExponentFallback;
  }

  if (px >= pxStops.first) return exponents.first;
  if (px <= pxStops.last) return exponents.last;

  for (var i = 0; i < pxStops.length - 1; i++) {
    final upperPx = pxStops[i];
    final lowerPx = pxStops[i + 1];
    if (px <= upperPx && px >= lowerPx) {
      final span = upperPx - lowerPx;
      if (span <= 0) return exponents[i + 1];
      final t = (px - lowerPx) / span;
      return exponents[i + 1] + t * (exponents[i] - exponents[i + 1]);
    }
  }

  return _tabletExponentFallback;
}

/// Sizer Version 3.1.3
/// Converts logical pixels to scale-independent sp (scaled pixels).
/// Uses [Device.screenType] (sizer) to pick mobile vs tablet formula.
/// Call only from within a widget that is under [Sizer] (e.g. below MaterialApp).
double pxToSp(BuildContext context, double px) {
  final mediaQueryData = MediaQuery.of(context);
  final pixelRatio = mediaQueryData.devicePixelRatio;
  final screenWidth = mediaQueryData.size.width;
  final screenHeightInches = mediaQueryData.size.height / pixelRatio;
  final screenWidthInches = screenWidth / pixelRatio;

  final isTablet =
      screenWidth > 600 ? true : Device.screenType == ScreenType.tablet;

  final exponent = isTablet ? _tabletExponentForPx(px) : _mobileExponentForPx(px);

  final screenDiagonal = sqrt(
      pow(screenWidthInches, exponent) + pow(screenHeightInches, exponent));

  final sp = px / (pixelRatio * screenDiagonal / screenWidth);
  return sp.sp;
}
