import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../config/language/app_localizations.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/notifiers/theme_manager.dart';
import '../../../core/update_profile/bloc/update_profile_bloc.dart';
import '../../../utils/helpers.dart';
import '../../../utils/responsive_configuration.dart';
import '../../../widgets/buttons/edge_button_medium.dart';
import '../../../widgets/default_appbar.dart';
import '../../../widgets/loadings/loading.dart';
import '../../../widgets/textfield/textfield_default.dart';
import '../controller/update_profile_controller.dart';

class UpdateProfileBody extends StatefulWidget {
  const UpdateProfileBody({Key? key}) : super(key: key);

  @override
  _UpdateProfileBodyState createState() => _UpdateProfileBodyState();
}

class _UpdateProfileBodyState extends State<UpdateProfileBody> {
  late final UpdateProfileController _controller;
  late final UpdateProfileBloc _updateProfileBloc;
  bool _l10nForValidationApplied = false;

  @override
  void initState() {
    super.initState();

    _updateProfileBloc = context.read<UpdateProfileBloc>();

    _controller = UpdateProfileController(
      updateProfileBloc: _updateProfileBloc,
      context: context,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.loadProfile();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_l10nForValidationApplied) {
      _l10nForValidationApplied = true;
      final l10n = GetAppLocalizations(context);
      _controller.setValidationMessages(
        fieldRequired: l10n.fieldRequired,
        invalidPhone: l10n.pleaseEnterValidPhoneNumber,
        selectGender: l10n.pleaseSelectGender,
      );
    }
  }

  void _executeSave() {
    if (_controller.validateAll()) {
      _controller.executeUpdateProfile();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            GetAppLocalizations(context).name,
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
              final invalid = _controller.hasNameBeenTouched &&
                  !_controller.isNameValid;
              return TextfieldDefault(
                key: const Key('update_profile_name'),
                controller: _controller.nameController,
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
                showError: invalid && _controller.nameError != null,
                errorMessage: _controller.nameError,
                onChanged: (_) => _controller.markNameAsTouched(),
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
            GetAppLocalizations(context).phoneNumber,
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
              final invalid = _controller.hasPhoneBeenTouched &&
                  !_controller.isPhoneValid;
              return TextfieldDefault(
                key: const Key('update_profile_phone'),
                controller: _controller.phoneController,
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
                showError: invalid && _controller.phoneError != null,
                errorMessage: _controller.phoneError,
                onChanged: (_) => _controller.markPhoneAsTouched(),
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
            GetAppLocalizations(context).gender,
            textAlign: TextAlign.left,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: pxToSp(context, 10),
            right: pxToSp(context, 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListenableBuilder(
                listenable: _controller,
                builder: (context, _) {
                  return RadioGroup<int>(
                    groupValue: _controller.selectedGender,
                    onChanged: (int? val) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (val != null) _controller.setGender(val);
                    },
                    child: Row(
                      children: <Widget>[
                        InkResponse(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _controller.setGender(1);
                          },
                          child: Row(
                            children: [
                              Radio<int>(
                                value: 1,
                                activeColor: AppColors.accent_light,
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
                        SizedBox(
                          width: 10.w,
                        ),
                        InkResponse(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _controller.setGender(2);
                          },
                          child: Row(
                            children: [
                              Radio<int>(
                                value: 2,
                                activeColor: AppColors.accent_light,
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
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
        ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            if (!_controller.hasGenderBeenTouched ||
                _controller.genderError == null) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: EdgeInsets.only(
                left: pxToSp(context, 18),
                right: pxToSp(context, 18),
                top: pxToSp(context, 4),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _controller.genderError!,
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    baseStyle: Theme.of(context).textTheme.bodySmall,
                    color: AppColors.error_primary_400,
                  ),
                ),
              ),
            );
          },
        ),
        Container(
          margin: EdgeInsets.only(
            top: pxToSp(context, 18),
            left: pxToSp(context, 18),
            right: pxToSp(context, 18),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            GetAppLocalizations(context).address,
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
              final invalid = _controller.hasAddressBeenTouched &&
                  !_controller.isAddressValid;
              return TextfieldDefault(
                key: const Key('update_profile_address'),
                controller: _controller.addressController,
                textColor: Theme.of(context).textTheme.displayMedium!.color!,
                enabledBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                focusedBorderColor: invalid
                    ? AppColors.error_primary_400
                    : AppColors.accent_light,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.multiline,
                hintText: GetAppLocalizations(context).inputYourAddress,
                minLine: 5,
                maxLine: 10,
                showError: invalid && _controller.addressError != null,
                errorMessage: _controller.addressError,
                onChanged: (_) => _controller.markAddressAsTouched(),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(pxToSp(context, 18)),
          child: BlocListener<UpdateProfileBloc, UpdateProfileState>(
            listenWhen: (previous, current) =>
                current is UpdateProfileLoaded ||
                current is UpdateProfileError,
            listener: (context, state) {
              if (state is UpdateProfileLoaded) {
                Helpers.onWidgetDidBuild(() {
                  if (!mounted) return;
                  _controller.handleSuccessfulUpdate();
                });
                _updateProfileBloc.add(UpdateProfileIdleEvent());
              } else if (state is UpdateProfileError) {
                Helpers.onWidgetDidBuild(() {
                  if (!mounted) return;
                  Helpers.showToast(context, state.textError);
                });
                _updateProfileBloc.add(UpdateProfileIdleEvent());
              }
            },
            child: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
              bloc: _updateProfileBloc,
              buildWhen: (previous, current) =>
                  current is UpdateProfileInitState ||
                  current is UpdateProfileIdleState ||
                  current is UpdateProfileLoading ||
                  current is UpdateProfileLoaded ||
                  current is UpdateProfileError,
              builder: (context, state) {
                final bool isSubmitting = state is UpdateProfileLoading ||
                    state is UpdateProfileLoaded;

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
        textTitle: GetAppLocalizations(context).editProfile,
        showBackButton: true,
      ),
      body: _body(),
    );
  }
}
