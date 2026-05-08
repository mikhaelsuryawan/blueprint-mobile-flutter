import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id_plus/platform_device_id.dart';

import '../../../../constants/app_settings.dart';
import '../../../../core/refresh_token/bloc/refresh_token_bloc.dart';
import '../../../../core/refresh_token/model/request/auth_token_request.dart';
import '../../../../utils/Helpers.dart';
import '../../../../utils/services/storage/secure_storage_service.dart';

/// Controller for managing refresh token operations
///
/// Handles:
/// - FCM token loading and storage
/// - Device ID retrieval
/// - Building auth token request
/// - Triggering refresh token/auth token events via RefreshTokenBloc
class RefreshTokenController extends ChangeNotifier {
  final RefreshTokenBloc refreshTokenBloc;

  // State
  String? _deviceId;
  String? _fcmToken;
  bool _isLoadingFcm = false;
  bool _isLoadingDeviceId = false;
  bool _isRefreshingToken = false;

  RefreshTokenController({required this.refreshTokenBloc});

  /// Getter for device ID
  String? get deviceId => _deviceId;

  /// Getter for FCM token
  String? get fcmToken => _fcmToken;

  /// Getter for FCM loading state
  bool get isLoadingFcm => _isLoadingFcm;

  /// Getter for device ID loading state
  bool get isLoadingDeviceId => _isLoadingDeviceId;

  /// Getter for token refresh state
  bool get isRefreshingToken => _isRefreshingToken;

  /// Initialize controller - loads FCM token and device ID
  Future<void> initialize() async {
    await Future.wait([
      loadFcmToken(),
      loadDeviceId(),
    ]);
  }

  /// Load FCM token from Firebase Messaging
  Future<String?> loadFcmToken() async {
    try {
      _isLoadingFcm = true;
      notifyListeners();

      final token = await FirebaseMessaging.instance.getToken();
      
      if (token != null) {
        _fcmToken = token;
        Helpers.log("FCM token", token);
        await SecureStorageService.setFcmToken(token);
      }

      _isLoadingFcm = false;
      notifyListeners();
      return token;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error loading FCM token: $e');
      }
      _isLoadingFcm = false;
      notifyListeners();
      return null;
    }
  }

  /// Load device ID from platform
  Future<String?> loadDeviceId() async {
    try {
      _isLoadingDeviceId = true;
      notifyListeners();

      _deviceId = await PlatformDeviceId.getDeviceId;

      if (kDebugMode) {
        print("deviceId -> $_deviceId");
      }

      _isLoadingDeviceId = false;
      notifyListeners();
      return _deviceId;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('❌ Error loading device ID: $e');
      }
      _deviceId = '';
      _isLoadingDeviceId = false;
      notifyListeners();
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Unexpected error loading device ID: $e');
      }
      _deviceId = '';
      _isLoadingDeviceId = false;
      notifyListeners();
      return null;
    }
  }

  /// Build auth token request with all required parameters
  Future<AuthTokenRequest> buildAuthTokenRequest() async {
    final request = AuthTokenRequest();

    // Set app settings
    request.appKey = AppSettings.authAppKey;
    request.appName = AppSettings.authAppName;

    // Set device type based on platform
    if (Platform.isIOS) {
      request.deviceType = "mobile-ios";
    } else {
      request.deviceType = "mobile-android";
    }

    // Set device ID (should be loaded already)
    request.deviceId = _deviceId;

    // Set FCM token (should be loaded already)
    request.fcmToken = _fcmToken;

    // Get IP address
    try {
      final ipAddress = await Helpers.getIpAddress();
      if (kDebugMode) {
        print("ipAddress : $ipAddress");
      }
      request.ipAddress = ipAddress;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting IP address: $e');
      }
      request.ipAddress = null;
    }

    return request;
  }

  /// Execute refresh token flow
  /// Checks if API token exists and triggers appropriate event
  Future<void> executeRefreshToken() async {
    try {
      _isRefreshingToken = true;
      notifyListeners();

      // Build request with all parameters
      final request = await buildAuthTokenRequest();

      // Check if API token exists
      try {
        final apiToken = await SecureStorageService.getApiToken();
        
        if (apiToken == null) {
          // No token exists - request new auth token
          refreshTokenBloc.add(AuthTokenFetched(request: request));
        } else {
          // Token exists - refresh it
          refreshTokenBloc.add(RefreshTokenFetched(request: request));
        }
      } catch (error) {
        if (kDebugMode) {
          print('❌ Error checking API token: $error');
        }
        // On error, request new auth token
        refreshTokenBloc.add(AuthTokenFetched(request: request));
      }

      _isRefreshingToken = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error executing refresh token: $e');
      }
      // Build request and request new auth token as fallback
      try {
        final request = await buildAuthTokenRequest();
        refreshTokenBloc.add(AuthTokenFetched(request: request));
      } catch (buildError) {
        if (kDebugMode) {
          print('❌ Error building auth token request: $buildError');
        }
      }
      _isRefreshingToken = false;
      notifyListeners();
    }
  }

  /// Reset controller state
  void reset() {
    _deviceId = null;
    _fcmToken = null;
    _isLoadingFcm = false;
    _isLoadingDeviceId = false;
    _isRefreshingToken = false;
    notifyListeners();
  }
}
