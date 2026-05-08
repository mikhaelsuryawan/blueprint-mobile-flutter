import 'package:flutter/material.dart';

import '../../../../config/routes/go_route_generator.dart';
import '../../../../core/change_password/bloc/change_password_bloc.dart';
import '../../../../core/change_password/model/request/change_password_request.dart';
import '../../login/controller/form_login_controller.dart';

/// Controller for managing change password operations
///
/// Validation:
/// - Old password required, min. 6 characters
/// - New password: min. 6 chars, uppercase, special character; must differ from old
/// - Confirm must match new (and thus satisfies the same rules)
class ChangePasswordController extends ChangeNotifier {
  ChangePasswordController({
    required this.changePasswordBloc,
    required this.context,
    Set<PasswordValidationRule>? newPasswordRules,
  }) : _newPasswordRules = newPasswordRules ??
            {
              PasswordValidationRule.minLength,
              PasswordValidationRule.uppercase,
              PasswordValidationRule.specialCharacter,
            } {
    oldPasswordController.addListener(_validateInput);
    passwordController.addListener(_validateInput);
    confPasswordController.addListener(_validateInput);
  }

  final ChangePasswordBloc changePasswordBloc;
  final BuildContext context;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();

  final Set<PasswordValidationRule> _newPasswordRules;

  bool _isShowOldPassword = false;
  bool _isShowPassword = false;
  bool _isShowConfPassword = false;
  bool _isButtonEnabled = false;

  bool _hasOldBeenTouched = false;
  bool _hasNewBeenTouched = false;
  bool _hasConfirmBeenTouched = false;

  bool _isOldPasswordValid = false;
  bool _isNewPasswordValid = false;
  bool _isConfirmPasswordValid = false;

  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  String _l10nOldPasswordRequired = 'Please enter your current password';
  String _l10nPasswordMinLength = 'Password must be at least 6 characters';
  String _l10nNewPasswordRequired = 'Please enter a new password';
  String _l10nConfirmPasswordRequired = 'Please confirm your new password';
  String _l10nPasswordMismatch = 'Password doesn\'t match';
  String _l10nNewPasswordSameAsOld =
      'New password must be different from your current password';

  bool get isButtonEnabled => _isButtonEnabled;

  bool get isShowOldPassword => _isShowOldPassword;

  bool get isShowPassword => _isShowPassword;

  bool get isShowConfPassword => _isShowConfPassword;

  bool get hasOldBeenTouched => _hasOldBeenTouched;

  bool get hasNewBeenTouched => _hasNewBeenTouched;

  bool get hasConfirmBeenTouched => _hasConfirmBeenTouched;

  bool get isOldPasswordValid => _isOldPasswordValid;

  bool get isNewPasswordValid => _isNewPasswordValid;

  bool get isConfirmPasswordValid => _isConfirmPasswordValid;

  String? get oldPasswordError => _oldPasswordError;

  String? get newPasswordError => _newPasswordError;

  String? get confirmPasswordError => _confirmPasswordError;

  Set<PasswordValidationRule> get newPasswordRules =>
      Set.unmodifiable(_newPasswordRules);

  void setValidationMessages({
    required String oldPasswordRequired,
    required String passwordMinLength,
    required String newPasswordRequired,
    required String confirmPasswordRequired,
    required String passwordMismatch,
    required String newPasswordSameAsOld,
  }) {
    _l10nOldPasswordRequired = oldPasswordRequired;
    _l10nPasswordMinLength = passwordMinLength;
    _l10nNewPasswordRequired = newPasswordRequired;
    _l10nConfirmPasswordRequired = confirmPasswordRequired;
    _l10nPasswordMismatch = passwordMismatch;
    _l10nNewPasswordSameAsOld = newPasswordSameAsOld;
    _validateInput();
  }

  bool _containsUppercase(String value) => RegExp(r'[A-Z]').hasMatch(value);

  bool _containsSpecialCharacter(String value) =>
      RegExp(r'[!@#$%^&*(),.?":{}|<>\[\]\\\/_\-+=~`]').hasMatch(value);

  bool _isPasswordRuleSatisfied(
    PasswordValidationRule rule,
    String password,
  ) {
    switch (rule) {
      case PasswordValidationRule.minLength:
        return password.length >= 6;
      case PasswordValidationRule.number:
        return RegExp(r'\d').hasMatch(password);
      case PasswordValidationRule.uppercase:
        return _containsUppercase(password);
      case PasswordValidationRule.specialCharacter:
        return _containsSpecialCharacter(password);
    }
  }

  String _passwordRuleMessage(PasswordValidationRule rule) {
    switch (rule) {
      case PasswordValidationRule.minLength:
        return 'min. 6 characters';
      case PasswordValidationRule.number:
        return 'include number';
      case PasswordValidationRule.uppercase:
        return 'include capitalization';
      case PasswordValidationRule.specialCharacter:
        return 'include special character';
    }
  }

  /// Rule messages for new password (same wording as [FormLoginController]).
  String? _validateNewPasswordRules(String password) {
    if (password.isEmpty) {
      return null;
    }
    final unmet = _newPasswordRules
        .where((r) => !_isPasswordRuleSatisfied(r, password))
        .map(_passwordRuleMessage)
        .toList();
    if (unmet.isEmpty) {
      return null;
    }
    return unmet.join(', ');
  }

