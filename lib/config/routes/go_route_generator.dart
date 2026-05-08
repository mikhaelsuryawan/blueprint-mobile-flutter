import 'package:blueprint_mobile_flutter/config/routes/animated_go_route.dart';
import 'package:blueprint_mobile_flutter/config/routes/routes.dart';
import 'package:blueprint_mobile_flutter/screens/components/button/screen/button_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/arguments/arguments_main.dart';
import '../../screens/ai_chat/screen/ai_chat_screen.dart';
import '../../screens/auth/change_password/screen/change_password_screen.dart';
import '../../screens/auth/login/screen/login_screen.dart';
import '../../screens/auth/onboarding/screen/onboarding_screen.dart';
import '../../screens/auth/sign_up/screen/sign_up_screen.dart';
import '../../screens/auth/splash/screen/splash_screen.dart';
import '../../screens/main/screen/main_screen.dart';
import '../../screens/my_career/screen/my_career_screen.dart';
import '../../screens/not_found/screen/not_found_screen.dart';
import '../../screens/theme/screen/theme_screen.dart';
import '../../screens/update_profile/screen/update_profile_screen.dart';

/// GoRouter configuration with all routes and animated transitions
final GoRouter appRouter = GoRouter(
  initialLocation: splashRoute,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: <RouteBase>[
    // Splash Route
    GoRoute(
      path: splashRoute,
      name: 'splash',
      pageBuilder: (context, state) => buildAnimatedPage(
        child: const SplashScreen(),
        name: splashRoute,
        transition: AppTransition.fade,
        duration: const Duration(milliseconds: 600),
        arguments: state.extra,
      ),
    ),

    // Onboarding Route
    GoRoute(
      path: onBoardingRoute,
      name: 'onboarding',
      pageBuilder: (context, state) => buildAnimatedPage(
        child: const OnboardingScreen(),
        name: onBoardingRoute,
        transition: AppTransition.fade,
        duration: const Duration(milliseconds: 600),
        arguments: state.extra,
      ),
    ),

    // Login Route
    GoRoute(
      path: loginRoute,
      name: 'login',
      pageBuilder: (context, state) => buildAnimatedPage(
        child: const LoginScreen(),
        name: loginRoute,
        transition: AppTransition.fade,
        duration: const Duration(milliseconds: 600),
        arguments: state.extra,
      ),
    ),

    // Sign Up Route
    GoRoute(
      path: signUpRoute,
      name: 'signUp',
      pageBuilder: (context, state) => buildAnimatedPage(
        child: const SignUpScreen(),
        name: signUpRoute,
        transition: AppTransition.slideRight,
        duration: const Duration(milliseconds: 600),
        arguments: state.extra,
      ),
    ),

    // Main Route with arguments support
    GoRoute(
      path: mainRoute,
      name: 'main',
      pageBuilder: (context, state) {
        // Extract arguments from state.extra or state.uri.queryParameters
        ArgumentsMain? argumentsMain;

        if (state.extra is ArgumentsMain) {
          argumentsMain = state.extra as ArgumentsMain;
        } else if (state.uri.queryParameters.isNotEmpty) {
          argumentsMain = ArgumentsMain(
            isLogin: state.uri.queryParameters['isLogin'] ?? 'false',
            currentIndex: int.tryParse(
                  state.uri.queryParameters['currentIndex'] ?? '0',
                ) ??
                0,
          );
        } else {
          // Default values if no arguments provided
          argumentsMain = ArgumentsMain(
            isLogin: 'false',
            currentIndex: 0,
          );
        }

        return buildAnimatedPage(
          child: MainScreen(argumentsMain: argumentsMain),
          name: mainRoute,
          transition: AppTransition.fade,
          arguments: argumentsMain,
        );
      },
    ),

    // Theme Route
    GoRoute(
      path: themeRoute,
      name: 'theme',
      pageBuilder: (context, state) => buildAnimatedPage(
        child: const ThemeScreen(),
        name: themeRoute,
        transition: AppTransition.slideRight,
        duration: const Duration(milliseconds: 600),
        arguments: state.extra,
      ),
    ),

    // Change Password Route
    GoRoute(
      path: changePasswordRoute,
      name: 'changePassword',
      pageBuilder: (context, state) => buildAnimatedPage(
        child: const ChangePasswordScreen(),
        name: changePasswordRoute,
        transition: AppTransition.slideRight,
        duration: const Duration(milliseconds: 600),
        arguments: state.extra,
      ),
    ),

    // Update Profile Route
    GoRoute(
      path: updateProfileRoute,
      name: 'updateProfile',
      pageBuilder: (context, state) => buildAnimatedPage(
        child: const UpdateProfileScreen(),
        name: updateProfileRoute,
        transition: AppTransition.slideRight,
        duration: const Duration(milliseconds: 600),
        arguments: state.extra,
      ),
    ),

    // Button Route
    GoRoute(
      path: buttonRoute,
      name: 'button',
      pageBuilder: (context, state) => buildAnimatedPage(
        child: const ButtonScreen(),
        name: buttonRoute,
        transition: AppTransition.slideRight,
        duration: const Duration(milliseconds: 600),
        arguments: state.extra,
      ),
    ),

    // My Career Route
    GoRoute(
      path: myCareerRoute,
      name: 'myCareer',
      pageBuilder: (context, state) => buildAnimatedPage(
        child: const MyCareerScreen(),
        name: myCareerRoute,
        transition: AppTransition.fade,
        duration: const Duration(milliseconds: 600),
        arguments: state.extra,
      ),
    ),

    // AI Chat Route
    GoRoute(
      path: aiChatRoute,
      name: 'aiChat',
      pageBuilder: (context, state) => buildAnimatedPage(
        child: const AiChatScreen(),
        name: aiChatRoute,
        transition: AppTransition.fade,
        duration: const Duration(milliseconds: 600),
        arguments: state.extra,
      ),
    ),

    // Not Found Route
    GoRoute(
      path: notFoundRoute,
      name: 'notFound',
      pageBuilder: (context, state) => buildAnimatedPage(
        child: NotFoundScreen(isShowBackButton: state.extra as bool? ?? true),
        name: notFoundRoute,
        transition: AppTransition.fade,
        duration: const Duration(milliseconds: 600),
        arguments: state.extra,
      ),
    ),
  ],
);

/// Extension methods for easy navigation with GoRouter
extension GoRouterExtension on BuildContext {
  /// Navigate to a route with optional arguments
  void goTo(String route, {Object? extra}) {
    GoRouter.of(this).go(route, extra: extra);
  }

  /// Push a new route with optional arguments
  Future<T?> pushTo<T extends Object?>(String route, {Object? extra}) {
    return GoRouter.of(this).push<T>(route, extra: extra);
  }

  /// Pop the current route
  void popRoute([Object? result]) {
    GoRouter.of(this).pop(result);
  }

  /// Replace the current route
  void replaceTo(String route, {Object? extra}) {
    GoRouter.of(this).pushReplacement(route, extra: extra);
  }
}
