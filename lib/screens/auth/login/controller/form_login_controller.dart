import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

enum PasswordValidationRule {
  minLength,
  number,
  uppercase,
  specialCharacter,
}

/// Controller for managing login form state
///
/// Handles:
/// - Email and password text controllers
/// - Input validation (including email format validation)
/// - Button enable/disable state
/// - Password visibility toggle
/// - Email validation error messages
class FormLoginController extends ChangeNotifier {
  FormLoginController({
    Set<PasswordValidationRule>? enabledPasswordRules,
  }) : _enabledPasswordRules = enabledPasswordRules ??
            {
              PasswordValidationRule.minLength,
              PasswordValidationRule.number,
              PasswordValidationRule.uppercase,
              PasswordValidationRule.specialCharacter,
            } {
    // Listen to text changes for validation
    emailController.addListener(_validateInput);
    passwordController.addListener(_validateInput);
  }

  // Text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // State
  bool _isButtonEnabled = false;
  bool _isShowPassword = false;
  bool _isEmailValid = true;
  bool _hasEmailBeenTouched = false;
  bool _isPasswordValid = false;
  bool _hasPasswordBeenTouched = false;
  String? _emailError;
  String? _passwordError;
  Set<PasswordValidationRule> _enabledPasswordRules;

  /// Getter for button enabled state
  bool get isButtonEnabled => _isButtonEnabled;

  /// Getter for password visibility state
  bool get isShowPassword => _isShowPassword;

  /// Getter for email validation state
  bool get isEmailValid => _isEmailValid;

  /// Getter for password validation state
  bool get isPasswordValid => _isPasswordValid;

  /// Getter for email error message
  String? get emailError => _emailError;

  /// Getter for password error message
  String? get passwordError => _passwordError;

  /// Getter for whether email field has been touched/interacted with
  bool get hasEmailBeenTouched => _hasEmailBeenTouched;

  /// Getter for whether password field has been touched/interacted with
  bool get hasPasswordBeenTouched => _hasPasswordBeenTouched;

  /// Getter for email text
  String get email => emailController.text.trim();

  /// Getter for password text
  String get password => passwordController.text.trim();

  /// Getter for enabled password rules
  Set<PasswordValidationRule> get enabledPasswordRules =>
      Set.unmodifiable(_enabledPasswordRules);

  /// Mark email field as touched (user has interacted with it)
  void markEmailAsTouched() {
    if (!_hasEmailBeenTouched) {
      _hasEmailBeenTouched = true;
      _validateInput();
    }
  }

  /// Mark password field as touched (user has interacted with it)
  void markPasswordAsTouched() {
    if (!_hasPasswordBeenTouched) {
      _hasPasswordBeenTouched = true;
      _validateInput();
    }
  }

  /// Validate email format
  bool _validateEmailFormat(String email) {
    if (email.isEmpty) {
      return false;
    }
    return EmailValidator.validate(email);
  }

  bool _containsNumber(String value) => RegExp(r'\d').hasMatch(value);

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
        return _containsNumber(password);
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

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return null;
    }

    final unmetRules = _enabledPasswordRules
        .where((rule) => !_isPasswordRuleSatisfied(rule, password))
        .map(_passwordRuleMessage)
        .toList();

    if (unmetRules.isEmpty) {
      return null;
    }

    return unmetRules.join(', ');
  }

  /// Update enabled password validation rules dynamically.
  void setEnabledPasswordRules(Set<PasswordValidationRule> rules) {
    _enabledPasswordRules = {...rules};
    _validateInput();
  }

  /// Validate input and update button state
  void _validateInput() {
    final emailText = emailController.text.trim();
    final passwordText = passwordController.text.trim();

    // Validate email format (always check if email has content)
    bool emailValid = true;
    String? emailError;

    if (emailText.isEmpty) {
      // Empty email is invalid but don't show error until field is touched
      emailValid = false;
      emailError = null;
    } else if (!_validateEmailFormat(emailText)) {
      // Invalid email format - show error only if field has been touched
      emailValid = false;
      emailError =
          _hasEmailBeenTouched ? 'Please enter a valid email address' : null;
    } else {
      // Valid email
      emailValid = true;
      emailError = null;
    }

    // Update email validation state only if changed
    bool shouldNotify = false;
    if (_isEmailValid != emailValid || _emailError != emailError) {
      _isEmailValid = emailValid;
      _emailError = emailError;
      shouldNotify = true;
    }

    final passwordError = _validatePassword(passwordText);
    final passwordValid = passwordText.isNotEmpty && passwordError == null;

    if (_isPasswordValid != passwordValid || _passwordError != passwordError) {
      _isPasswordValid = passwordValid;
      _passwordError = passwordError;
      shouldNotify = true;
    }

    // Button is enabled only when email is valid and password passes rules
    final newState = emailValid && passwordValid;

    if (_isButtonEnabled != newState || shouldNotify) {
      _isButtonEnabled = newState;
      notifyListeners();
    }
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  /// Set password visibility explicitly
  void setPasswordVisibility(bool isVisible) {
    if (_isShowPassword != isVisible) {
      _isShowPassword = isVisible;
      notifyListeners();
    }
  }

  /// Clear form fields
  void clearFields() {
    emailController.clear();
    passwordController.clear();
    _isButtonEnabled = false;
    _isShowPassword = false;
    _isEmailValid = true;
    _isPasswordValid = false;
    _hasEmailBeenTouched = false;
    _hasPasswordBeenTouched = false;
    _emailError = null;
    _passwordError = null;
    notifyListeners();
  }

  /// Set email and password values (used when loading saved credentials)
  void setCredentials(String email, String password) {
    emailController.text = email;
    passwordController.text = password;
    _hasEmailBeenTouched = true; // Mark as touched since we're pre-filling
    // _validateInput will be called automatically via listeners
  }

  /// Check if form is valid (email format valid and password passes rules)
  bool get isValid => _isEmailValid && email.isNotEmpty && _isPasswordValid;

  /// Validate all fields and return validation state
  /// Useful for triggering validation on form submission
  bool validateAll() {
    _hasEmailBeenTouched = true;
    _hasPasswordBeenTouched = true;
    _validateInput();
    return isValid;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
