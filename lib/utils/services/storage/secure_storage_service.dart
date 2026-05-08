import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../constants/app_constants.dart';

/// We do not store user credentials, API tokens,
/// secret API keys in local storage, for that we make use of
/// flutter_secure_storage which stores data in the Android Keystore and Apple
/// keychain with platform-specific encryption technique.
///
/// This service provides a powerful and seamless secure storage solution with:
/// - Comprehensive Android and iOS configuration
/// - Singleton pattern for efficient resource usage
/// - Proper error handling
/// - Type-safe operations
/// - Platform-specific security optimizations
///
/// In this file, there will be getters and setters for each and every
/// data to be stored in platform secure storage.

class SecureStorageService {
  // Singleton instance for efficient resource usage
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  // Shared storage instance with platform-specific configurations
  late final FlutterSecureStorage _storage;

  // Initialize storage with platform-specific options
  void _initializeStorage() {
    _storage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
      lOptions: _getLinuxOptions(),
      wOptions: _getWindowsOptions(),
      mOptions: _getMacOsOptions(),
    );
  }

  // Get the storage instance, initializing if needed
  FlutterSecureStorage get storage {
    if (!_isInitialized) {
      _initializeStorage();
      _isInitialized = true;
    }
    return _storage;
  }

  bool _isInitialized = false;

  /// Comprehensive Android configuration for maximum security
  ///
  /// - encryptedSharedPreferences: Uses Android's EncryptedSharedPreferences
  ///   for additional encryption layer
  /// - resetOnError: Clears data if encryption key is corrupted
  /// - sharedPreferencesName: Custom name for shared preferences
  /// - preferencesKeyPrefix: Prefix for all keys
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        // Use EncryptedSharedPreferences for additional security layer
        encryptedSharedPreferences: true,
        // Reset storage if encryption key is corrupted
        resetOnError: true,
        // Custom shared preferences name
        sharedPreferencesName: 'secure_storage_prefs',
        // Prefix for all keys to avoid conflicts
        preferencesKeyPrefix: 'secure_',
      );

  /// Comprehensive iOS configuration for maximum security
  ///
  /// - accountName: Custom account name for keychain
  /// - synchronizable: false - Prevents iCloud sync for security
  /// Uses default accessibility settings (most secure by default)
  IOSOptions _getIOSOptions() => const IOSOptions(
        // Custom account name for better organization
        accountName: 'blueprint_mobile_flutter',
        // Disable iCloud sync for maximum security
        synchronizable: false,
      );

  /// Linux configuration
  LinuxOptions _getLinuxOptions() => const LinuxOptions();

  /// Windows configuration
  WindowsOptions _getWindowsOptions() => const WindowsOptions();

  /// macOS configuration
  MacOsOptions _getMacOsOptions() => const MacOsOptions(
        synchronizable: false,
      );

  // ==================== API Token Methods ====================

  /// Save API token to secure storage service
  static Future<void> setApiToken(String token) async {
    try {
      await _instance.storage.write(
        key: AppConstant.apiToken,
        value: token,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error saving API token: $e');
      }
      rethrow;
    }
  }

  /// Get API token from secure storage service
  static Future<String?> getApiToken() async {
    try {
      return await _instance.storage.read(key: AppConstant.apiToken);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading API token: $e');
      }
      return null;
    }
  }

  // ==================== Refresh Token Methods ====================

  /// Save Refresh API token to secure storage service
  static Future<void> setRefreshApiToken(String token) async {
    try {
      await _instance.storage.write(
        key: AppConstant.refreshApiToken,
        value: token,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error saving refresh token: $e');
      }
      rethrow;
    }
  }

  /// Get Refresh API token from secure storage service
  static Future<String?> getRefreshApiToken() async {
    try {
      return await _instance.storage.read(key: AppConstant.refreshApiToken);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading refresh token: $e');
      }
      return null;
    }
  }

  // ==================== FCM Token Methods ====================

  /// Save FCM token to secure storage service
  static Future<void> setFcmToken(String token) async {
    try {
      await _instance.storage.write(
        key: AppConstant.fcmToken,
        value: token,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error saving FCM token: $e');
      }
      rethrow;
    }
  }

  /// Get FCM token from secure storage service
  static Future<String?> getFcmToken() async {
    try {
      return await _instance.storage.read(key: AppConstant.fcmToken);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading FCM token: $e');
      }
      return null;
    }
  }

  // ==================== Device ID Methods ====================

  /// Save Device ID to secure storage service
  static Future<void> setDeviceId(String deviceId) async {
    try {
      await _instance.storage.write(
        key: AppConstant.deviceId,
        value: deviceId,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error saving device ID: $e');
      }
      rethrow;
    }
  }

  /// Get Device ID from secure storage service
  static Future<String?> getDeviceId() async {
    try {
      return await _instance.storage.read(key: AppConstant.deviceId);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading device ID: $e');
      }
      return null;
    }
  }

  // ==================== OTP Token Methods ====================

  /// Save OTP token to secure storage service
  static Future<void> setOtpToken(String token) async {
    try {
      await _instance.storage.write(
        key: AppConstant.otpToken,
        value: token,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error saving OTP token: $e');
      }
      rethrow;
    }
  }

  /// Get OTP token from secure storage service
  static Future<String?> getOtpToken() async {
    try {
      return await _instance.storage.read(key: AppConstant.otpToken);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading OTP token: $e');
      }
      return null;
    }
  }

  // ==================== Login Status Methods ====================

  /// Save Login status to secure storage service
  static Future<void> setLogin(bool value) async {
    try {
      await _instance.storage.write(
        key: AppConstant.isLogin,
        value: value.toString(),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error saving login status: $e');
      }
      rethrow;
    }
  }

  /// Get Login status from secure storage service
  static Future<bool?> getLogin() async {
    try {
      final value = await _instance.storage.read(key: AppConstant.isLogin);
      if (value == null) return null;
      return value.toLowerCase() == 'true';
    } catch (e) {
      if (kDebugMode) {
        print('Error reading login status: $e');
      }
      return null;
    }
  }

  // ==================== Remember Me Methods ====================

  /// Save username and password to secure storage service
  ///
  /// [rememberMe] - Whether to remember credentials
  /// [username] - Username to save (can be null)
  /// [password] - Password to save (can be null)
  static Future<void> setRememberMe(
    bool rememberMe,
    String? username,
    String? password,
  ) async {
    try {
      await _instance.storage.write(
        key: AppConstant.rememberMe,
        value: rememberMe.toString(),
      );

      if (username != null) {
        await _instance.storage.write(
          key: AppConstant.rememberUsername,
          value: username,
        );
      }

      if (password != null) {
        await _instance.storage.write(
          key: AppConstant.rememberPassword,
          value: password,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving remember me credentials: $e');
      }
      rethrow;
    }
  }

  /// Get remember me credentials from secure storage service
  ///
  /// Returns a formatted string: "rememberMe|||username|||password"
  /// Returns null if rememberMe is not set
  static Future<String?> getRememberMe() async {
    try {
      final readRememberMe = await _instance.storage.read(
        key: AppConstant.rememberMe,
      );
      final readUsername = await _instance.storage.read(
        key: AppConstant.rememberUsername,
      );
      final readPassword = await _instance.storage.read(
        key: AppConstant.rememberPassword,
      );

      if (readRememberMe == null) return null;

      return '${readRememberMe}|||${readUsername ?? ''}|||${readPassword ?? ''}';
    } catch (e) {
      if (kDebugMode) {
        print('Error reading remember me credentials: $e');
      }
      return null;
    }
  }

  /// Clear Remember Me credentials from secure storage
  static Future<void> clearRememberMe() async {
    try {
      await Future.wait([
        _instance.storage.delete(key: AppConstant.rememberUsername),
        _instance.storage.delete(key: AppConstant.rememberPassword),
        _instance.storage.delete(key: AppConstant.rememberMe),
      ]);
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing remember me credentials: $e');
      }
      rethrow;
    }
  }

  // ==================== Generic Methods ====================

  /// Generic method to write any value to secure storage
  ///
  /// [key] - The key to store the value under
  /// [value] - The value to store
  static Future<void> write(String key, String value) async {
    try {
      await _instance.storage.write(key: key, value: value);
    } catch (e) {
      if (kDebugMode) {
        print('Error writing to secure storage: $e');
      }
      rethrow;
    }
  }

  /// Generic method to read any value from secure storage
  ///
  /// [key] - The key to read the value from
  /// Returns the value or null if not found
  static Future<String?> read(String key) async {
    try {
      return await _instance.storage.read(key: key);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading from secure storage: $e');
      }
      return null;
    }
  }

  /// Generic method to delete a value from secure storage
  ///
  /// [key] - The key to delete
  static Future<void> delete(String key) async {
    try {
      await _instance.storage.delete(key: key);
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting from secure storage: $e');
      }
      rethrow;
    }
  }

  /// Check if a key exists in secure storage
  ///
  /// [key] - The key to check
  /// Returns true if the key exists, false otherwise
  static Future<bool> containsKey(String key) async {
    try {
      final value = await _instance.storage.read(key: key);
      return value != null;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking key existence: $e');
      }
      return false;
    }
  }

  /// Get all keys stored in secure storage
  ///
  /// Returns a map of all key-value pairs
  static Future<Map<String, String>> readAll() async {
    try {
      return await _instance.storage.readAll();
    } catch (e) {
      if (kDebugMode) {
        print('Error reading all from secure storage: $e');
      }
      return {};
    }
  }

  // ==================== Clear Methods ====================

  /// Clear all secure storage data
  ///
  /// WARNING: This will delete all stored data including tokens and credentials
  static Future<void> clear() async {
    try {
      await _instance.storage.deleteAll();
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing secure storage: $e');
      }
      rethrow;
    }
  }
}
