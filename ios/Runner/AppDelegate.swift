import UIKit
import Flutter
// import GoogleMaps
import Firebase
import FirebaseMessaging
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Initialize Google Maps BEFORE GeneratedPluginRegistrant
    // This is crucial for Google Maps to work on iOS
    // GMSServices.provideAPIKey("AIzaSyBN2xcF8Mx7YoeYyiPRe9quiStOu9KjXW8")
    
    // Initialize Firebase
    FirebaseApp.configure()
    
    // Register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)
    
    UNUserNotificationCenter.current().delegate = self
    
    // Register for remote notifications
    application.registerForRemoteNotifications()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
      print("Token: \(deviceToken)")
      super.application(application,
          didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }
  
  override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                        didReceive response: UNNotificationResponse,
                                        withCompletionHandler completionHandler: @escaping () -> Void) {
    super.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
  }
}
