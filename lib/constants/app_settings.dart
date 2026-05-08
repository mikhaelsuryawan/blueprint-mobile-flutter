import 'package:flutter_dotenv/flutter_dotenv.dart';

class Settings {
  static const appName = "appName";
  static const apiBaseUrl = "apiBaseUrl";
  static const apiPort = "apiPort";
  static const trafficType = "traffic_type";
  static const authAppName = "authAppName";
  static const authAppKey = "authAppKey";
  static const isUsePort = "isUsePort";
}

class EnvConst {
  static const appNameDevelopment = "APP_NAME_DEVELOPMENT";
  static const apiBaseUrlDevelopment = "API_BASE_URL_DEVELOPMENT";
  static const apiPortDevelopment = "API_PORT_DEVELOPMENT";
  static const trafficTypeDevelopment = "TRAFFIC_TYPE_DEVELOPMENT";
  static const authAppNameDevelopment = "AUTH_APP_NAME_DEVELOPMENT";
  static const authAppKeyDevelopment = "AUTH_APP_KEY_DEVELOPMENT";
  static const isUsePortDevelopment = "IS_USE_PORT_DEVELOPMENT";

  static const appNameProduction = "APP_NAME_PRODUCTION";
  static const apiBaseUrlProduction = "API_BASE_URL_PRODUCTION";
  static const apiPortProduction = "API_PORT_PRODUCTION";
  static const trafficTypeProduction = "TRAFFIC_TYPE_PRODUCTION";
  static const authAppNameProduction = "AUTH_APP_NAME_PRODUCTION";
  static const authAppKeyProduction = "AUTH_APP_KEY_PRODUCTION";
  static const isUsePortProduction = "IS_USE_PORT_PRODUCTION";
}

enum AppFlavor {
  development,
  production,
}

class AppSettings {
  static late AppFlavor flavor;

  static String get appName => flavor.getSetting(Settings.appName);

  static String get apiBaseUrl => flavor.getSetting(Settings.apiBaseUrl);

  static String get apiPort => flavor.getSetting(Settings.apiPort);

  static String get trafficType => flavor.getSetting(Settings.trafficType);

  static String get authAppName => flavor.getSetting(Settings.authAppName);

  static String get authAppKey => flavor.getSetting(Settings.authAppKey);

  static String get isUsePort => flavor.getSetting(Settings.isUsePort);
}

extension AppFlavorExtension on AppFlavor {
  static final Map<String, dynamic> developmentSettings = {
    Settings.appName: dotenv.env[EnvConst.appNameDevelopment],
    Settings.apiBaseUrl: dotenv.env[EnvConst.apiBaseUrlDevelopment],
    Settings.apiPort: dotenv.env[EnvConst.apiPortDevelopment],
    Settings.trafficType: dotenv.env[EnvConst.trafficTypeDevelopment],
    Settings.authAppName: dotenv.env[EnvConst.authAppNameDevelopment],
    Settings.authAppKey: dotenv.env[EnvConst.authAppKeyDevelopment],
    Settings.isUsePort: dotenv.env[EnvConst.isUsePortDevelopment],
  };

  static final Map<String, dynamic> productionSettings = {
    Settings.appName: dotenv.env[EnvConst.appNameProduction],
    Settings.apiBaseUrl: dotenv.env[EnvConst.apiBaseUrlProduction],
    Settings.apiPort: dotenv.env[EnvConst.apiPortProduction],
    Settings.trafficType: dotenv.env[EnvConst.trafficTypeProduction],
    Settings.authAppName: dotenv.env[EnvConst.authAppNameProduction],
    Settings.authAppKey: dotenv.env[EnvConst.authAppKeyProduction],
    Settings.isUsePort: dotenv.env[EnvConst.isUsePortProduction],
  };

  dynamic getSetting(String setting) {
    switch (this) {
      case AppFlavor.development:
        return developmentSettings[setting];
      case AppFlavor.production:
        return productionSettings[setting];
      default:
        throw "Unknown Flavor";
    }
  }
}
