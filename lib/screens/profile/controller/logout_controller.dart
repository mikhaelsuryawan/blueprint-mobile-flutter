import 'package:flutter/material.dart';

import '../../../../config/routes/go_route_generator.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/logout/bloc/logout_bloc.dart';

/// Controller for managing logout operations
///
/// Handles:
/// - Logout execution via LogoutBloc
/// - Navigation after successful logout
/// - Error handling
/// - Loading state management
class LogoutController {
  final LogoutBloc logoutBloc;
  final BuildContext context;
  final VoidCallback? onNavigationComplete;

  LogoutController({
    required this.logoutBloc,
    required this.context,
    this.onNavigationComplete,
  });

  /// Execute logout action
  void executeLogout() {
    logoutBloc.add(LogoutFetched());
  }

  /// Handle successful logout navigation
  /// Navigates to login page
  void handleSuccessfulLogout() {
    if (context.mounted) {
      // Navigate to login page
      context.goTo(loginRoute);

      // Call optional callback
      onNavigationComplete?.call();
    }
  }

  /// Handle logout error
  ///
  /// [errorMessage] - Error message to display
  void handleLogoutError(String errorMessage, BuildContext context) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }

    // Reset to idle state
    logoutBloc.add(LogoutIdleEvent());
  }

  /// Handle logout loading state
  bool isLogoutLoading(dynamic state) {
    // This method can be used in BlocBuilder to check loading state
    return state is LogoutLoading || state is LogoutLoaded;
  }
}
