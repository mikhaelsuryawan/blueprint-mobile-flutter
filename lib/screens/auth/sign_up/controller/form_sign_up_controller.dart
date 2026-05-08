import 'package:blueprint_mobile_flutter/config/themes/app_colors.dart';
import 'package:blueprint_mobile_flutter/constants/app_constants.dart';
import 'package:blueprint_mobile_flutter/utils/helpers.dart';
import 'package:flutter/material.dart';

/// Form state, validation, and text controllers for sign-up.
///
/// Mirrors [FormLoginController]: touched flags, per-field errors, and
/// border/error display driven by getters.
class FormSignUpController extends ChangeNotifier {
  FormSignUpController() {
    nameController.addListener(_validateInput);
    birthDateController.addListener(_validateInput);
    emailController.addListener(_validateInput);
    phoneController.addListener(_validateInput);
    passwordController.addListener(_validateInput);
    confirmPasswordController.addListener(_validateInput);
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isButtonEnabled = false;
  bool _isShowPassword = false;
  bool _isShowConfirmPassword = false;
  int _genderId = 0;
  DateTime? _selectedBirthDate;

  bool _hasNameBeenTouched = false;
  bool _hasBirthDateBeenTouched = false;
  bool _hasGenderBeenTouched = false;
  bool _hasEmailBeenTouched = false;
  bool _hasPhoneBeenTouched = false;
  bool _hasPasswordBeenTouched = false;
  bool _hasConfirmPasswordBeenTouched = false;

  bool get isButtonEnabled => _isButtonEnabled;

  bool get isShowPassword => _isShowPassword;

  bool get isShowConfirmPassword => _isShowConfirmPassword;

  int get genderId => _genderId;

  DateTime? get selectedBirthDate => _selectedBirthDate;

  bool get hasNameBeenTouched => _hasNameBeenTouched;

  bool get hasBirthDateBeenTouched => _hasBirthDateBeenTouched;

  bool get hasGenderBeenTouched => _hasGenderBeenTouched;

  bool get hasEmailBeenTouched => _hasEmailBeenTouched;

  bool get hasPhoneBeenTouched => _hasPhoneBeenTouched;

  bool get hasPasswordBeenTouched => _hasPasswordBeenTouched;

  bool get hasConfirmPasswordBeenTouched => _hasConfirmPasswordBeenTouched;

  bool get nameFieldInvalid =>
      _hasNameBeenTouched && nameController.text.trim().isEmpty;

  bool get birthDateFieldInvalid =>
      _hasBirthDateBeenTouched && _selectedBirthDate == null;

  bool get genderFieldInvalid =>
      _hasGenderBeenTouched && _genderId == 0;

  bool get emailFieldInvalid {
    if (!_hasEmailBeenTouched) return false;
    final t = emailController.text.trim();
    return t.isEmpty || !Helpers.validateEmail(emailController.text);
  }

  bool get phoneFieldInvalid {
    if (!_hasPhoneBeenTouched) return false;
    final t = phoneController.text.trim();
    return t.isEmpty || !Helpers.validatePhoneNumber(phoneController.text);
  }

  bool get passwordFieldInvalid {
    if (!_hasPasswordBeenTouched) return false;
    final p = passwordController.text;
    return p.isEmpty || !Helpers.validatePassword(p);
  }

  bool get confirmPasswordFieldInvalid {
    if (!_hasConfirmPasswordBeenTouched) return false;
    final c = confirmPasswordController.text;
    final p = passwordController.text;
    return c.isEmpty || c != p;
  }

  /// Email error line (like [FormLoginController.emailError]): empty shows no helper text.
  String? get emailErrorMessage {
    if (!_hasEmailBeenTouched) return null;
    final t = emailController.text.trim();
    if (t.isEmpty) return null;
    if (!Helpers.validateEmail(emailController.text)) {
      return AppConstant.errorMessageEmail;
    }
    return null;
  }

  void markNameAsTouched() {
    if (!_hasNameBeenTouched) {
      _hasNameBeenTouched = true;
      _validateInput();
    }
  }

  void markBirthDateAsTouched() {
    if (!_hasBirthDateBeenTouched) {
      _hasBirthDateBeenTouched = true;
      _validateInput();
    }
  }

  void markGenderAsTouched() {
    if (!_hasGenderBeenTouched) {
      _hasGenderBeenTouched = true;
      _validateInput();
    }
  }

  void markEmailAsTouched() {
    var changed = false;
    if (!_hasEmailBeenTouched) {
      _hasEmailBeenTouched = true;
      changed = true;
    }
    if (_genderId == 0 && !_hasGenderBeenTouched) {
      _hasGenderBeenTouched = true;
      changed = true;
    }
    if (changed) _validateInput();
  }

  void markPhoneAsTouched() {
    if (!_hasPhoneBeenTouched) {
      _hasPhoneBeenTouched = true;
      _validateInput();
    }
  }

  void markPasswordAsTouched() {
    if (!_hasPasswordBeenTouched) {
      _hasPasswordBeenTouched = true;
      _validateInput();
    }
  }

  void markConfirmPasswordAsTouched() {
    if (!_hasConfirmPasswordBeenTouched) {
      _hasConfirmPasswordBeenTouched = true;
      _validateInput();
    }
  }

  void _validateInput() {
    final nameOk = nameController.text.trim().isNotEmpty;
    final birthDateOk = _selectedBirthDate != null;
    final genderOk = _genderId != 0;
    final emailOk = Helpers.validateEmail(emailController.text);
    final phoneOk = phoneController.text.trim().isNotEmpty &&
        Helpers.validatePhoneNumber(phoneController.text);
    final passwordOk = passwordController.text.isNotEmpty &&
        Helpers.validatePassword(passwordController.text);
    final confirmOk =
        confirmPasswordController.text == passwordController.text &&
            confirmPasswordController.text.isNotEmpty;

    final next = nameOk &&
        birthDateOk &&
        genderOk &&
        emailOk &&
        phoneOk &&
        passwordOk &&
        confirmOk;

    if (_isButtonEnabled != next) {
      _isButtonEnabled = next;
    }
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isShowConfirmPassword = !_isShowConfirmPassword;
    notifyListeners();
  }

  void setGender(BuildContext context, int value) {
    FocusScope.of(context).requestFocus(FocusNode());
    _hasGenderBeenTouched = true;
    _genderId = value;
    _validateInput();
  }

  /// Theme for [showDatePicker]: readable selected day and action buttons.
  static DatePickerThemeData _birthDatePickerTheme() {
    return DatePickerThemeData(
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.accent_light;
        }
        return null;
      }),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white_FFFFFF;
        }
        return null;
      }),
      todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.accent_light;
        }
        return null;
      }),
      todayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white_FFFFFF;
        }
        return null;
      }),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: AppColors.slate_surface_500,
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: AppColors.accent_light,
      ),
    );
  }

  Future<void> pickBirthDate(BuildContext context) async {
    markBirthDateAsTouched();
    FocusScope.of(context).requestFocus(FocusNode());
    final theme = Theme.of(context);
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            datePickerTheme: _birthDatePickerTheme(),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _selectedBirthDate = picked;
      birthDateController.text = Helpers.formatDateOnly(picked);
      _validateInput();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
