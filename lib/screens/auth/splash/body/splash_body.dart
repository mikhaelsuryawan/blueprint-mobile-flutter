import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/routes/go_route_generator.dart';
import '../../../../config/routes/routes.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/assets_path.dart';
import '../../../../core/models/arguments/arguments_main.dart';
import '../../../../core/refresh_token/bloc/refresh_token_bloc.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/services/remote_config/remote_config_service.dart';
import '../../../../utils/services/storage/local_storage_service.dart';
import '../../../../widgets/dialog/dialog_remote_config.dart';
import '../controller/refresh_token_controller.dart';
import '../controller/remote_config_controller.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  /// Controllers
  late final RefreshTokenController _refreshTokenController;
  late final RemoteConfigController _remoteConfigController;
  late final RefreshTokenBloc _refreshTokenBloc;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _refreshTokenBloc = context.read<RefreshTokenBloc>();
    _refreshTokenController = RefreshTokenController(
      refreshTokenBloc: _refreshTokenBloc,
    );
    _remoteConfigController = RemoteConfigController();

    // Save network validation flag
    LocalStorageService.saveData(AppConstant.validateNetwork, true);

    // Setup animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _setAnimation();

    // Initialize controllers and start flow
    _initializeControllers();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _refreshTokenController.dispose();
    _remoteConfigController.dispose();
    super.dispose();
  }

  /// Initialize controllers and start the flow
  Future<void> _initializeControllers() async {
    // Initialize refresh token controller (loads FCM and device ID)
    await _refreshTokenController.initialize();

    // Check for app updates
    await _checkVersionAndUpdate();
  }

  /// Set up animation
  void _setAnimation() {
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);

    _animation.addListener(() => setState(() {}));
    _animationController.forward();
  }

  _startTime(bool _isLogin) async {
    _navigationPage(_isLogin);
  }

  Future<void> _navigationPage(bool _isLogin) async {
    // Listen for animation completion
    if (_isLogin) {
      // String role = await SecureStorageService.getUserRole();

      ArgumentsMain argumentsMain =
          ArgumentsMain(isLogin: "true", currentIndex: 0);

      // Use GoRouter to navigate and clear navigation stack
      context.goTo(mainRoute, extra: argumentsMain);
    } else {
      // Use GoRouter to navigate and clear navigation stack
      context.goTo(onBoardingRoute);
    }
  }

  /// Check version and update using remote config controller
  Future<void> _checkVersionAndUpdate() async {
    try {
      // Complete remote config flow (initialize, fetch, check update)
      final updateResult =
          await _remoteConfigController.completeRemoteConfigFlow();

      // Get package info and update details
      final packageInfo = _remoteConfigController.packageInfo;
      final updateMessage =
          _remoteConfigController.updateMessage ?? 'Update aplikasimu';
      final iOSAppId = _remoteConfigController.iOSAppId ?? '';
      final packageName = _remoteConfigController.packageName ?? '';

      if (packageInfo != null) {
        debugPrint('📦 Package: $packageName');
        debugPrint(
            '📱 Version: ${packageInfo.version} (${packageInfo.buildNumber})');
      }

      // Handle update result
      switch (updateResult) {
        case UpdateCheckResult.forceUpdate:
          await showDialogRemoteConfig(
            context: context,
            isForceUpdate: true,
            updateMessage: updateMessage,
            iOSAppId: iOSAppId,
            packageName: packageName,
            onLater: null, // Not available for force update
            onUpdate: () {
              // Update button pressed - app will redirect to store
            },
          );
          break;
        case UpdateCheckResult.recommendUpdate:
          final result = await showDialogRemoteConfig(
            context: context,
            isForceUpdate: false,
            updateMessage: updateMessage,
            iOSAppId: iOSAppId,
            packageName: packageName,
            onLater: () {
              // User tapped "Later" - continue with app
              _executeRefreshToken();
            },
            onUpdate: () {
              // Update button pressed - app will redirect to store
            },
          );
          // If user tapped "Later", result will be true and onLater is called
          // If dialog was closed, continue with app flow
          if (result == true) {
            _executeRefreshToken();
          }
          break;
        case UpdateCheckResult.noUpdate:
          _executeRefreshToken();
          break;
      }
    } catch (e) {
      debugPrint('❌ Error checking version and update: $e');
      // Continue with app flow even if remote config fails
      _executeRefreshToken();
    }
  }

  /// Execute refresh token flow using controller
  Future<void> _executeRefreshToken() async {
    await _refreshTokenController.executeRefreshToken();
  }

  _body() {
    final splashHeight = Helpers.isSmallScreen(context) ? 50.w : 50.h;

    return BlocListener<RefreshTokenBloc, RefreshTokenState>(
      bloc: _refreshTokenBloc,
      listenWhen: (previous, current) =>
          current is RefreshTokenLoaded || current is RefreshTokenError,
      listener: (context, state) {
        if (state is RefreshTokenLoaded) {
          Helpers.onWidgetDidBuild(() {
            if (!mounted) return;
            setState(() {
              if (state.response.response == null) {
                _startTime(false);
              } else {
                _startTime(state.response.response!.data!.isLogin!);
              }
            });
          });
          _refreshTokenBloc.add(RefreshTokenIdleEvent());
        } else if (state is RefreshTokenError) {
          Helpers.onWidgetDidBuild(() {
            if (!mounted) return;
            setState(() {
              _startTime(false);
            });
          });
          _refreshTokenBloc.add(RefreshTokenIdleEvent());
        }
      },
      child: Center(
        child: SizedBox(
          width: splashHeight,
          height: splashHeight,
          child: Lottie.asset(
            Assets.flutterLottie,
            controller: _animationController,
            fit: BoxFit.contain, // keep aspect ratio
            onLoaded: (composition) {
              _animationController
                ..duration = composition.duration
                ..forward();
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _body(),
    );
  }
}
