import 'package:flutter/material.dart';

import '../../../../config/themes/notifiers/theme_manager.dart';

/// Controller for managing theme/dark mode operations
///
/// Handles:
/// - Dark mode state management
/// - Theme switching (light/dark)
/// - Synchronizing theme state with AppThemeNotifier
class ThemeController extends ChangeNotifier {
  final AppThemeNotifier themeNotifier;

  ThemeController({
    required this.themeNotifier,
  }) {
    // Listen to theme changes
    themeNotifier.addListener(_onThemeChanged);
  }

  /// Getter for dark mode state
  bool get isDarkMode => themeNotifier.isDarkMode;

  /// Toggle dark mode
  void toggleDarkMode() {
    if (isDarkMode) {
      setLightMode();
    } else {
      setDarkMode();
    }
  }

  /// Set dark mode
  void setDarkMode() {
    themeNotifier.setDarkMode();
    // State will be updated via listener
  }

  /// Set light mode
  void setLightMode() {
    themeNotifier.setLightMode();
    // State will be updated via listener
  }

  /// Handle theme changes from notifier
  void _onThemeChanged() {
    notifyListeners();
  }

  /// Get current theme
  /// This is a convenience method to access theme from notifier
  ThemeData getTheme(BuildContext context) {
    return themeNotifier.getTheme(context);
  }

  @override
  void dispose() {
    themeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }
}