  void markOldPasswordAsTouched() {
    if (!_hasOldBeenTouched) {
      _hasOldBeenTouched = true;
      _validateInput();
    }
  }

  void markNewPasswordAsTouched() {
    if (!_hasNewBeenTouched) {
      _hasNewBeenTouched = true;
      _validateInput();
    }
  }

  void markConfirmPasswordAsTouched() {
    if (!_hasConfirmBeenTouched) {
      _hasConfirmBeenTouched = true;
      _validateInput();
    }
  }

  void toggleOldPasswordVisibility() {
    _isShowOldPassword = !_isShowOldPassword;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  void toggleConfPasswordVisibility() {
    _isShowConfPassword = !_isShowConfPassword;
    notifyListeners();
  }

  void setOldPasswordVisibility(bool visible) {
    if (_isShowOldPassword != visible) {
      _isShowOldPassword = visible;
      notifyListeners();
    }
  }

  void setPasswordVisibility(bool visible) {
    if (_isShowPassword != visible) {
      _isShowPassword = visible;
      notifyListeners();
    }
  }

  void setConfPasswordVisibility(bool visible) {
    if (_isShowConfPassword != visible) {
      _isShowConfPassword = visible;
      notifyListeners();
    }
  }

  void _validateInput() {
    final oldTrim = oldPasswordController.text.trim();
    final newTrim = passwordController.text.trim();
    final confTrim = confPasswordController.text.trim();

    // --- Old password
    String? oldError;
    final bool oldValid;
    if (oldTrim.isEmpty) {
      oldValid = false;
      oldError = _hasOldBeenTouched ? _l10nOldPasswordRequired : null;
    } else if (oldTrim.length < 6) {
      oldValid = false;
      oldError = _hasOldBeenTouched ? _l10nPasswordMinLength : null;
    } else {
      oldValid = true;
      oldError = null;
    }

    // --- New password
    String? newError;
    final bool newValid;
    if (newTrim.isEmpty) {
      newValid = false;
      newError = _hasNewBeenTouched ? _l10nNewPasswordRequired : null;
    } else if (oldTrim.isNotEmpty &&
        newTrim.isNotEmpty &&
        oldTrim == newTrim) {
      newValid = false;
      newError = _hasNewBeenTouched ? _l10nNewPasswordSameAsOld : null;
    } else {
      final rulesMsg = _validateNewPasswordRules(newTrim);
      newValid = rulesMsg == null;
      newError = _hasNewBeenTouched ? rulesMsg : null;
    }

    // --- Confirm (must match new; same rules as new when equal)
    String? confError;
    final bool confValid;
    if (confTrim.isEmpty) {
      confValid = false;
      confError = _hasConfirmBeenTouched ? _l10nConfirmPasswordRequired : null;
    } else if (newTrim != confTrim) {
      confValid = false;
      confError = _hasConfirmBeenTouched ? _l10nPasswordMismatch : null;
    } else {
      confValid = newValid;
      confError = null;
    }

    var shouldNotify = false;

    if (_isOldPasswordValid != oldValid ||
        _oldPasswordError != oldError ||
        _isNewPasswordValid != newValid ||
        _newPasswordError != newError ||
        _isConfirmPasswordValid != confValid ||
        _confirmPasswordError != confError) {
      _isOldPasswordValid = oldValid;
      _oldPasswordError = oldError;
      _isNewPasswordValid = newValid;
      _newPasswordError = newError;
      _isConfirmPasswordValid = confValid;
      _confirmPasswordError = confError;
      shouldNotify = true;
    }

    final newState = oldValid &&
        newValid &&
        confValid &&
        confTrim.isNotEmpty &&
        newTrim == confTrim &&
        oldTrim != newTrim;

    if (_isButtonEnabled != newState) {
      _isButtonEnabled = newState;
      shouldNotify = true;
    }

    if (shouldNotify) {
      notifyListeners();
    }
  }

  ChangePasswordRequest buildChangePasswordRequest() {
    final request = ChangePasswordRequest();
    request.oldPassword = oldPasswordController.text.trim();
    request.newPassword = passwordController.text.trim();
    request.confirmNewPassword = confPasswordController.text.trim();
    return request;
  }

  void executeChangePassword() {
    changePasswordBloc.add(
      ChangePasswordFetched(request: buildChangePasswordRequest()),
    );
  }

  void handleSuccessfulChange() {
    if (context.mounted) {
      context.popRoute();
    }
  }

  void handleChangeError(String errorMessage) {}

  void clearFields() {
    oldPasswordController.clear();
    passwordController.clear();
    confPasswordController.clear();
    _hasOldBeenTouched = false;
    _hasNewBeenTouched = false;
    _hasConfirmBeenTouched = false;
    _isButtonEnabled = false;
    _validateInput();
    notifyListeners();
  }

  bool get isValid =>
      _isOldPasswordValid &&
      _isNewPasswordValid &&
      _isConfirmPasswordValid;

  bool validateAll() {
    _hasOldBeenTouched = true;
    _hasNewBeenTouched = true;
    _hasConfirmBeenTouched = true;
    _validateInput();
    return _isButtonEnabled;
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    confPasswordController.dispose();
    super.dispose();
  }
}
