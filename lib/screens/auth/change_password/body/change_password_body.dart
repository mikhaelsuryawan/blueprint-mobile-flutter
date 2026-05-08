import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/language/app_localizations.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../config/themes/notifiers/theme_manager.dart';
import '../../../../core/change_password/bloc/change_password_bloc.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/responsive_configuration.dart';
import '../../../../widgets/buttons/edge_button_medium.dart';
import '../../../../widgets/default_appbar.dart';
import '../../../../widgets/loadings/loading.dart';
import '../../../../widgets/textfield/textfield_password.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({Key? key}) : super(key: key);

  @override
  _ChangePasswordBodyState createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  late final ChangePasswordController _controller;
  late final ChangePasswordBloc _changePasswordBloc;
  bool _l10nForValidationApplied = false;

  @override
  void initState() {
    super.initState();

    _changePasswordBloc = context.read<ChangePasswordBloc>();

    _controller = ChangePasswordController(
      changePasswordBloc: _changePasswordBloc,
      context: context,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_l10nForValidationApplied) {
      _l10nForValidationApplied = true;
      final l10n = GetAppLocalizations(context);
      _controller.setValidationMessages(
        oldPasswordRequired: l10n.errorOldPasswordRequired,
        passwordMinLength: l10n.errorPasswordMinLength,
        newPasswordRequired: l10n.errorNewPasswordRequired,
        confirmPasswordRequired: l10n.errorConfirmPasswordRequired,
        passwordMismatch: l10n.passwordDoesntMatch,
        newPasswordSameAsOld: l10n.errorNewPasswordSameAsOld,
      );
    }
  }

  void _executeSave() {
    if (_controller.validateAll()) {
      _controller.executeChangePassword();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _widgetForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: pxToSp(context, 18),
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            GetAppLocalizations(context).oldPassword,
            textAlign: TextAlign.left,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        SizedBox(height: pxToSp(context, 12)),
        Container(
          margin: EdgeInsets.only(
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
          ),
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              final invalid = _controller.hasOldBeenTouched &&
                  !_controller.isOldPasswordValid;
              return TextfieldPassword(
                key: const Key('change_password_old'),
                controller: _controller.oldPasswordController,
                textColor: Theme.of(context).textTheme.displayMedium!.color!,
                enabledBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                focusedBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                hintText: GetAppLocalizations(context).inputYourOldPassword,
                obscureText: !_controller.isShowOldPassword,
                suffixIcon: IconButton(
                  onPressed: _controller.toggleOldPasswordVisibility,
                  icon: Icon(
                    _controller.isShowOldPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: Theme.of(context).iconTheme.color!,
                ),
                showError: invalid && _controller.oldPasswordError != null,
                errorMessage: _controller.oldPasswordError,
                onChanged: (_) => _controller.markOldPasswordAsTouched(),
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
            GetAppLocalizations(context).newPassword,
            textAlign: TextAlign.left,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        SizedBox(height: pxToSp(context, 12)),
        Container(
          margin: EdgeInsets.only(
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
          ),
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              final invalid = _controller.hasNewBeenTouched &&
                  !_controller.isNewPasswordValid;
              return TextfieldPassword(
                key: const Key('change_password_new'),
                controller: _controller.passwordController,
                textColor: Theme.of(context).textTheme.displayMedium!.color!,
                enabledBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                focusedBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                hintText: GetAppLocalizations(context).inputYourNewPassword,
                obscureText: !_controller.isShowPassword,
                suffixIcon: IconButton(
                  onPressed: _controller.togglePasswordVisibility,
                  icon: Icon(
                    _controller.isShowPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: Theme.of(context).iconTheme.color!,
                ),
                showError: invalid && _controller.newPasswordError != null,
                errorMessage: _controller.newPasswordError,
                onChanged: (_) => _controller.markNewPasswordAsTouched(),
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
            GetAppLocalizations(context).confirmPassword,
            textAlign: TextAlign.left,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        SizedBox(height: pxToSp(context, 12)),
        Container(
          margin: EdgeInsets.only(
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
          ),
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              final invalid = _controller.hasConfirmBeenTouched &&
                  !_controller.isConfirmPasswordValid;
              return TextfieldPassword(
                key: const Key('change_password_confirm'),
                controller: _controller.confPasswordController,
                textColor: Theme.of(context).textTheme.displayMedium!.color!,
                enabledBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                focusedBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.text,
                hintText: GetAppLocalizations(context).inputYourConfirmPassword,
                obscureText: !_controller.isShowConfPassword,
                suffixIcon: IconButton(
                  onPressed: _controller.toggleConfPasswordVisibility,
                  icon: Icon(
                    _controller.isShowConfPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: Theme.of(context).iconTheme.color!,
                ),
                showError: invalid && _controller.confirmPasswordError != null,
                errorMessage: _controller.confirmPasswordError,
                onChanged: (_) => _controller.markConfirmPasswordAsTouched(),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 18)),
          child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
            listenWhen: (previous, current) =>
                current is ChangePasswordLoaded ||
                current is ChangePasswordError,
            listener: (context, state) {
              if (state is ChangePasswordLoaded) {
                Helpers.onWidgetDidBuild(() {
                  if (!mounted) return;
                  _controller.handleSuccessfulChange();
                });
                _changePasswordBloc.add(ChangePasswordIdleEvent());
              } else if (state is ChangePasswordError) {
                Helpers.onWidgetDidBuild(() {
                  if (!mounted) return;
                  Helpers.showToast(context, state.textError);
                });
                _changePasswordBloc.add(ChangePasswordIdleEvent());
              }
            },
            child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
              bloc: _changePasswordBloc,
              buildWhen: (previous, current) =>
                  current is ChangePasswordInitState ||
                  current is ChangePasswordIdleState ||
                  current is ChangePasswordLoading ||
                  current is ChangePasswordLoaded ||
                  current is ChangePasswordError,
              builder: (context, state) {
                final bool isSubmitting = state is ChangePasswordLoading ||
                    state is ChangePasswordLoaded;

                return ListenableBuilder(
                  listenable: _controller,
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
                            text: GetAppLocalizations(context).save,
                            onPressed: _controller.isButtonEnabled
                                ? _executeSave
                                : null,
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
      ],
    );
  }

  _body() {
    return SingleChildScrollView(
      child: _widgetForm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: DefaultAppBar(
        context: context,
        textTitle: GetAppLocalizations(context).changePassword,
        showBackButton: true,
      ),
      body: _body(),
    );
  }
}
