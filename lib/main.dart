import 'dart:async';

import 'package:blueprint_mobile_flutter/firebase_options.dart';
import 'package:blueprint_mobile_flutter/l10n/app_localizations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_settings.dart';
import 'config/language/language_manager.dart';
import 'config/routes/go_route_generator.dart';
import 'config/themes/app_colors.dart';
import 'config/themes/notifiers/theme_manager.dart';
import 'utils/services/notification/notification_service.dart';
import 'utils/services/storage/local_storage_service.dart';
import 'widgets/dialog/dialog_connection_internet.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get Firebase
  await Firebase.initializeApp(
    name: "WITAttendance",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Initialize notification service
  await NotificationService().initialize();

  /// Get Application Environment
  await dotenv.load();

  /// Set Application Flavor
  AppSettings.flavor =
      kReleaseMode ? AppFlavor.production : AppFlavor.development;

  //Set Default Traffic Type For Google Analytics
  final trafficType = {Settings.trafficType: AppSettings.trafficType};
  FirebaseAnalytics.instance.setDefaultEventParameters(trafficType);

  //Set Default Crashlytics
  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  /// Enter App
  enterApp();
}

void enterApp() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppThemeNotifier>(
          create: (_) => new AppThemeNotifier()),
      ChangeNotifierProvider<AppLanguageNotifier>(
          create: (_) => new AppLanguageNotifier()),
    ],
    child: DevicePreview(
      enabled: false,
      // enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // PERFORMANCE FIX: Proper stream subscription management to prevent memory leaks
  late StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  // MATERIALLOCALIZATIONS FIX: Timer to safely delay connectivity initialization
  Timer? _initializationTimer;

  @override
  void initState() {
    super.initState();
    // Log Open App
    FirebaseAnalytics.instance.logAppOpen();

    // MATERIALLOCALIZATIONS FIX: Delay connectivity listener initialization
    // This ensures MaterialApp is fully built before any dialog attempts
    _initializationTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        _initializeConnectivityListener();
      }
    });
  }

  @override
  void dispose() {
    // MEMORY LEAK FIX: Cancel stream subscription and timer to prevent memory leaks
    _connectivitySubscription?.cancel();
    _initializationTimer?.cancel();
    super.dispose();
  }

  // PERFORMANCE FIX: Separate method for connectivity initialization
  void _initializeConnectivityListener() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      // SAFETY CHECK: Only proceed if widget is still mounted and context is available
      if (!mounted || !context.mounted) return;

      // ADDITIONAL SAFETY: Add delay to ensure MaterialApp is fully initialized
      await Future.delayed(const Duration(seconds: 2));

      // Double check after delay
      if (!mounted || !context.mounted) return;

      bool isDeviceConnected = await InternetConnection().hasInternetAccess;
      bool isDialogShow = await LocalStorageService.getDialogConnection();

      if (!isDeviceConnected && !isDialogShow) {
        if (!(await LocalStorageService.getValidationNetwork())) {
          return;
        }

        LocalStorageService.saveData('dialogConnection', true);

        // TRIPLE CHECK: Ensure widget is still mounted and delay a bit more
        await Future.delayed(const Duration(milliseconds: 500));

        if (mounted && context.mounted) {
          try {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext bc) {
                return DialogConnectionInternet(
                  onSubmitYes: () async {
                    context.popRoute('Cancel');
                    isDeviceConnected =
                        await InternetConnection().hasInternetAccess;
                  },
                );
              },
            ).then((value) =>
                LocalStorageService.saveData('dialogConnection', false));
          } catch (e) {
            // FALLBACK: If MaterialLocalizations not ready, reset dialog flag and try later
            print('Error showing connectivity dialog: $e');
            LocalStorageService.saveData('dialogConnection', false);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Consumer2<AppThemeNotifier, AppLanguageNotifier>(
        builder: (context, theme, locale, _) {
          final ThemeData t = theme.getTheme(context);
          final bool isDark = t.brightness == Brightness.dark;

          if (locale.getLanguage().languageCode == 'en') {
            LocalStorageService.saveData('language', 'en');
          } else {
            LocalStorageService.saveData('language', 'id');
          }

          return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: MaterialApp.router(
                routerConfig: appRouter,
                debugShowCheckedModeBanner: kDebugMode,
                title: AppSettings.appName,
                theme: t,
                darkTheme: t,
                locale: locale.getLanguage(),
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('id', ''),
                ],

                // 🔒 Apply system bar styling here so it sticks
                builder: (context, child) {
                  // ✅ Draw system bars (NOT edge-to-edge) so nav bar uses our color
                  SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.manual,
                    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
                  );

                  // Use AppBar colors instead of surface color
                  final appBarColor =
                      isDark ? AppColors.app_bar_dark : AppColors.app_bar_light;
                  final surface = Theme.of(context).colorScheme.surface;

                  print('🌓 Theme Mode: ${isDark ? "DARK" : "LIGHT"}');
                  print('🎨 AppBar Color: $appBarColor');

                  final overlay = SystemUiOverlayStyle(
                    // STATUS BAR
                    statusBarColor: appBarColor, // Use AppBar color
                    statusBarIconBrightness:
                        isDark ? Brightness.light : Brightness.dark, // Android
                    statusBarBrightness:
                        isDark ? Brightness.dark : Brightness.light, // iOS

                    // NAVIGATION BAR (Android)
                    systemNavigationBarColor: appBarColor, // Use AppBar color
                    systemNavigationBarIconBrightness:
                        isDark ? Brightness.light : Brightness.dark,
                    systemNavigationBarDividerColor: appBarColor,
                    systemNavigationBarContrastEnforced:
                        false, // avoid forced dark scrim
                  );

                  SystemChrome.setSystemUIOverlayStyle(overlay);

                  // Ensure app surfaces match (no black peeking through)
                  final themed = t.copyWith(
                    scaffoldBackgroundColor: surface,
                    appBarTheme: t.appBarTheme.copyWith(
                      systemOverlayStyle: overlay,
                    ),
                  );

                  return Theme(
                    data: themed,
                    child: Scaffold(
                      backgroundColor: surface,
                      body: child ?? const SizedBox.shrink(),
                    ),
                  );
                },
              ));
        },
      );
    });
  }
}
