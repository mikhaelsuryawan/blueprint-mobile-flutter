/// This file contains all the screens route used within the app
import 'package:blueprint_mobile_flutter/config/routes/animated_route.dart';
import 'package:blueprint_mobile_flutter/config/routes/routes.dart';
import 'package:blueprint_mobile_flutter/screens/components/button/screen/button_screen.dart';
import 'package:flutter/material.dart';

import '../../core/models/arguments/arguments_main.dart';
import '../../screens/auth/change_password/screen/change_password_screen.dart';
import '../../screens/auth/login/screen/login_screen.dart';
import '../../screens/auth/onboarding/screen/onboarding_screen.dart';
import '../../screens/auth/splash/screen/splash_screen.dart';
import '../../screens/main/screen/main_screen.dart';
import '../../screens/my_career/screen/my_career_screen.dart';
import '../../screens/not_found/screen/not_found_screen.dart';
import '../../screens/theme/screen/theme_screen.dart';
import '../../screens/update_profile/screen/update_profile_screen.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return animatedRoute(
          const SplashScreen(),
          settings,
          transition: AppTransition.fade,
          duration: const Duration(milliseconds: 600),
        );

      case onBoardingRoute:
        return animatedRoute(
          const OnboardingScreen(),
          settings,
          transition: AppTransition.fade,
          duration: const Duration(milliseconds: 600),
        );

      case loginRoute:
        return animatedRoute(
          const LoginScreen(),
          settings,
          transition: AppTransition.fade,
          duration: const Duration(milliseconds: 600),
        );

      case mainRoute:
        return animatedRoute(
          MainScreen(argumentsMain: settings.arguments as ArgumentsMain),
          // give this route a friendly name if you like
          RouteSettings(name: 'Home Screen'),
          transition: AppTransition.fade, // nice iOS-style push
        );

      case themeRoute:
        return animatedRoute(const ThemeScreen(), settings,
            transition: AppTransition.slideRight,
            duration: const Duration(milliseconds: 600));

      case changePasswordRoute:
        return animatedRoute(const ChangePasswordScreen(), settings,
            transition: AppTransition.slideRight,
            duration: const Duration(milliseconds: 600));

      case updateProfileRoute:
        return animatedRoute(const UpdateProfileScreen(), settings,
            transition: AppTransition.slideRight,
            duration: const Duration(milliseconds: 600));

      case buttonRoute:
        return animatedRoute(const ButtonScreen(), settings,
            transition: AppTransition.slideRight,
            duration: const Duration(milliseconds: 600));

      case notFoundRoute:
        return animatedRoute(const NotFoundScreen(), settings,
            transition: AppTransition.material);

      case myCareerRoute:
        return animatedRoute(const MyCareerScreen(), settings,
            transition: AppTransition.fade,
            duration: const Duration(milliseconds: 600));

      default:
        return animatedRoute(
          Scaffold(
              body: Center(
                  child: Text(
            'No route defined for ${settings.name}',
          ))),
          settings,
          transition: AppTransition.fade,
        );
    }
  }
}
