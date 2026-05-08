import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../core/profile/bloc/profile_bloc.dart';
import '../../../core/profile/model/response/profile_response.dart';

/// Profile screen: same role as [HomeProfileController], plus [RefreshController].
class ProfileController extends ChangeNotifier {
  final ProfileBloc profileBloc;
  final RefreshController refreshController;

  ProfileDetailData? _profileData;
  bool _isLoading = false;
  String? _errorMessage;

  ProfileController({
    required this.profileBloc,
    RefreshController? refreshController,
  }) : refreshController =
            refreshController ?? RefreshController(initialRefresh: false) {
    loadProfile();
  }

  ProfileDetailData? get profileData => _profileData;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  bool get hasProfileData => _profileData != null;

  String get displayName {
    final d = _profileData;
    if (d == null) return '';
    final name = d.fullname?.trim();
    if (name != null && name.isNotEmpty) return name;
    final nick = d.nickname?.trim();
    if (nick != null && nick.isNotEmpty) return nick;
    return '';
  }

  String get jobTitle => _profileData?.job?.name?.trim() ?? '';

  String get profilePictureUrl => _profileData?.urlProfilePicture?.trim() ?? '';

  void loadProfile() {
    profileBloc.add(ProfileFetched());
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
  }

  void handleProfileLoaded(ProfileDetailData profileData) {
    _profileData = profileData;
    _isLoading = false;
    _errorMessage = null;
    profileBloc.add(ProfileIdleEvent());
    notifyListeners();
  }

  void handleProfileError(String message) {
    _isLoading = false;
    _errorMessage = message;
    profileBloc.add(ProfileIdleEvent());
    notifyListeners();
  }

  void handleProfileLoading() {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
  }

  /// Pull-to-refresh
  Future<void> refreshProfile() async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      loadProfile();
      refreshController.refreshCompleted();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error refreshing profile: $e');
      }
      refreshController.refreshFailed();
    }
  }

  /// Pull-up load more (placeholder)
  Future<void> loadMore() async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      refreshController.loadComplete();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error loading more: $e');
      }
      refreshController.loadFailed();
    }
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
