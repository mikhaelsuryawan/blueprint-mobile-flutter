import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_constants.dart';
import '../../../core/login/model/response/login_response.dart';
import '../../../core/profile/model/response/profile_response.dart';

/// In this file, we write all the code needed to store
/// and get data from the local storage using the plugin shared_preferences.
///
/// In this file, there will be getters and setters for each
/// and every data to be stored in the local storage.

class LocalStorageService {
  // Clear all local storage service
  static void clear() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();

    return;
  }

  // Save data for theme dark / light mode
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  // Read data for theme dark / light mode
  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  // Delete data for theme dark / light mode
  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  // Save data profile
  static void setProfile(ProfileDetailData profile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstant.profileData);
    await prefs.setString(AppConstant.profileData, detailDataToJson(profile));

    return;
  }

  // Delete data profile
  static void deleteProfile(ProfileDetailData profile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstant.profileData);

    return;
  }

  // Get data profile
  static Future<ProfileDetailData?> getProfile() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var profileData = pref.getString(AppConstant.profileData) ?? "";
    return profileData.isEmpty ? null : detailDataFromJson(profileData);
  }

  // Save data login
  static void setLogin(LoginData loginData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstant.loginData);
    await prefs.setString(
        AppConstant.loginData, json.encode(loginData.toJson()));

    return;
  }

  // Delete data profile
  static void deleteLogin(LoginData loginData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstant.loginData);

    return;
  }

  // Get data profile
  static Future<String> getLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(AppConstant.loginData) ?? "";
  }

  // Get Validation Network
  static Future<bool> getValidationNetwork() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool(AppConstant.validateNetwork) ?? true;
  }

  // Get Dialog Connection
  static Future<bool> getDialogConnection() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool('dialogConnection') ?? false;
  }

  // Save data isOnboarding
  static void setOnboarding(bool isLogin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstant.isOnboardingPage, isLogin);

    return;
  }

  // Get data isOnboarding
  static Future<bool?> getOnboarding() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool(AppConstant.isOnboardingPage) ?? false;
  }

  // Save data Discount Transaction
  static void setDiscountTransaction(double nominal, String? type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> discount = {
      AppConstant.discount: nominal,
      AppConstant.discountType: type ?? 'percent',
    };

    await prefs.setString(AppConstant.discount, jsonEncode(discount));

    return;
  }

  // Get data Discount Transaction
  static Future<Map<String, dynamic>> getDiscountTransaction() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> defaultDiscount = {
      AppConstant.discount: 0,
      AppConstant.discountType: 'percent',
    };

    return pref.getString(AppConstant.discount) != null
        ? jsonDecode(pref.getString(AppConstant.discount)!)
        : defaultDiscount;
  }

  // Save data Order Type
  static void setOrderType(String guid, String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> orderType = {
      AppConstant.orderTypeGuid: guid,
      AppConstant.orderTypeName: name,
    };

    await prefs.setString(AppConstant.orderType, jsonEncode(orderType));

    return;
  }

  // Get data Order Type
  static Future<Map<String, dynamic>?> getOrderType() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(AppConstant.orderType) != null
        ? jsonDecode(pref.getString(AppConstant.orderType)!)
        : null;
  }

  // Save data Note
  static void setNote(String note) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstant.note, note);

    return;
  }

  // Get data Note
  static Future<String> getNote() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(AppConstant.note) ?? '';
  }

  // Save data REORDER
  static void setGuidReorder(String note) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstant.reorder, note);

    return;
  }

  // Get data REORDER
  static Future<String> getGuidReorder() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(AppConstant.reorder) ?? '';
  }

  // Save data Notification
  static void setGuidNotification(String note) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstant.reorder, note);

    return;
  }

  // Get data Notification
  static Future<String> getGuidNotification() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(AppConstant.reorder) ?? '';
  }

  static void setPrinter(String printerName, String printerMacAddress) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstant.printerName);
    await prefs.setString(AppConstant.printerName, printerName);
    await prefs.setString(AppConstant.printerMacAddress, printerMacAddress);

    return;
  }

  static void setTypePrint(String printerType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstant.typePrint);
    await prefs.setString(AppConstant.typePrint, printerType);

    return;
  }

  static Future<String> getPrinterName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstant.printerName) ?? '-';
  }

  static Future<String> getPrinterMacAddress() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstant.printerMacAddress) ?? '-';
  }

  static Future<String> getTypePrint() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstant.typePrint) ?? '-';
  }

  static void setIpMainPrinter(String ipMainPrinter) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstant.ipMainPrinter);
    await prefs.setString(AppConstant.ipMainPrinter, ipMainPrinter);

    return;
  }

  static Future<String> getIpMainPrinter() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstant.ipMainPrinter) ?? '0.0.0.0';
  }

  static void setIpCoPrinter(String ipCoPrinter) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstant.ipCoPrinter);
    await prefs.setString(AppConstant.ipCoPrinter, ipCoPrinter);

    return;
  }

  static Future<String> getIpCoPrinter() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstant.ipCoPrinter) ?? '0.0.0.0';
  }

  static void setIsPrinterCo(String isPrinterCo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstant.isPrinterCo);
    await prefs.setString(AppConstant.isPrinterCo, isPrinterCo);

    return;
  }

  static Future<String> getIsPrinterCo() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstant.isPrinterCo) ?? 'inactive';
  }

  static void setSelectedPrinter(String selectedPrinter) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstant.selectedPrinter);
    await prefs.setString(AppConstant.selectedPrinter, selectedPrinter);

    return;
  }

  static Future<String> getSelectedPrinter() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstant.selectedPrinter) ?? '-';
  }
}
