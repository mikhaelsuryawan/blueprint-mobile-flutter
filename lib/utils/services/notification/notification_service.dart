import 'dart:io';

import 'package:blueprint_mobile_flutter/config/routes/routes.dart';
import 'package:blueprint_mobile_flutter/config/themes/app_colors.dart';
import 'package:blueprint_mobile_flutter/core/models/arguments/arguments_main.dart';
import 'package:blueprint_mobile_flutter/core/models/notification/response/received_notification_response.dart';
import 'package:blueprint_mobile_flutter/firebase_options.dart';
import 'package:blueprint_mobile_flutter/utils/Helpers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import '../../../config/routes/go_route_generator.dart';

/// Notification Service
/// Handles all Firebase Cloud Messaging and local notifications
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // Local notifications plugin
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Firebase Messaging instance
  FirebaseMessaging? _messaging;

  // Notification channel for Android
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
    playSound: true,
  );

  // Subjects for notification handling
  final BehaviorSubject<ReceivedNotificationResponse>
      _didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotificationResponse>();
  final BehaviorSubject<String> _selectNotificationSubject =
      BehaviorSubject<String>();

  String _selectedNotificationPayload = '';

  /// Route to navigate when app finishes cold start (opened from terminated via notification tap).
  /// Consumed by Splash when it leaves to main/onboarding.
  String? _pendingInitialRoute;
  bool _initialNotificationHandled = false;

  // Getters
  FlutterLocalNotificationsPlugin get localNotifications => _localNotifications;
  BehaviorSubject<ReceivedNotificationResponse>
      get didReceiveLocalNotificationSubject =>
          _didReceiveLocalNotificationSubject;
  BehaviorSubject<String> get selectNotificationSubject =>
      _selectNotificationSubject;
  String get selectedNotificationPayload => _selectedNotificationPayload;

  /// Initialize notification service
  /// Must be called before using any notification features
  Future<void> initialize() async {
    try {
      // Initialize local notifications
      await _initializeLocalNotifications();

      // Initialize Firebase Messaging
      await _initializeFirebaseMessaging();

      Helpers.log("Notification Service", "Initialized successfully");
    } catch (e) {
      Helpers.log("Notification Service Error", "Failed to initialize: $e");
    }
  }

  /// Initialize local notifications plugin
  Future<void> _initializeLocalNotifications() async {
    // Get notification app launch details
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _localNotifications.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      _selectedNotificationPayload =
          notificationAppLaunchDetails?.notificationResponse?.payload ?? '';
      if (_selectedNotificationPayload.isNotEmpty &&
          !_initialNotificationHandled) {
        _initialNotificationHandled = true;
        await _handleNotificationClick(_selectedNotificationPayload, true);
      }
    }

    // Android initialization settings
    // Ikon notifikasi harus white-on-transparent (alpha-only); jangan pakai ic_launcher_background/ic_logo (background tidak transparan)
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("drawable/ic_notification");

    // iOS initialization settings
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Combine settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Initialize plugin
    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final payload = notificationResponse.payload ?? '';
        _selectedNotificationPayload = payload;
        _selectNotificationSubject.add(payload);

        Helpers.log("Notification Click", "Payload: $payload");

        await _handleNotificationClick(payload, false);
      },
    );

    // Create Android notification channel
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  /// Initialize Firebase Messaging
  Future<void> _initializeFirebaseMessaging() async {
    _messaging = FirebaseMessaging.instance;

    // Request notification permissions
    await _requestNotificationPermissions();

    // Set foreground notification presentation options for iOS
    // alert: false agar hanya tampil via _showLocalNotification (sama seperti Android),
    // sehingga tap notif mengarah ke onDidReceiveNotificationResponse dengan payload.
    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // Handle initial message (app opened from terminated state)
    _handleInitialMessage();

    // Handle foreground messages
    _handleForegroundMessages();

    // Handle background messages (app opened from background)
    _handleBackgroundMessages();

    // Handle token refresh
    _handleTokenRefresh();

    // Get and log initial FCM token
    _logFcmToken();
  }

  /// Request notification permissions
  Future<void> _requestNotificationPermissions() async {
    if (_messaging == null) return;

    try {
      NotificationSettings settings = await _messaging!.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        Helpers.log("Notification Permission", "User granted permission");
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        Helpers.log(
            "Notification Permission", "User granted provisional permission");
      } else {
        Helpers.log("Notification Permission",
            "User declined or has not accepted permission");
      }
    } catch (e) {
      Helpers.log(
          "Notification Permission Error", "Failed to request permission: $e");
    }
  }

  /// Handle initial message (app opened from terminated state)
  void _handleInitialMessage() {
    _messaging?.getInitialMessage().then((message) async {
      if (_initialNotificationHandled) return;
      if (message != null) {
        Helpers.log("Initial Message", "Notification Payload: ${message.data}");

        String payload = _extractPayload(message.data);
        if (payload.isNotEmpty) {
          _initialNotificationHandled = true;
          await _handleNotificationClick(payload, true);
        }
      }
    });
  }

  /// Handle foreground messages
  void _handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      Helpers.log(
          "Foreground Message", "Notification Payload: ${message.data}");

      String payload = _extractPayload(message.data);
      final String dataTitle = message.data["title"]?.toString() ?? '';
      final String dataBody = message.data["body"]?.toString() ?? '';
      final String title = (message.notification?.title ??
          (dataTitle.isNotEmpty ? dataTitle : 'WIT'));
      final String body = (message.notification?.body ??
          (dataBody.isNotEmpty ? dataBody : 'Hello there ^_^'));

      if (Platform.isIOS && message.notification != null) {
        return;
      }
      await _showLocalNotification(title: title, body: body, payload: payload);
    });
  }

  /// Handle background messages (app opened from background)
  void _handleBackgroundMessages() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      Helpers.log(
          "Background Message", "Notification Payload: ${message.data}");

      String payload = _extractPayload(message.data);
      if (payload.isNotEmpty) {
        await _handleNotificationClick(payload, false);
      }
    });
  }

  /// Handle FCM token refresh
  void _handleTokenRefresh() {
    _messaging?.onTokenRefresh.listen((String newToken) {
      String platform = Platform.isIOS ? "iOS" : "Android";
      Helpers.log("FCM Token Refresh", "Platform: $platform");
      Helpers.log("FCM Token Refresh", "New Token: $newToken");
      print("==========================================");
      print("FCM TOKEN REFRESH - $platform");
      print("Full Token: $newToken");
      print("==========================================");
    });
  }

  /// Log FCM token with platform information
  Future<void> _logFcmToken() async {
    String? token = await getFcmToken();
    if (token != null) {
      String platform = Platform.isIOS ? "iOS" : "Android";
      Helpers.log("FCM Token", "Platform: $platform");
      Helpers.log("FCM Token", "Full Token: $token");
      print("==========================================");
      print("FCM TOKEN - $platform");
      print("Full Token: $token");
      print("==========================================");
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    await _localNotifications.show(
      id: (DateTime.now().millisecondsSinceEpoch & 0x7FFFFFFF),
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          icon: "drawable/ic_notification",
          color: AppColors.white_FFFFFF,
          colorized: true,
          styleInformation: BigTextStyleInformation(
            body.isNotEmpty ? body : 'Hello there ^_^',
            contentTitle: title.isNotEmpty ? title : 'WIT',
            summaryText: body.isNotEmpty ? body : 'Hello there ^_^',
            htmlFormatBigText: true,
            htmlFormatContentTitle: true,
            htmlFormatSummaryText: true,
            htmlFormatContent: true,
            htmlFormatTitle: true,
          ),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  /// Extract payload from message data
  /// Supports both:
  /// - Legacy: action;guid;type (e.g. HISTORY_ORDER_DETAIL)
  /// - Laravel attendance: deeplink, type, guid → ATTENDANCE_DETAIL;guid;type;deeplink
  String _extractPayload(Map<String, dynamic> data) {
    try {
      String? action = data["action"]?.toString();
      String guid = data["guid"]?.toString() ?? '';
      String type = data["type"]?.toString() ?? '';
      String deeplink = data["deeplink"]?.toString() ?? '';

      if (action != null && action.isNotEmpty) {
        return "$action;$guid;$type";
      }
      if (type == "attendance" && guid.isNotEmpty) {
        return "ATTENDANCE_DETAIL;$guid;$type;$deeplink";
      }
      return '';
    } catch (e) {
      Helpers.log("Payload Extraction Error", "Failed to extract payload: $e");
      return '';
    }
  }

  /// Returns true if deeplink points to attendance detail (e.g. https://wsystem.page.link/attendance/detail)
  bool _isAttendanceDetailDeeplink(String deeplink) {
    if (deeplink.isEmpty) return false;
    return deeplink.contains('attendance/detail');
  }

  /// Handle notification click
  /// If target is attendance detail, checks login first; when not logged in, redirects to login.
  Future<void> _handleNotificationClick(
      String payload, bool replaceAllStackNavigation) async {
    if (payload.isEmpty) return;

    Helpers.log("Handle Notification", payload);

    final listPayload = payload.split(';');
    String action = '';
    String guid = '';
    String type = '';
    String deeplink = '';

    try {
      action = listPayload.isNotEmpty ? listPayload[0] : '';
    } catch (e) {
      Helpers.log("Notification Error", "Failed to parse action: $e");
    }

    try {
      guid = listPayload.length > 1 ? listPayload[1] : '';
    } catch (e) {
      Helpers.log("Notification Error", "Failed to parse guid: $e");
    }

    try {
      type = listPayload.length > 2 ? listPayload[2] : '';
    } catch (e) {
      Helpers.log("Notification Error", "Failed to parse type: $e");
    }

    try {
      deeplink = listPayload.length > 3 ? listPayload[3] : '';
    } catch (e) {
      Helpers.log("Notification Error", "Failed to parse deeplink: $e");
    }

    Helpers.log("Notification Payload",
        "action: $action | guid: $guid | type: $type | deeplink: $deeplink");

    String route = splashRoute;
    ArgumentsMain argumentsMain = ArgumentsMain(
      isLogin: "true",
      currentIndex: 0,
    );

    // if (action == 'HISTORY_ORDER_DETAIL') {
    //   LocalStorageService.setGuidNotification(guid);
    //   argumentsMain = ArgumentsMain(
    //     isLogin: "true",
    //     currentIndex: 1,
    //   );
    //   route = mainRoute;
    // } else if (action == 'ATTENDANCE_DETAIL' || type == 'attendance') {
    //   if (guid.isNotEmpty &&
    //       _isAttendanceDetailDeeplink(deeplink) &&
    //       type == 'attendance') {
    //     route = '$attendanceDetailRoute/$guid';
    //     argumentsMain = ArgumentsMain(
    //       isLogin: "true",
    //       currentIndex: 0,
    //     );
    //   }
    // }

    // Redirect attendance detail to login when not logged in
    // if (route.startsWith(attendanceDetailRoute)) {
    //   final token = await SecureStorageService.getApiToken();
    //   if (token == null || token.toString().isEmpty) {
    //     route = loginRoute;
    //     Helpers.log("Notification", "Not logged in, redirecting to login");
    //   }
    // }

    // Cold start: save route for Splash to use (GoRouter/splash not ready yet)
    if (replaceAllStackNavigation && route != splashRoute) {
      _pendingInitialRoute = route;
      Helpers.log("Notification", "Pending cold-start route: $route");
      return;
    }

    // Foreground/background: push on top of current stack so back returns to previous page
    if (route != splashRoute) {
      appRouter.push(route, extra: argumentsMain);
    }
  }

  /// Returns and clears the route saved when app was opened from terminated state via notification.
  /// Call from Splash when about to leave (e.g. before goTo(mainRoute)) and navigate to this route if non-null.
  String? getAndClearPendingInitialRoute() {
    final r = _pendingInitialRoute;
    _pendingInitialRoute = null;
    return r;
  }

  /// Get FCM token safely
  /// Handles iOS APNS token requirement properly
  Future<String?> getFcmToken() async {
    if (_messaging == null) {
      Helpers.log("FCM Token Error", "Firebase Messaging not initialized");
      return null;
    }

    String platform = Platform.isIOS ? "iOS" : "Android";

    try {
      if (Platform.isIOS) {
        // On iOS, we need to wait for APNS token first
        String? apnsToken;
        try {
          apnsToken = await _messaging!.getAPNSToken();

          // If APNS token is null, wait a bit and retry (max 5 times)
          int retries = 0;
          while (apnsToken == null && retries < 5) {
            await Future.delayed(Duration(milliseconds: 500));
            apnsToken = await _messaging!.getAPNSToken();
            retries++;
          }

          if (apnsToken == null) {
            Helpers.log("APNS Token",
                "APNS token not available yet, skipping FCM token");
            print("==========================================");
            print("APNS TOKEN - iOS");
            print("APNS token not available yet");
            print("==========================================");
            return null;
          }

          Helpers.log("APNS Token", "APNS token received: $apnsToken");
          print("==========================================");
          print("APNS TOKEN - iOS");
          print("Full APNS Token: $apnsToken");
          print("==========================================");
        } catch (e) {
          Helpers.log("APNS Token Error", "Error getting APNS token: $e");
          print("==========================================");
          print("APNS TOKEN ERROR - iOS");
          print("Error: $e");
          print("==========================================");
          return null;
        }
      }

      // Now safely get FCM token
      String? fcmToken = await _messaging!.getToken();
      if (fcmToken != null) {
        Helpers.log("FCM Token", "Platform: $platform");
        Helpers.log("FCM Token", "Full Token: $fcmToken");
        print("==========================================");
        print("FCM TOKEN - $platform");
        print("Full Token: $fcmToken");
        print("==========================================");
      } else {
        Helpers.log("FCM Token", "Platform: $platform - Token is null");
        print("==========================================");
        print("FCM TOKEN - $platform");
        print("Token is null");
        print("==========================================");
      }
      return fcmToken;
    } catch (e) {
      Helpers.log("FCM Token Error", "Platform: $platform - Error: $e");
      print("==========================================");
      print("FCM TOKEN ERROR - $platform");
      print("Error: $e");
      print("==========================================");
      return null;
    }
  }

  /// Refresh FCM token
  Future<String?> refreshFcmToken() async {
    if (_messaging == null) {
      Helpers.log(
          "FCM Token Refresh Error", "Firebase Messaging not initialized");
      return null;
    }

    try {
      await _messaging!.deleteToken();
      return await getFcmToken();
    } catch (e) {
      Helpers.log("FCM Token Refresh Error", "Error refreshing FCM token: $e");
      return null;
    }
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    if (_messaging == null) return;

    try {
      await _messaging!.subscribeToTopic(topic);
      Helpers.log("Topic Subscription", "Subscribed to topic: $topic");
    } catch (e) {
      Helpers.log("Topic Subscription Error",
          "Failed to subscribe to topic $topic: $e");
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    if (_messaging == null) return;

    try {
      await _messaging!.unsubscribeFromTopic(topic);
      Helpers.log("Topic Unsubscription", "Unsubscribed from topic: $topic");
    } catch (e) {
      Helpers.log("Topic Unsubscription Error",
          "Failed to unsubscribe from topic $topic: $e");
    }
  }

  /// Dispose resources
  void dispose() {
    _didReceiveLocalNotificationSubject.close();
    _selectNotificationSubject.close();
  }
}

/// Background message handler
/// Must be a top-level function for Firebase
/// @pragma('vm:entry-point') keeps this function so iOS/Android can invoke the background isolate
/// This runs in a separate isolate, so we can't use context or navigation here
/// The notification will be handled when the app is opened via getInitialMessage or onMessageOpenedApp
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'WITAttendance',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Log the notification for debugging
  print("Background Handler ======================= ");
  print('Notification Payload: ${message.data}');

  // Extract payload (supports Laravel attendance: deeplink, type, guid)
  String payload = "";
  try {
    String? action = message.data["action"]?.toString();
    String guid = message.data["guid"]?.toString() ?? '';
    String type = message.data["type"]?.toString() ?? '';
    String deeplink = message.data["deeplink"]?.toString() ?? '';
    if (action != null && action.isNotEmpty) {
      payload = "$action;$guid;$type";
    } else if (type == "attendance" && guid.isNotEmpty) {
      payload = "ATTENDANCE_DETAIL;$guid;$type;$deeplink";
    }
  } catch (e) {
    print('Background Handler - Failed payload: $e');
    payload = '';
  }

  final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("drawable/ic_notification");
  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await localNotifications.initialize(settings: initializationSettings);

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
    playSound: true,
  );
  final androidPlugin =
      localNotifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  if (androidPlugin != null) {
    await androidPlugin.createNotificationChannel(channel);
  }

  final bool shouldShowLocal = message.notification == null;
  if (shouldShowLocal) {
    final String title = message.data["title"]?.toString() ?? 'WIT';
    final String body = message.data["body"]?.toString() ?? 'Hello there ^_^';
    await localNotifications.show(
      id: (DateTime.now().millisecondsSinceEpoch & 0x7FFFFFFF),
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: "drawable/ic_notification",
          color: AppColors.white_FFFFFF,
          colorized: true,
          styleInformation: BigTextStyleInformation(
            body.isNotEmpty ? body : 'Hello there ^_^',
            contentTitle: title.isNotEmpty ? title : 'WIT',
            summaryText: body.isNotEmpty ? body : 'Hello there ^_^',
            htmlFormatBigText: true,
            htmlFormatContentTitle: true,
            htmlFormatSummaryText: true,
            htmlFormatContent: true,
            htmlFormatTitle: true,
          ),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  if (payload.isNotEmpty) {
    print('Background Handler - Payload extracted: $payload');
  }
}