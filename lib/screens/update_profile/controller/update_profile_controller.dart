import 'package:flutter/material.dart';

import '../../../../config/routes/go_route_generator.dart';
import '../../../../core/profile/model/response/profile_response.dart';
import '../../../../core/update_profile/bloc/update_profile_bloc.dart';
import '../../../../core/update_profile/model/request/update_profile_request.dart';
import '../../../../utils/services/storage/local_storage_service.dart';

/// Controller for managing update profile operations
///
/// Handles:
/// - Form field management (name, phone, address)
/// - Gender selection
/// - Input validation (touched state, field errors, Indonesian phone)
/// - Button enable/disable state
/// - Update profile request building
/// - Navigation after successful update
class UpdateProfileController extends ChangeNotifier {
  UpdateProfileController({
    required this.updateProfileBloc,
    required this.context,
  }) {
    nameController.addListener(_validateInput);
    phoneController.addListener(_validateInput);
    addressController.addListener(_validateInput);
  }

  final UpdateProfileBloc updateProfileBloc;
  final BuildContext context;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool _isButtonEnabled = false;
  int _selectedGender = 0;

  bool _hasNameBeenTouched = false;
  bool _hasPhoneBeenTouched = false;
  bool _hasAddressBeenTouched = false;
  bool _hasGenderBeenTouched = false;

  bool _isNameValid = false;
  bool _isPhoneValid = false;
  bool _isAddressValid = false;
  bool _isGenderValid = false;

  String? _nameError;
  String? _phoneError;
  String? _addressError;
  String? _genderError;

  String _l10nFieldRequired = 'This field is required';
  String _l10nInvalidPhone = 'Please enter a valid phone number';
  String _l10nSelectGender = 'Please select gender';

  bool get isButtonEnabled => _isButtonEnabled;

  int get selectedGender => _selectedGender;

  bool get hasNameBeenTouched => _hasNameBeenTouched;

  bool get hasPhoneBeenTouched => _hasPhoneBeenTouched;

  bool get hasAddressBeenTouched => _hasAddressBeenTouched;

  bool get hasGenderBeenTouched => _hasGenderBeenTouched;

  bool get isNameValid => _isNameValid;

  bool get isPhoneValid => _isPhoneValid;

  bool get isAddressValid => _isAddressValid;

  bool get isGenderValid => _isGenderValid;

  String? get nameError => _nameError;

  String? get phoneError => _phoneError;

  String? get addressError => _addressError;

  String? get genderError => _genderError;

  /// Indonesian mobile: local 0-prefix (10–14 digits) or +62…
  bool _isValidIndonesianPhone(String raw) {
    final t = raw.trim();
    if (t.isEmpty) return false;

    String normalized;
    if (t.startsWith('+62')) {
      final rest = t.substring(3).replaceAll(RegExp(r'\D'), '');
      normalized = '0$rest';
    } else {
      normalized = t.replaceAll(RegExp(r'\D'), '');
    }

    if (normalized.length < 10 || normalized.length > 14) return false;
    return RegExp(r'^0[0-9]{9,12}$').hasMatch(normalized);
  }

