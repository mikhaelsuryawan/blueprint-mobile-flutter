import 'package:blueprint_mobile_flutter/utils/services/storage/secure_storage_service.dart';
import 'package:flutter/foundation.dart';

/// Controller for managing remember me functionality
///
/// Handles:
/// - Remember me checkbox state
/// - Loading saved credentials from secure storage
/// - Saving/clearing credentials in secure storage
class RememberController extends ChangeNotifier {
  bool _isRememberMe = false;
  bool _isLoading = false;

  RememberController() {
    // State initialized with default values
  }

  /// Getter for remember me state
  bool get isRememberMe => _isRememberMe;

  /// Getter for loading state
  bool get isLoading => _isLoading;

  /// Set remember me state
  void setRememberMe(bool value) {
    if (_isRememberMe != value) {
      _isRememberMe = value;

      // Clear credentials if unchecked
      if (!value) {
        _clearCredentials();
      }

      notifyListeners();
    }
  }

  /// Toggle remember me state
  void toggleRememberMe() {
    setRememberMe(!_isRememberMe);
  }

  /// Load remember me state and credentials from secure storage
  ///
  /// Returns a map with 'rememberMe', 'username', and 'password' keys
  /// Returns null if no saved credentials exist
  Future<Map<String, String>?> loadSavedCredentials() async {
    try {
      _isLoading = true;
      notifyListeners();

      final rememberValue = await SecureStorageService.getRememberMe();

      if (rememberValue == null) {
        _isRememberMe = false;
        _isLoading = false;
        notifyListeners();
        return null;
      }

      final rememberSplit = rememberValue.split('|||');

      if (rememberSplit.length >= 3) {
        _isRememberMe = rememberSplit[0].toLowerCase() == 'true';
        final String username =
            rememberSplit.length > 1 ? rememberSplit[1] : '';
        final String password =
            rememberSplit.length > 2 ? rememberSplit[2] : '';

        _isLoading = false;
        notifyListeners();

        return {
          'rememberMe': _isRememberMe.toString(),
          'username': username,
          'password': password,
        };
      }

      _isRememberMe = false;
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading remember me credentials: $e');
      }
      _isRememberMe = false;
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  /// Save credentials to secure storage if remember me is enabled
  Future<void> saveCredentials(String username, String password) async {
    try {
      if (_isRememberMe) {
        await SecureStorageService.setRememberMe(
          _isRememberMe,
          username,
          password,
        );
      } else {
        await _clearCredentials();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving remember me credentials: $e');
      }
      rethrow;
    }
  }

  /// Clear credentials from secure storage
  Future<void> _clearCredentials() async {
    try {
      await SecureStorageService.clearRememberMe();
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing remember me credentials: $e');
      }
      rethrow;
    }
  }

  /// Clear credentials explicitly (public method)
  Future<void> clearCredentials() async {
    await _clearCredentials();
    _isRememberMe = false;
    notifyListeners();
  }
}
