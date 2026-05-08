import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../constants/app_constants.dart';
import '../storage/local_storage_service.dart';

/// Remote Config Data Model
class RemoteConfigData {
  final String? androidForceUpdateVersionCode;
  final String? androidRecommendUpdateVersionCode;
  final String? androidUpdateMessage;
  final String? iOSForceUpdateVersionCode;
  final String? iOSRecommendUpdateVersionCode;
  final String? iOSUpdateMessage;
  final String? loginAccess;
  final String? cmsConfiguration;
  final String? iOSAppId;

  RemoteConfigData({
    this.androidForceUpdateVersionCode,
    this.androidRecommendUpdateVersionCode,
    this.androidUpdateMessage,
    this.iOSForceUpdateVersionCode,
    this.iOSRecommendUpdateVersionCode,
    this.iOSUpdateMessage,
    this.loginAccess,
    this.cmsConfiguration,
    this.iOSAppId,
  });

  /// Get force update version code based on platform
  String? getForceUpdateVersionCode() {
    if (Platform.isAndroid) {
      return androidForceUpdateVersionCode;
    } else if (Platform.isIOS) {
      return iOSForceUpdateVersionCode;
    }
    return null;
  }

  /// Get recommend update version code based on platform
  String? getRecommendUpdateVersionCode() {
    if (Platform.isAndroid) {
      return androidRecommendUpdateVersionCode;
    } else if (Platform.isIOS) {
      return iOSRecommendUpdateVersionCode;
    }
    return null;
  }

  /// Get update message based on platform
  String? getUpdateMessage() {
    if (Platform.isAndroid) {
      return androidUpdateMessage;
    } else if (Platform.isIOS) {
      return iOSUpdateMessage;
    }
    return null;
  }
}

/// Update Check Result
enum UpdateCheckResult {
  forceUpdate,
  recommendUpdate,
  noUpdate,
}

/// Remote Config Service
/// Handles all Firebase Remote Config operations
class RemoteConfigService {
  // Singleton instance
  static final RemoteConfigService _instance = RemoteConfigService._internal();
  factory RemoteConfigService() => _instance;
  RemoteConfigService._internal();

  FirebaseRemoteConfig? _remoteConfig;
  bool _isInitialized = false;

  // Default values for remote config
  static const Map<String, dynamic> _defaultValues = {
    'androidForceUpdateVersionCode': '0',
    'androidRecommendUpdateVersionCode': '0',
    'androidUpdateMessage': 'Update aplikasimu',
    'iOSForceUpdateVersionCode': '0',
    'iOSRecommendUpdateVersionCode': '0',
    'iOSUpdateMessage': 'Update aplikasimu',
    'loginAccess': '',
    'cmsConfiguration': '',
    'iOSAppId': '',
  };

  // Remote config settings
  static const Duration _fetchTimeout = Duration(seconds: 10);
  static const Duration _minimumFetchInterval = Duration(seconds: 0);

  /// Initialize remote config
  Future<void> initialize() async {
    if (_isInitialized) {
      debugPrint('⚠️ RemoteConfigService already initialized');
      return;
    }

    try {
      _remoteConfig = FirebaseRemoteConfig.instance;
      await _remoteConfig!.setDefaults(_defaultValues);

      await _remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: _fetchTimeout,
          minimumFetchInterval: _minimumFetchInterval,
        ),
      );

