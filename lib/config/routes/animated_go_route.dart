/// This file contains GoRouter page builder with animated transitions
/// Helper function to create GoRouter pages with custom animated transitions
/// This seamlessly integrates with the existing animatedRoute system
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppTransition {
  material,
  cupertino,
  fade,
  slideRight,
  slideUp,
  scale,
  none
}

/// Helper function to create a GoRouter page with custom animated transitions
/// This seamlessly integrates with the existing animatedRoute system
Page<T> buildAnimatedPage<T extends Object?>({
  required Widget child,
  required String name,
  required AppTransition transition,
  Duration duration = const Duration(milliseconds: 300),
  Object? arguments,
  LocalKey? key,
}) {
  // Handle different transition types directly
  switch (transition) {
    case AppTransition.material:
      return MaterialPage<T>(
        key: key,
        name: name,
        arguments: arguments,
        child: child,
      );

    case AppTransition.cupertino:
      return NoTransitionPage<T>(
        key: key,
        name: name,
        arguments: arguments,
        child: child,
      );

    case AppTransition.none:
      return NoTransitionPage<T>(
        key: key,
        name: name,
        arguments: arguments,
        child: child,
      );

    // Custom transitions using CustomTransitionPage
    case AppTransition.fade:
    case AppTransition.slideRight:
    case AppTransition.slideUp:
    case AppTransition.scale:
      return CustomTransitionPage<T>(
        key: key,
        name: name,
        arguments: arguments,
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );

          switch (transition) {
            case AppTransition.fade:
              return FadeTransition(opacity: curved, child: child);
            case AppTransition.slideRight:
              return SlideTransition(
                position: curved.drive(
                  Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ),
                ),
                child: child,
              );
            case AppTransition.slideUp:
              return SlideTransition(
                position: curved.drive(
                  Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ),
                ),
                child: child,
              );
            case AppTransition.scale:
              return ScaleTransition(scale: curved, child: child);
            default:
              return child;
          }
        },
      );
  }
}
