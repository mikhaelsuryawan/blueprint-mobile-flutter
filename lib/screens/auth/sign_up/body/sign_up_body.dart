import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/language/app_localizations.dart';
import '../../../../config/routes/go_route_generator.dart';
import '../../../../constants/app_constants.dart';
import '../../../../core/sign_up/bloc/sign_up_bloc.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../config/themes/notifiers/theme_manager.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/responsive_configuration.dart';
import '../../../../widgets/buttons/edge_button_medium.dart';
import '../../../../widgets/default_appbar.dart';
import '../../../../widgets/loadings/loading.dart';
import '../../../../widgets/textfield/textfield_default.dart';
import '../../../../widgets/textfield/textfield_password.dart';
import '../controller/button_sign_up_controller.dart';
import '../controller/form_sign_up_controller.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  late final FormSignUpController _formController;
  late final ButtonSignUpController _buttonController;
  late final SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    _signUpBloc = context.read<SignUpBloc>();
    _formController = FormSignUpController();
    _buttonController = ButtonSignUpController(
      signUpBloc: _signUpBloc,
      context: context,
    );
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  Widget _buildLabel(String text) {
    return Container(
      margin: EdgeInsets.only(top: 16.sp, left: 16.sp, right: 16.sp),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: AppThemeNotifier.getTextStyleFromTheme(
          baseStyle: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildFieldPadding(Widget child) {
    return Container(
      margin: EdgeInsets.only(left: 16.sp, right: 16.sp),
      child: child,
    );
  }

  Widget _widgetForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(GetAppLocalizations(context).name),
        SizedBox(height: 12.sp),
        _buildFieldPadding(
          ListenableBuilder(
            listenable: _formController,
            builder: (context, _) {
              final form = _formController;
              final invalid = form.nameFieldInvalid;
              return TextfieldDefault(
                controller: form.nameController,
                textColor: Theme.of(context).textTheme.displayMedium!.color!,
                enabledBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                focusedBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                hintText: GetAppLocalizations(context).inputYourName,
                showError: invalid,
                errorMessage: AppConstant.errorMessageName,
                onChanged: (_) => form.markNameAsTouched(),
              );
            },
          ),
        ),
        _buildLabel(GetAppLocalizations(context).birthDate),
        SizedBox(height: 12.sp),
        _buildFieldPadding(
          ListenableBuilder(
            listenable: _formController,
            builder: (context, _) {
              final form = _formController;
              final invalid = form.birthDateFieldInvalid;
              return GestureDetector(
                onTap: () => form.pickBirthDate(context),
                child: AbsorbPointer(
                  child: TextfieldDefault(
                    controller: form.birthDateController,
                    textColor:
                        Theme.of(context).textTheme.displayMedium!.color!,
                    enabledBorderColor: invalid
                        ? AppColors.error_primary_400
                        : AppColors.accent_light,
                    focusedBorderColor: invalid
                        ? AppColors.error_primary_400
                        : AppColors.accent_light,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.none,
                    hintText: GetAppLocalizations(context).selectDateFirst,
                    showError: invalid,
                    errorMessage: AppConstant.errorMessageBirthDate,
                    onChanged: (_) {},
                  ),
                ),
              );
            },
          ),
        ),
        _buildLabel(GetAppLocalizations(context).gender),
        SizedBox(height: 12.sp),
        ListenableBuilder(
          listenable: _formController,
          builder: (context, _) {
            final form = _formController;
            final showGenderError = form.genderFieldInvalid;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkResponse(
                        onTap: () => form.setGender(context, 1),
                        child: Row(
                          children: [
                            Radio<int>(
                              value: 1,
                              groupValue: form.genderId,
                              activeColor: AppColors.accent_light,
                              onChanged: (val) => form.setGender(context, 1),
                            ),
                            Text(
                              GetAppLocalizations(context).female,
                              style: AppThemeNotifier.getTextStyleFromTheme(
                                baseStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      InkResponse(
                        onTap: () => form.setGender(context, 2),
                        child: Row(
                          children: [
                            Radio<int>(
                              value: 2,
                              groupValue: form.genderId,
                              activeColor: AppColors.accent_light,
                              onChanged: (val) => form.setGender(context, 2),
                            ),
                            Text(
                              GetAppLocalizations(context).male,
                              style: AppThemeNotifier.getTextStyleFromTheme(
                                baseStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (showGenderError)
                  Padding(
                    padding: EdgeInsets.only(left: 16.sp, top: 4.sp),
                    child: Text(
                      AppConstant.errorMessageGender,
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
        _buildLabel(GetAppLocalizations(context).email),
        SizedBox(height: 12.sp),
        _buildFieldPadding(
          ListenableBuilder(
            listenable: _formController,
            builder: (context, _) {
              final form = _formController;
              final emailInvalid = form.emailFieldInvalid;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextfieldDefault(
                    controller: form.emailController,
                    textColor:
                        Theme.of(context).textTheme.displayMedium!.color!,
                    enabledBorderColor: emailInvalid
                        ? AppColors.error_primary_400
                        : AppColors.accent_light,
                    focusedBorderColor: emailInvalid
                        ? AppColors.error_primary_400
                        : AppColors.accent_light,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    hintText:
                        GetAppLocalizations(context).inputYourEmailAddress,
                    onChanged: (_) => form.markEmailAsTouched(),
                  ),
                  if (form.hasEmailBeenTouched &&
                      form.emailErrorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(top: 8.sp, left: 4.sp),
                      child: Text(
                        form.emailErrorMessage!,
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
        _buildLabel(GetAppLocalizations(context).phoneNumber),
        SizedBox(height: 12.sp),
        _buildFieldPadding(
          ListenableBuilder(
            listenable: _formController,
            builder: (context, _) {
              final form = _formController;
              final invalid = form.phoneFieldInvalid;
              return TextfieldDefault(
                controller: form.phoneController,
                textColor: Theme.of(context).textTheme.displayMedium!.color!,
                enabledBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                focusedBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone,
                hintText: GetAppLocalizations(context).inputYourPhoneNumber,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(14),
                ],
                showError: invalid,
                errorMessage: AppConstant.errorMessagePhone,
                onChanged: (_) => form.markPhoneAsTouched(),
              );
            },
          ),
        ),
        _buildLabel(GetAppLocalizations(context).password),
        SizedBox(height: 12.sp),
        _buildFieldPadding(
          ListenableBuilder(
            listenable: _formController,
            builder: (context, _) {
              final form = _formController;
              final invalid = form.passwordFieldInvalid;
              return TextfieldPassword(
                controller: form.passwordController,
                textColor: Theme.of(context).textTheme.displayMedium!.color!,
                enabledBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                focusedBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.visiblePassword,
                hintText: GetAppLocalizations(context).inputYourPassword,
                obscureText: !form.isShowPassword,
                suffixIcon: IconButton(
                  onPressed: form.togglePasswordVisibility,
                  icon: Icon(
                    form.isShowPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: Theme.of(context).iconTheme.color!,
                ),
                showError: invalid,
                errorMessage: AppConstant.errorMessagePassword,
                onChanged: (_) => form.markPasswordAsTouched(),
              );
            },
          ),
        ),
        _buildLabel(GetAppLocalizations(context).confirmPassword),
        SizedBox(height: 12.sp),
        _buildFieldPadding(
          ListenableBuilder(
            listenable: _formController,
            builder: (context, _) {
              final form = _formController;
              final invalid = form.confirmPasswordFieldInvalid;
              final confirmText = form.confirmPasswordController.text;
              return TextfieldPassword(
                controller: form.confirmPasswordController,
                textColor: Theme.of(context).textTheme.displayMedium!.color!,
                enabledBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                focusedBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.visiblePassword,
                hintText: GetAppLocalizations(context).inputYourConfirmPassword,
                obscureText: !form.isShowConfirmPassword,
                suffixIcon: IconButton(
                  onPressed: form.toggleConfirmPasswordVisibility,
                  icon: Icon(
                    form.isShowConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: Theme.of(context).iconTheme.color!,
                ),
                showError: invalid,
                errorMessage: confirmText.isEmpty
                    ? null
                    : GetAppLocalizations(context).passwordDoesntMatch,
                onChanged: (_) => form.markConfirmPasswordAsTouched(),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(20.sp),
          child: BlocListener<SignUpBloc, SignUpState>(
            listenWhen: (previous, current) =>
                current is SignUpLoaded || current is SignUpError,
            listener: (context, state) {
              if (state is SignUpLoaded) {
                Helpers.onWidgetDidBuild(() {
                  if (!mounted) return;
                  _buttonController.navigationAfterSignUp();
                });
                _signUpBloc.add(const SignUpIdleEvent());
              } else if (state is SignUpError) {
                Helpers.onWidgetDidBuild(() {
                  if (!mounted) return;
                  Helpers.showToast(context, state.textError ?? 'Error');
                });
                _signUpBloc.add(const SignUpIdleEvent());
              }
            },
            child: BlocBuilder<SignUpBloc, SignUpState>(
              bloc: _signUpBloc,
              buildWhen: (previous, current) =>
                  current is SignUpInitState ||
                  current is SignUpIdleState ||
                  current is SignUpLoading ||
                  current is SignUpLoaded ||
                  current is SignUpError,
              builder: (context, state) {
                final bool isSubmitting =
                    state is SignUpLoading || state is SignUpLoaded;

                return ListenableBuilder(
                  listenable: _formController,
                  builder: (context, _) {
                    final form = _formController;
                    return Column(
                      children: [
                        Loading(
                          isShow: isSubmitting,
                          color: AppColors.accent_light,
                        ),
                        Visibility(
                          visible: !isSubmitting,
                          child: EdgeButtonMedium(
                            text: GetAppLocalizations(context).signUp,
                            onPressed: !form.isButtonEnabled
                                ? null
                                : () => _buttonController.executeSignUp(form),
                            isFullWidth: true,
                            buttonColor: AppColors.accent_light,
                            textColor: Colors.white,
                          ),
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
                GetAppLocalizations(context).alreadyHaveAnAccount + '? ',
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextButton(
                onPressed: () => context.popRoute(),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  GetAppLocalizations(context).signIn,
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: DefaultAppBar(
        context: context,
        textTitle: GetAppLocalizations(context).makeYourAccount,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: _widgetForm(),
      ),
    );
  }
}