  /// Converts display/local phone to API format (+62…).
  String _phoneForApi(String raw) {
    final t = raw.trim();
    if (t.startsWith('+62')) {
      return t;
    }
    final digits = t.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('0')) {
      return '+62${digits.substring(1)}';
    }
    return t;
  }

  void markNameAsTouched() {
    if (!_hasNameBeenTouched) {
      _hasNameBeenTouched = true;
      _validateInput();
    }
  }

  void markPhoneAsTouched() {
    if (!_hasPhoneBeenTouched) {
      _hasPhoneBeenTouched = true;
      _validateInput();
    }
  }

  void markAddressAsTouched() {
    if (!_hasAddressBeenTouched) {
      _hasAddressBeenTouched = true;
      _validateInput();
    }
  }

  void markGenderAsTouched() {
    if (!_hasGenderBeenTouched) {
      _hasGenderBeenTouched = true;
      _validateInput();
    }
  }

  /// Sync localized validation messages (call from [State.didChangeDependencies]).
  void setValidationMessages({
    required String fieldRequired,
    required String invalidPhone,
    required String selectGender,
  }) {
    _l10nFieldRequired = fieldRequired;
    _l10nInvalidPhone = invalidPhone;
    _l10nSelectGender = selectGender;
    _validateInput();
  }

  Future<void> loadProfile() async {
    try {
      final profileData = await LocalStorageService.getProfile();
      if (profileData != null) {
        _populateForm(profileData);
      }
    } catch (_) {
      // Keep empty form; user can still fill manually
    }
  }

  void _populateForm(ProfileDetailData profileDetail) {
    nameController.text = profileDetail.nickname ?? '';

    String phoneText = profileDetail.phoneNumber ?? '';
    if (phoneText.startsWith('+62')) {
      phoneText = phoneText.replaceRange(0, 3, '0');
    }
    phoneController.text = phoneText;

    addressController.text = profileDetail.addressDomicile ?? '';

    if (profileDetail.gender?.toLowerCase() == 'female') {
      _selectedGender = 1;
    } else if (profileDetail.gender?.toLowerCase() == 'male') {
      _selectedGender = 2;
    } else {
      _selectedGender = 0;
    }

    _hasNameBeenTouched = false;
    _hasPhoneBeenTouched = false;
    _hasAddressBeenTouched = false;
    _hasGenderBeenTouched = false;

    _validateInput();
    notifyListeners();
  }

  void _validateInput() {
    final nameText = nameController.text.trim();
    final phoneText = phoneController.text.trim();
    final addressText = addressController.text.trim();

    String? nameError;
    final bool nameValid;
    if (nameText.isEmpty) {
      nameValid = false;
      nameError = _hasNameBeenTouched ? _l10nFieldRequired : null;
    } else {
      nameValid = true;
      nameError = null;
    }

    String? phoneError;
    final bool phoneValid;
    if (phoneText.isEmpty) {
      phoneValid = false;
      phoneError = _hasPhoneBeenTouched ? _l10nFieldRequired : null;
    } else if (!_isValidIndonesianPhone(phoneController.text)) {
      phoneValid = false;
      phoneError = _hasPhoneBeenTouched ? _l10nInvalidPhone : null;
    } else {
      phoneValid = true;
      phoneError = null;
    }

    String? addressError;
    final bool addressValid;
    if (addressText.isEmpty) {
      addressValid = false;
      addressError = _hasAddressBeenTouched ? _l10nFieldRequired : null;
    } else {
      addressValid = true;
      addressError = null;
    }

    final genderValid = _selectedGender == 1 || _selectedGender == 2;
    String? genderError;
    if (!genderValid) {
      genderError = _hasGenderBeenTouched ? _l10nSelectGender : null;
    } else {
      genderError = null;
    }

    var shouldNotify = false;

    if (_isNameValid != nameValid ||
        _nameError != nameError ||
        _isPhoneValid != phoneValid ||
        _phoneError != phoneError ||
        _isAddressValid != addressValid ||
        _addressError != addressError ||
        _isGenderValid != genderValid ||
        _genderError != genderError) {
      _isNameValid = nameValid;
      _nameError = nameError;
      _isPhoneValid = phoneValid;
      _phoneError = phoneError;
      _isAddressValid = addressValid;
      _addressError = addressError;
      _isGenderValid = genderValid;
      _genderError = genderError;
      shouldNotify = true;
    }

    final newButtonState =
        nameValid && phoneValid && addressValid && genderValid;

    if (_isButtonEnabled != newButtonState) {
      _isButtonEnabled = newButtonState;
      shouldNotify = true;
    }

    if (shouldNotify) {
      notifyListeners();
    }
  }

  void setGender(int gender) {
    if (gender != _selectedGender && (gender == 1 || gender == 2)) {
      _selectedGender = gender;
      _hasGenderBeenTouched = true;
      _validateInput();
    }
  }

  UpdateProfileRequest buildUpdateProfileRequest() {
    final request = UpdateProfileRequest();
    request.nickname = nameController.text.trim();
    request.addressDomicile = addressController.text.trim();
    request.phoneNumber = _phoneForApi(phoneController.text);
    request.urlProfilePicture = '';
    request.gender = _selectedGender == 1 ? 'female' : 'male';
    return request;
  }

  void executeUpdateProfile() {
    final request = buildUpdateProfileRequest();
    updateProfileBloc.add(UpdateProfileFetched(request: request));
  }

  void handleSuccessfulUpdate() {
    if (context.mounted) {
      context.popRoute();
    }
  }

  void handleUpdateError(String errorMessage) {}

  void clearFields() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    _selectedGender = 0;
    _hasNameBeenTouched = false;
    _hasPhoneBeenTouched = false;
    _hasAddressBeenTouched = false;
    _hasGenderBeenTouched = false;
    _isButtonEnabled = false;
    _validateInput();
    notifyListeners();
  }

  bool get isValid =>
      _isNameValid &&
      _isPhoneValid &&
      _isAddressValid &&
      _isGenderValid;

  bool validateAll() {
    _hasNameBeenTouched = true;
    _hasPhoneBeenTouched = true;
    _hasAddressBeenTouched = true;
    _hasGenderBeenTouched = true;
    _validateInput();
    return isValid;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
