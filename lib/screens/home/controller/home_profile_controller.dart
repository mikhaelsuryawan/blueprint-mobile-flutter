import 'package:flutter/foundation.dart';

import '../../../core/profile/bloc/profile_bloc.dart';
import '../../../core/profile/model/response/profile_response.dart';

/// Drives home header profile UI from [ProfileBloc] (no pull-to-refresh ownership).
class HomeProfileController extends ChangeNotifier {
  final ProfileBloc profileBloc;

  ProfileDetailData? _profileData;
  bool _isLoading = false;
  String? _errorMessage;

  HomeProfileController({required this.profileBloc}) {
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
}
