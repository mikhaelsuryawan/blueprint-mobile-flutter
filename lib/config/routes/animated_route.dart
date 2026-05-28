import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppTransition {
  material,
  cupertino,
  fade,
  slideRight,
  slideUp,
  scale,
  none
}

Route animatedRoute(
  Widget page,
  RouteSettings settings, {
  AppTransition transition = AppTransition.material,
  Duration duration = const Duration(milliseconds: 300),
}) {
  switch (transition) {
    case AppTransition.material:
      // Platform default (MaterialPageRoute) with platform animations
      return MaterialPageRoute(builder: (_) => page, settings: settings);

    case AppTransition.cupertino:
      // iOS-style push (also works on Android if you prefer)
      return CupertinoPageRoute(builder: (_) => page, settings: settings);

    case AppTransition.none:
      // No animation
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        settings: settings,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (_, __, ___, child) => child,
      );

    default:
      // Custom transitions via PageRouteBuilder
      return PageRouteBuilder(
        settings: settings,
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved =
              CurvedAnimation(parent: animation, curve: Curves.easeInOut);

          switch (transition) {
            case AppTransition.fade:
              return FadeTransition(opacity: curved, child: child);

            case AppTransition.slideRight:
              return SlideTransition(
                position: curved.drive(
                    Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)),
                child: child,
              );

            case AppTransition.slideUp:
              return SlideTransition(
                position: curved.drive(Tween<Offset>(
                    begin: const Offset(0, 0.1), end: Offset.zero)),
                child: child,
              );

            case AppTransition.scale:
              return ScaleTransition(scale: curved, child: child);

            // fallbacks
            case AppTransition.material:
            case AppTransition.cupertino:
            case AppTransition.none:
              return child;
          }
        },
      );
  }
}
