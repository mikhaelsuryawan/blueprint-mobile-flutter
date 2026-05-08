import 'package:blueprint_mobile_flutter/utils/services/remote_config/remote_config_service.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../utils/services/remote_config/remote_config_service.dart'
    as remote_config;

/// Controller for managing remote config operations
///
/// Handles:
/// - Remote config initialization
/// - Fetching and activating remote config
/// - Checking for app updates
/// - Managing update dialog state
class RemoteConfigController extends ChangeNotifier {
  final RemoteConfigService _remoteConfigService = RemoteConfigService();

  // State
  bool _isInitializing = false;
  bool _isFetching = false;
  bool _isCheckingUpdate = false;
  remote_config.UpdateCheckResult? _updateResult;
  PackageInfo? _packageInfo;
  String? _updateMessage;
  String? _iOSAppId;
  String? _packageName;

  RemoteConfigController();

  /// Getter for initialization state
  bool get isInitializing => _isInitializing;

  /// Getter for fetching state
  bool get isFetching => _isFetching;

  /// Getter for update check state
  bool get isCheckingUpdate => _isCheckingUpdate;

  /// Getter for update result
  remote_config.UpdateCheckResult? get updateResult => _updateResult;

  /// Getter for package info
  PackageInfo? get packageInfo => _packageInfo;

  /// Getter for update message
  String? get updateMessage => _updateMessage;

  /// Getter for iOS App ID
  String? get iOSAppId => _iOSAppId;

  /// Getter for package name
  String? get packageName => _packageName;

  /// Check if remote config is initialized
  bool get isInitialized => _remoteConfigService.isInitialized;

  /// Initialize remote config service
  Future<bool> initialize() async {
    try {
      if (_remoteConfigService.isInitialized) {
        if (kDebugMode) {
          print('ℹ️ Remote config already initialized');
        }
        return true;
      }

      _isInitializing = true;
      notifyListeners();

      await _remoteConfigService.initialize();

      _isInitializing = false;
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error initializing remote config: $e');
      }
      _isInitializing = false;
      notifyListeners();
      return false;
    }
  }

  /// Fetch and activate remote config
  Future<bool> fetchAndActivate() async {
    try {
      if (!_remoteConfigService.isInitialized) {
        if (kDebugMode) {
          print('⚠️ Remote config not initialized. Initializing first...');
        }
        final initialized = await initialize();
        if (!initialized) {
          return false;
        }
      }

      _isFetching = true;
      notifyListeners();

      final activated = await _remoteConfigService.fetchAndActivate();

      _isFetching = false;
      notifyListeners();
      return activated;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error fetching remote config: $e');
      }
      _isFetching = false;
      notifyListeners();
      return false;
    }
  }

  /// Get package info
  Future<PackageInfo?> getPackageInfo() async {
    try {
      if (_packageInfo == null) {
        _packageInfo = await _remoteConfigService.getPackageInfo();
      }
      return _packageInfo;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting package info: $e');
      }
      return null;
    }
  }

  /// Check for app updates
  /// Returns UpdateCheckResult and stores package info
  Future<remote_config.UpdateCheckResult> checkUpdate() async {
    try {
      _isCheckingUpdate = true;
      notifyListeners();

      // Get package info
      _packageInfo = await getPackageInfo();
      if (_packageInfo == null) {
        _updateResult = remote_config.UpdateCheckResult.noUpdate;
        _isCheckingUpdate = false;
        notifyListeners();
        return _updateResult!;
      }

      // Check update status
      _updateResult = await _remoteConfigService.checkUpdateRequired();

      // Get update message and iOS App ID
      _updateMessage = _remoteConfigService.getUpdateMessage() ?? 'Update aplikasimu';
      _iOSAppId = _remoteConfigService.getiOSAppId() ?? '';
      _packageName = _packageInfo!.packageName;

      if (kDebugMode) {
        print('📦 Package: $_packageName');
        print('📱 Version: ${_packageInfo!.version} (${_packageInfo!.buildNumber})');
      }

      _isCheckingUpdate = false;
      notifyListeners();
      return _updateResult!;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error checking update: $e');
      }
      _updateResult = remote_config.UpdateCheckResult.noUpdate;
      _isCheckingUpdate = false;
      notifyListeners();
      return _updateResult!;
    }
  }

  /// Complete remote config flow: initialize, fetch, and check update
  /// Returns UpdateCheckResult
  Future<remote_config.UpdateCheckResult> completeRemoteConfigFlow() async {
    try {
      // Initialize if not already initialized
      if (!_remoteConfigService.isInitialized) {
        final initialized = await initialize();
        if (!initialized) {
          return remote_config.UpdateCheckResult.noUpdate;
        }
      }

      // Fetch and activate
      await fetchAndActivate();

      // Check for updates
      return await checkUpdate();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error in remote config flow: $e');
      }
      return remote_config.UpdateCheckResult.noUpdate;
    }
  }

  /// Reset controller state
  void reset() {
    _isInitializing = false;
    _isFetching = false;
    _isCheckingUpdate = false;
    _updateResult = null;
    _packageInfo = null;
    _updateMessage = null;
    _iOSAppId = null;
    _packageName = null;
    notifyListeners();
  }
}
