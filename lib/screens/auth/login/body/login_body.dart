import 'package:blueprint_mobile_flutter/widgets/textfield/textfield_default.dart';
import 'package:blueprint_mobile_flutter/widgets/textfield/textfield_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/language/app_localizations.dart';
import '../../../../config/routes/go_route_generator.dart';
import '../../../../config/routes/routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../config/themes/notifiers/theme_manager.dart';
import '../../../../core/login/bloc/login_bloc.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/responsive_configuration.dart';
import '../../../../widgets/buttons/edge_button_medium.dart';
import '../../../../widgets/loadings/loading.dart';
import '../controller/button_login_controller.dart';
import '../controller/form_login_controller.dart';
import '../controller/remember_controller.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  /// Controllers
  late final FormLoginController _formController;
  late final RememberController _rememberController;
  late final ButtonLoginController _buttonController;
  late final LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _loginBloc = context.read<LoginBloc>();
    _formController = FormLoginController(
      enabledPasswordRules: {
        PasswordValidationRule.minLength,
        // PasswordValidationRule.number,
        // PasswordValidationRule.uppercase,
        // PasswordValidationRule.specialCharacter,
      },
    );
    _rememberController = RememberController();
    _buttonController = ButtonLoginController(
      loginBloc: _loginBloc,
      context: context,
    );

    // Load saved credentials
    _loadSavedCredentials();
  }

  /// Load saved credentials from remember me
  Future<void> _loadSavedCredentials() async {
    final credentials = await _rememberController.loadSavedCredentials();

    if (credentials != null) {
      final rememberMe = credentials['rememberMe'] == 'true';
      final username = credentials['username'] ?? '';
      final password = credentials['password'] ?? '';

      if (rememberMe && username.isNotEmpty && password.isNotEmpty) {
        _formController.setCredentials(username, password);
      }
    }
  }

  /// Execute login action
  void _executeLogin() {
    // Validate all fields before submitting
    if (_formController.validateAll()) {
      _buttonController.executeLogin(
        _formController.email,
        _formController.password,
        rememberMe: _rememberController.isRememberMe,
      );
    }
  }

  _widgetDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100.w,
          margin: EdgeInsets.only(
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
          ),
          child: Text(
            GetAppLocalizations(context).welcome,
            textAlign: TextAlign.left,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.bodyLarge,
            ),
          ).animate().fadeIn(duration: 600.ms).slideX(),
        ),
        Container(
          margin: EdgeInsets.only(
            top: pxToSp(context, 18),
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
            bottom: pxToSp(context, 18),
          ),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit",
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ).animate().fadeIn(duration: 600.ms).slideX(),
        ),
      ],
    );
  }

  _widgetForm() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: pxToSp(context, 18),
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            GetAppLocalizations(context).email,
            textAlign: TextAlign.left,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ).animate().fadeIn(duration: 600.ms).move(),
        ),
        SizedBox(height: pxToSp(context, 12.5)),
        Container(
          margin: EdgeInsets.only(
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
          ),
          child: ListenableBuilder(
            listenable: _formController,
            builder: (context, _) {
              final emailInvalid = _formController.hasEmailBeenTouched &&
                  !_formController.isEmailValid;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextfieldDefault(
                    key: Key('login_email'),
                    controller: _formController.emailController,
                    textColor: Theme.of(
                      context,
                    ).textTheme.displayMedium!.color!,
                    enabledBorderColor: emailInvalid
                        ? AppColors.error_primary_400
                        : AppColors.accent_light,
                    focusedBorderColor: emailInvalid
                        ? AppColors.error_primary_400
                        : AppColors.accent_light,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    hintText: GetAppLocalizations(
                      context,
                    ).inputYourEmailAddress,
                    onChanged: (value) {
                      _formController.markEmailAsTouched();
                      // Validation is handled automatically by FormLoginController
                    },
                  ).animate().fadeIn(duration: 600.ms).move(),
                  if (_formController.hasEmailBeenTouched &&
                      _formController.emailError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 8.sp, left: 4.sp),
                      child: Text(
                        _formController.emailError!,
                        style: AppThemeNotifier.getTextStyleFromTheme(
                          baseStyle: Theme.of(context).textTheme.bodySmall,
                          color: AppColors.error_primary_400,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: pxToSp(context, 18),
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            GetAppLocalizations(context).password,
            textAlign: TextAlign.left,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 600.ms).move(),
        ),
        SizedBox(height: pxToSp(context, 12.5)),
        Container(
          margin: EdgeInsets.only(
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
          ),
          child: ListenableBuilder(
            listenable: _formController,
            builder: (context, _) {
              final passwordInvalid = _formController.hasPasswordBeenTouched &&
                  !_formController.isPasswordValid;
              return TextfieldPassword(
                key: Key('login_password'),
                controller: _formController.passwordController,
                textColor: Theme.of(context).textTheme.displayMedium!.color!,
                enabledBorderColor: passwordInvalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                focusedBorderColor: passwordInvalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.text,
                hintText: GetAppLocalizations(context).inputYourPassword,
                obscureText: !_formController.isShowPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    _formController.togglePasswordVisibility();
                  },
                  icon: Icon(
                    _formController.isShowPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: Theme.of(context).iconTheme.color!,
                ),
                showError: _formController.hasPasswordBeenTouched &&
                    !_formController.isPasswordValid,
                errorMessage: _formController.passwordError,
                onChanged: (value) {
                  _formController.markPasswordAsTouched();
                },
              ).animate().fadeIn(duration: 600.ms, delay: 600.ms).move();
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: pxToSp(context, 12),
            right: pxToSp(context, 18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListenableBuilder(
                  listenable: _rememberController,
                  builder: (context, _) {
                    return Row(
                      children: [
                        Checkbox(
                          value: _rememberController.isRememberMe,
                          onChanged: (value) {
                            _rememberController.setRememberMe(value ?? false);
                          },
                          activeColor: AppColors.accent_light,
                        ),
                        Text(
                          GetAppLocalizations(context).rememberMe,
                          overflow: TextOverflow.ellipsis,
                          style: AppThemeNotifier.getTextStyleFromTheme(
                            baseStyle: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    );
                  },
                ).animate().fadeIn(duration: 600.ms, delay: 1200.ms).slideX(),
              ),
              InkWell(
                onTap: () {
                  context.pushTo(forgotPasswordRoute);
                },
                child: Text(
                  GetAppLocalizations(context).forgotPassword + "?",
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    baseStyle: Theme.of(context).textTheme.bodyMedium,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.accent_light
                        : Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 1200.ms)
                  .slideX(begin: 1),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 18)),
          child: BlocListener<LoginBloc, LoginState>(
            listenWhen: (previous, current) =>
                current is LoginLoaded || current is LoginError,
            listener: (context, state) {
              if (state is LoginLoaded) {
                Helpers.onWidgetDidBuild(() {
                  if (!mounted) return;
                  _buttonController.handleSuccessfulLogin(
                    _formController.email,
                    _formController.password,
                    rememberMe: _rememberController.isRememberMe,
                  );
                });
                _loginBloc.add(LoginIdleEvent());
              } else if (state is LoginError) {
                Helpers.onWidgetDidBuild(() {
                  if (!mounted) return;
                  Helpers.showToast(context, state.textError);
                });
                _loginBloc.add(LoginIdleEvent());
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              bloc: _loginBloc,
              buildWhen: (previous, current) =>
                  current is LoginInitState ||
                  current is LoginIdleState ||
                  current is LoginLoading ||
                  current is LoginLoaded ||
                  current is LoginError,
              builder: (context, state) {
                final bool isSubmitting =
                    state is LoginLoading || state is LoginLoaded;

                return ListenableBuilder(
                  listenable: _formController,
                  builder: (context, _) {
                    return Column(
                      children: [
                        Loading(
                          isShow: isSubmitting,
                          color: AppColors.accent_light,
                        ),
                        Visibility(
                          visible: !isSubmitting,
                          child: EdgeButtonMedium(
                            text: GetAppLocalizations(context).signIn,
                            onPressed: _formController.isButtonEnabled
                                ? _executeLogin
                                : null,
                            isFullWidth: true,
                            textColor: Colors.white,
                          )
                              .animate()
                              .fadeIn(duration: 600.ms, delay: 1500.ms)
                              .move(),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 24.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                GetAppLocalizations(context).dontHaveAnAccount + '? ',
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextButton(
                onPressed: () => context.pushTo(signUpRoute),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  GetAppLocalizations(context).signUp,
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    color: AppColors.accent_light,
                    baseStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 2100.ms).move(),
      ],
    );
  }

  // Setup body widget for main page
  _body() {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(children: [_widgetDesc(), _widgetForm()]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _formController.dispose();
    _rememberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _body(),
    );
  }
}
