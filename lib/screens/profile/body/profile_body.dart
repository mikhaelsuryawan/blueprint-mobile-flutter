import 'package:blueprint_mobile_flutter/config/routes/go_route_generator.dart';
import 'package:blueprint_mobile_flutter/config/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/language/app_localizations.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/notifiers/theme_manager.dart';
import '../../../constants/assets_path.dart';
import '../../../core/logout/bloc/logout_bloc.dart';
import '../../../core/profile/bloc/profile_bloc.dart';
import '../../../utils/helpers.dart';
import '../../../utils/responsive_configuration.dart';
import '../../../widgets/buttons/edge_border_button_medium.dart';
import '../../../widgets/default_appbar.dart';
import '../../../widgets/dialog/dialog_confirmation.dart';
import '../../../widgets/images/image_preview.dart';
import '../../../widgets/images/image_profile_extended.dart';
import '../../../widgets/loadings/loading.dart';
import '../../../widgets/menu/menu_chevron.dart';
import '../../../widgets/pull_to_refresh/app_smart_refresher_parts.dart';
import '../controller/logout_controller.dart';
import '../controller/profile_controller.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  /// Controllers
  late final ProfileController _profileController;
  late final LogoutController _logoutController;
  late final ProfileBloc _profileBloc;
  late final LogoutBloc _logoutBloc;

  @override
  void initState() {
    super.initState();

    // Initialize blocs
    _profileBloc = context.read<ProfileBloc>();
    _logoutBloc = context.read<LogoutBloc>();

    // Initialize controllers
    _profileController = ProfileController(
      profileBloc: _profileBloc,
    );
    _logoutController = LogoutController(
      logoutBloc: _logoutBloc,
      context: context,
    );
  }

  @override
  void dispose() {
    _profileController.dispose();
    super.dispose();
  }

  _widgetHeader() {
    const heroTag = 'profileImageHero';
    return ListenableBuilder(
      listenable: _profileController,
      builder: (context, _) {
        // Show loading shimmer while loading
        if (_profileController.isLoading &&
            !_profileController.hasProfileData) {
          final avatar = pxToSp(context, 72);
          final badge = pxToSp(context, 30);
          return Container(
            margin: EdgeInsets.all(pxToSp(context, 18)),
            padding: EdgeInsets.all(pxToSp(context, 18)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(pxToSp(context, 12)),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.white.withValues(alpha: 0.28),
              highlightColor: Colors.white.withValues(alpha: 0.62),
              period: const Duration(milliseconds: 1200),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: avatar,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: avatar,
                        height: avatar,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: badge,
                                height: badge,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: pxToSp(context, 18)),
                    child: Center(
                      child: Container(
                        height: pxToSp(context, 22),
                        width: MediaQuery.of(context).size.width * 0.68,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(pxToSp(context, 8)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: pxToSp(context, 5)),
                    child: Center(
                      child: Container(
                        height: pxToSp(context, 16),
                        width: MediaQuery.of(context).size.width * 0.48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(pxToSp(context, 8)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final imageUrl =
            _profileController.profileData?.urlProfilePicture ?? "";
        final displayName = _profileController.profileData?.fullname ?? "";
        final jobTitle = _profileController.profileData?.job?.name ?? "";

        return Container(
          margin: EdgeInsets.all(pxToSp(context, 18)),
          padding: EdgeInsets.all(pxToSp(context, 18)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            borderRadius: BorderRadius.circular(pxToSp(context, 12)),
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: pxToSp(context, 72),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          children: [
                            Container(
                              width: pxToSp(context, 72),
                              height: pxToSp(context, 72),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      opaque: false,
                                      barrierColor:
                                          Colors.black.withValues(alpha: 0.85),
                                      pageBuilder: (_, __, ___) => ImagePreview(
                                          imageUrl: imageUrl, heroTag: heroTag),
                                    ),
                                  );
                                },
                                child: ImageProfileExtended(
                                  imageUrl: imageUrl,
                                  height: pxToSp(context, 72),
                                  width: pxToSp(context, 72),
                                  useShimmer: true,
                                  fit: BoxFit.cover,
                                  borderRadius: pxToSp(context, 72),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    // _uploadImageModalBottomSheet(
                                    //     context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(pxToSp(context, 0)),
                                    width: pxToSp(context, 30),
                                    height: pxToSp(context, 30),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: AppColors.accent_light,
                                      size: pxToSp(context, 22),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 600.ms).scaleXY(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: pxToSp(context, 18)),
                child: Text(
                  displayName,
                  textAlign: TextAlign.center,
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    baseStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                ).animate().fadeIn(duration: 600.ms).move(),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: pxToSp(context, 5)),
                child: Text(
                  jobTitle,
                  textAlign: TextAlign.center,
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    baseStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 600.ms).move(),
              ),
            ],
          ),
        );
      },
    );
  }

  _widgetMenu() {
    return Column(
      children: [
        MenuChevron(
          asset: Assets.setting,
          text: GetAppLocalizations(context).settings,
          onPressed: () async {
            await context.pushTo(themeRoute);
          },
        ).animate().fadeIn(duration: 600.ms).move(),
        MenuChevron(
          asset: Assets.editProfile,
          text: GetAppLocalizations(context).editProfile,
          onPressed: () async {
            await context.pushTo(updateProfileRoute);
          },
        ).animate().fadeIn(duration: 600.ms, delay: 600.ms).move(),
        MenuChevron(
          asset: Assets.password,
          text: GetAppLocalizations(context).changePassword,
          onPressed: () async {
            await context.pushTo(changePasswordRoute);
          },
        ).animate().fadeIn(duration: 600.ms, delay: 1200.ms).move(),
      ],
    );
  }

  _widgetButtonLogout() {
    return Container(
      alignment: Alignment.center,
      child: BlocListener<LogoutBloc, LogoutState>(
        listenWhen: (previous, current) =>
            current is LogoutLoaded || current is LogoutError,
        listener: (context, state) {
          if (state is LogoutLoaded) {
            Helpers.onWidgetDidBuild(() {
              if (!mounted) return;
              _logoutController.handleSuccessfulLogout();
            });
            _logoutBloc.add(LogoutIdleEvent());
          } else if (state is LogoutError) {
            Helpers.onWidgetDidBuild(() {
              if (!mounted) return;
              _logoutController.handleLogoutError(state.textError, context);
            });
          }
        },
        child: BlocBuilder<LogoutBloc, LogoutState>(
          bloc: _logoutBloc,
          buildWhen: (previous, current) =>
              current is LogoutInitState ||
              current is LogoutIdleState ||
              current is LogoutLoading ||
              current is LogoutLoaded ||
              current is LogoutError,
          builder: (context, state) {
            final bool _isLoading =
                state is LogoutLoading || state is LogoutLoaded;

            return Column(
              children: [
                Loading(
                  isShow: _isLoading,
                  color: AppColors.accent_light,
                ),
                Visibility(
                  visible: !_isLoading,
                  child: Container(
                    padding: EdgeInsets.all(pxToSp(context, 18)),
                    child: EdgeBorderButtonMedium(
                      text: GetAppLocalizations(context).logout,
                      isFullWidth: true,
                      borderColor: AppColors.accent_light,
                      textColor: AppColors.accent_light,
                      buttonColor: Theme.of(context).colorScheme.surface,
                      onPressed: () {
                        final loc = GetAppLocalizations(context);
                        showDialogConfirmation(
                          context: context,
                          title: loc.logoutConfirmationTitle,
                          desc: loc.logoutConfirmationMessage,
                          onSubmitYes: _logoutController.executeLogout,
                        );
                      },
                    ).animate().fadeIn(duration: 600.ms).scaleXY(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _body() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: () => _profileController.refreshProfile(),
      onLoading: () => _profileController.loadMore(),
      controller: _profileController.refreshController,
      header: AppSmartRefresherParts.waterDropHeader(context),
      footer: AppSmartRefresherParts.customFooter(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _widgetHeader(),
            _widgetMenu(),
            _widgetButtonLogout(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) =>
            current is ProfileLoading ||
            current is ProfileLoaded ||
            current is ProfileError,
        listener: (context, state) {
          if (state is ProfileLoaded) {
            _profileController.handleProfileLoaded(state.response);
          } else if (state is ProfileError) {
            _profileController.handleProfileError(state.textError);
            if (!mounted) return;
            Helpers.onWidgetDidBuild(() {
              if (!mounted) return;
              Helpers.showToast(context, state.textError);
            });
          } else if (state is ProfileLoading) {
            _profileController.handleProfileLoading();
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: DefaultAppBar(
            context: context,
            textTitle: GetAppLocalizations(context).profile,
            showBackButton: false,
          ),
          body: _body(),
        ),
      ),
    );
  }
}
