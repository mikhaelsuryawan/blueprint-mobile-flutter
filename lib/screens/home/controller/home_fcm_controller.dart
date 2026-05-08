import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../core/fcm/bloc/fcm_bloc.dart';
import '../../../../core/fcm/model/request/update_fcm_request.dart';
import '../../../../utils/Helpers.dart';
import '../../../../utils/services/storage/secure_storage_service.dart';

/// Controller for managing home FCM and refresh operations
///
/// Handles:
/// - FCM token loading
/// - Login status checking
/// - Pull-to-refresh functionality
/// - Update FCM request management
class HomeFcmController extends ChangeNotifier {
  final FcmBloc? fcmBloc;
  final RefreshController refreshController;

  // State
  String _isLogin = "false";
  UpdateFcmRequest _updateFcmRequest = UpdateFcmRequest();
  bool _isLoadingFcm = false;
  bool _isCheckingLogin = false;

  HomeFcmController({
    this.fcmBloc,
    RefreshController? refreshController,
  }) : refreshController =
            refreshController ?? RefreshController(initialRefresh: false);

  /// Getter for login status
  String get isLogin => _isLogin;

  /// Getter for FCM loading state
  bool get isLoadingFcm => _isLoadingFcm;

  /// Getter for login checking state
  bool get isCheckingLogin => _isCheckingLogin;

  /// Getter for update FCM request
  UpdateFcmRequest get updateFcmRequest => _updateFcmRequest;

  /// Check if user is logged in
  bool get isUserLoggedIn => _isLogin == "true";

  /// Load FCM token
  Future<String?> loadFcmToken() async {
    try {
      _isLoadingFcm = true;
      notifyListeners();

      final token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        Helpers.log("FCM token", token);
        _updateFcmRequest.fcmToken = token;

        // Optionally trigger FCM update via bloc
        // if (fcmBloc != null) {
        //   fcmBloc!.add(FcmFetched(request: _updateFcmRequest));
        // }
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

  /// Get login status from secure storage
  Future<String> getLoginStatus() async {
    try {
      _isCheckingLogin = true;
      notifyListeners();

      final loginStatus = await SecureStorageService.getLogin();
      _isLogin = loginStatus?.toString() ?? 'false';

      _isCheckingLogin = false;
      notifyListeners();
      return _isLogin;
    } catch (e) {
      if (kDebugMode) {
        print("isLogin INVALID : $e");
      }
      _isLogin = 'false';
      _isCheckingLogin = false;
      notifyListeners();
      return _isLogin;
    }
  }

  /// Check login status and load FCM if logged in
  Future<void> checkLoginAndLoadFcm() async {
    await getLoginStatus();

    if (_isLogin == "true") {
      await loadFcmToken();
    }
  }

  /// Refresh data (pull-to-refresh)
  Future<void> refreshData() async {
    try {
      // Monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));

      // Check login status and load FCM if needed
      await checkLoginAndLoadFcm();

      // Complete refresh
      refreshController.refreshCompleted();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error refreshing data: $e');
      }
      refreshController.refreshFailed();
    }
  }

  /// Handle loading (for pull-up to load more)
  Future<void> loadMore() async {
    try {
      // Monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));

      // For now, just complete loading
      // Can be extended for pagination in the future
      refreshController.loadComplete();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error loading more: $e');
      }
      refreshController.loadFailed();
    }
  }

  /// Initialize controller - checks login status and loads FCM if needed
  Future<void> initialize() async {
    await checkLoginAndLoadFcm();
  }

  /// Reset controller state
  void reset() {
    _isLogin = "false";
    _updateFcmRequest = UpdateFcmRequest();
    _isLoadingFcm = false;
    _isCheckingLogin = false;
    notifyListeners();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