      _isInitialized = true;
      debugPrint('✅ RemoteConfigService initialized successfully');
    } catch (e) {
      debugPrint('❌ Error initializing RemoteConfigService: $e');
      _isInitialized = false;
      rethrow;
    }
  }

  /// Fetch and activate remote config
  Future<bool> fetchAndActivate() async {
    if (!_isInitialized || _remoteConfig == null) {
      debugPrint(
          '⚠️ RemoteConfigService not initialized. Call initialize() first.');
      return false;
    }

    try {
      final activated = await _remoteConfig!.fetchAndActivate();
      if (activated) {
        debugPrint('✅ Remote config fetched and activated');
        _saveConfigToLocalStorage();
      } else {
        debugPrint(
            'ℹ️ Remote config fetched but not activated (using cached values)');
      }
      return activated;
    } catch (e) {
      debugPrint('❌ Error fetching remote config: $e');
      return false;
    }
  }

  /// Get remote config data
  RemoteConfigData getConfigData() {
    if (!_isInitialized || _remoteConfig == null) {
      debugPrint('⚠️ RemoteConfigService not initialized');
      return RemoteConfigData();
    }

    try {
      return RemoteConfigData(
        androidForceUpdateVersionCode: _getStringSafe(
          AppConstant.androidForceUpdateVersionCode,
        ),
        androidRecommendUpdateVersionCode: _getStringSafe(
          AppConstant.androidRecommendUpdateVersionCode,
        ),
        androidUpdateMessage: _getStringSafe(
          AppConstant.androidUpdateMessage,
        ),
        iOSForceUpdateVersionCode: _getStringSafe(
          AppConstant.iOSForceUpdateVersionCode,
        ),
        iOSRecommendUpdateVersionCode: _getStringSafe(
          AppConstant.iOSRecommendUpdateVersionCode,
        ),
        iOSUpdateMessage: _getStringSafe(
          AppConstant.iOSUpdateMessage,
        ),
        loginAccess: _getStringSafe(AppConstant.loginAccess),
        cmsConfiguration: _getStringSafe(AppConstant.cmsConfiguration),
        iOSAppId: _getStringSafe(AppConstant.iOSAppId),
      );
    } catch (e) {
      debugPrint('❌ Error getting config data: $e');
      return RemoteConfigData();
    }
  }

  /// Get string value safely
  String _getStringSafe(String key) {
    try {
      if (_remoteConfig == null) return '';
      return _remoteConfig!.getString(key);
    } catch (e) {
      debugPrint('⚠️ Error getting config value for key $key: $e');
      return _defaultValues[key]?.toString() ?? '';
    }
  }

  /// Save config values to local storage
  void _saveConfigToLocalStorage() {
    try {
      final configData = getConfigData();

      if (configData.loginAccess != null &&
          configData.loginAccess!.isNotEmpty) {
        LocalStorageService.saveData(
          AppConstant.loginAccess,
          configData.loginAccess!,
        );
      }

      if (configData.cmsConfiguration != null &&
          configData.cmsConfiguration!.isNotEmpty) {
        LocalStorageService.saveData(
          AppConstant.cmsConfiguration,
          configData.cmsConfiguration!,
        );
      }

      if (configData.iOSAppId != null && configData.iOSAppId!.isNotEmpty) {
        LocalStorageService.saveData(
          AppConstant.iOSAppId,
          configData.iOSAppId!,
        );
      }

      debugPrint('✅ Config values saved to local storage');
    } catch (e) {
      debugPrint('❌ Error saving config to local storage: $e');
    }
  }

  /// Check if update is required
  /// Returns UpdateCheckResult indicating the update status
  Future<UpdateCheckResult> checkUpdateRequired() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersionCode = packageInfo.buildNumber;
      final configData = getConfigData();

      final forceUpdateVersion = configData.getForceUpdateVersionCode();
      final recommendUpdateVersion = configData.getRecommendUpdateVersionCode();

      // Parse version codes safely
      final currentVersion = int.tryParse(currentVersionCode) ?? 0;
      final forceVersion = int.tryParse(forceUpdateVersion ?? '0') ?? 0;
      final recommendVersion = int.tryParse(recommendUpdateVersion ?? '0') ?? 0;

      debugPrint('📱 Current version: $currentVersion');
      debugPrint('🔴 Force update version: $forceVersion');
      debugPrint('🟡 Recommend update version: $recommendVersion');

      if (forceVersion > currentVersion) {
        return UpdateCheckResult.forceUpdate;
      } else if (recommendVersion > currentVersion) {
        return UpdateCheckResult.recommendUpdate;
      } else {
        return UpdateCheckResult.noUpdate;
      }
    } catch (e) {
      debugPrint('❌ Error checking update: $e');
      return UpdateCheckResult.noUpdate;
    }
  }

  /// Get package info
  Future<PackageInfo> getPackageInfo() async {
    try {
      return await PackageInfo.fromPlatform();
    } catch (e) {
      debugPrint('❌ Error getting package info: $e');
      rethrow;
    }
  }

  /// Get update message for current platform
  String? getUpdateMessage() {
    return getConfigData().getUpdateMessage();
  }

  /// Get iOS App ID
  String? getiOSAppId() {
    return getConfigData().iOSAppId;
  }

  /// Get login access
  String? getLoginAccess() {
    return getConfigData().loginAccess;
  }

  /// Get CMS configuration
  String? getCMSConfiguration() {
    return getConfigData().cmsConfiguration;
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Get remote config instance (for advanced usage)
  FirebaseRemoteConfig? get remoteConfig => _remoteConfig;
}
