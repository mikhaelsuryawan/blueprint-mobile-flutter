import 'package:blueprint_mobile_flutter/config/language/app_localizations.dart';
import 'package:blueprint_mobile_flutter/config/routes/go_route_generator.dart';
import 'package:blueprint_mobile_flutter/core/sign_up/bloc/sign_up_bloc.dart';
import 'package:blueprint_mobile_flutter/core/sign_up/model/request/sign_up_request.dart';
import 'package:blueprint_mobile_flutter/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'form_sign_up_controller.dart';

/// Dispatches sign-up and handles post-submit navigation / feedback.
class ButtonSignUpController {
  ButtonSignUpController({
    required this.signUpBloc,
    required this.context,
  });

  final SignUpBloc signUpBloc;
  final BuildContext context;

  void executeSignUp(FormSignUpController form) {
    final request = SignUpRequest(
      name: form.nameController.text.trim(),
      birthDate: form.selectedBirthDate != null
          ? DateFormat('dd-MM-yyyy').format(form.selectedBirthDate!)
          : '',
      gender: form.genderId == 1 ? 'Female' : 'Male',
      email: form.emailController.text.trim(),
      phoneNumber: form.phoneController.text.trim(),
      password: form.passwordController.text,
      confirmationPassword: form.confirmPasswordController.text,
    );

    signUpBloc.add(SignUpFetched(request: request));
  }

  void navigationAfterSignUp() {
    context.popRoute();
    Helpers.showToast(
      context,
      GetAppLocalizations(context).successRegisterMessage,
    );
  }
}
