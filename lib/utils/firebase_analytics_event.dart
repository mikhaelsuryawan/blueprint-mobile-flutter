import 'package:firebase_analytics/firebase_analytics.dart';

import '../constants/app_settings.dart';

// Firebase Analytics Helper for sending event in every action or page
class FirebaseAnalyticsHelpers {
  static Future<void> sendAnalyticsEvent(
      {required String name, Map<String, dynamic>? parameters}) async {
    parameters ??= <String, dynamic>{};
    final trafficType = {Settings.trafficType: AppSettings.trafficType};
    parameters.addEntries(trafficType.entries);

    await FirebaseAnalytics.instance
        .logEvent(
      name: name,
      parameters: parameters.cast<String, Object>(),
    )
        .then((value) {
      print('logEvent succeeded: $name');
    });
  }
}
