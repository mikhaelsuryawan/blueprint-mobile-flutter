import 'package:blueprint_mobile_flutter/config/routes/go_route_generator.dart';
import 'package:blueprint_mobile_flutter/config/routes/routes.dart';
import 'package:blueprint_mobile_flutter/core/login/bloc/login_bloc.dart';
import 'package:blueprint_mobile_flutter/core/login/model/request/login_request.dart';
import 'package:blueprint_mobile_flutter/core/models/arguments/arguments_main.dart';
import 'package:blueprint_mobile_flutter/utils/services/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';

/// Controller for managing login button actions
///
/// Handles:
/// - Building login request
/// - Triggering login via LoginBloc
/// - Navigation after successful login
/// - Saving credentials based on remember me state
class ButtonLoginController {
  final LoginBloc loginBloc;
  final BuildContext context;
  final VoidCallback? onNavigationComplete;

  ButtonLoginController({
    required this.loginBloc,
    required this.context,
    this.onNavigationComplete,
  });

  /// Build login request from email and password
  LoginRequest buildLoginRequest(String email, String password) {
    return LoginRequest(
      username: email.trim(),
      password: password.trim(),
    );
  }

  /// Execute login action
  ///
  /// [email] - User's email/username
  /// [password] - User's password
  /// [rememberMe] - Whether to save credentials
  void executeLogin(
    String email,
    String password, {
    bool rememberMe = false,
  }) {
    // Validate inputs
    if (email.trim().isEmpty || password.trim().isEmpty) {
      return;
    }

    // Build request
    final loginRequest = buildLoginRequest(email, password);

    // Trigger login event
    loginBloc.add(LoginFetched(request: loginRequest));
  }

  /// Handle successful login navigation
  ///
  /// [email] - User's email (to save if remember me is enabled)
  /// [password] - User's password (to save if remember me is enabled)
  /// [rememberMe] - Whether to save credentials
  Future<void> handleSuccessfulLogin(
    String email,
    String password, {
    bool rememberMe = false,
  }) async {
    // Save or clear credentials based on remember me
    if (rememberMe) {
      await SecureStorageService.setRememberMe(
        rememberMe,
        email.trim(),
        password.trim(),
      );
    } else {
      await SecureStorageService.clearRememberMe();
    }

    // Navigate to main page
    final argumentsMain = ArgumentsMain(
      isLogin: "true",
      currentIndex: 0,
    );

    // Navigate using GoRouter extension
    if (context.mounted) {
      context.goTo(mainRoute, extra: argumentsMain);

      // Call optional callback
      onNavigationComplete?.call();
    }
  }

  /// Handle login error
  ///
  /// [errorMessage] - Error message to display
  void handleLoginError(String errorMessage) {
    // Error handling is done in the UI via BlocBuilder
    // This method can be extended for additional error handling logic
  }
}
