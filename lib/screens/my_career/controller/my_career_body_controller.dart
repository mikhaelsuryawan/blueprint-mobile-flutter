import 'package:blueprint_mobile_flutter/core/models/career/response/career_entry.dart';
import 'package:flutter/material.dart';

/// Owns timeline data and entrance / background animations for My Career.
class MyCareerBodyController {
  MyCareerBodyController({required TickerProvider vsync}) {
    bgCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 18),
    )..repeat(reverse: true);

    staggerCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  late final AnimationController bgCtrl;
  late final AnimationController staggerCtrl;

  final List<CareerEntry> entries = <CareerEntry>[
    CareerEntry(
      startPeriod: '2016',
      endPeriod: '2018',
      company: 'WIT',
      role: 'Network Engineer',
    ),
    CareerEntry(
      startPeriod: '2018',
      endPeriod: '2022',
      company: 'WIT',
      role: 'Mobile Developer',
    ),
    CareerEntry(
      startPeriod: '2022',
      endPeriod: 'Present',
      company: 'WIT',
      role: 'Head of Mobile Developer',
    ),
  ];

  void dispose() {
    bgCtrl.dispose();
    staggerCtrl.dispose();
  }
}
