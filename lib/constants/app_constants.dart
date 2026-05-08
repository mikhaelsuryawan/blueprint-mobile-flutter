import 'package:flutter/material.dart';

/// This file contains all the application constants

class AppConstant {
  /// Font
  // static final String fontSora = "Sora";
  // static final String fontDefault = fontSora;

  /// Local Storage Service
  static final String isLogin = "is_login";
  static final String profileData = "profile_data";
  static final String loginData = "login_data";
  static final String printerName = "printer_name";
  static final String printerMacAddress = "printer_mac_address";
  static final String typePrint = "type_print";
  static final String ipMainPrinter = "ip_main_printer";
  static final String ipCoPrinter = "ip_co_printer";
  static final String selectedPrinter = "selected_printer";
  static final String isPrinterCo = "is_printer_co";

  static final String androidForceUpdateVersionCode =
      "androidForceUpdateVersionCode";
  static final String androidRecommendUpdateVersionCode =
      "androidRecommendUpdateVersionCode";
  static final String androidUpdateMessage = "androidUpdateMessage";
  static final String iOSForceUpdateVersionCode = "iOSForceUpdateVersionCode";
  static final String iOSRecommendUpdateVersionCode =
      "iOSRecommendUpdateVersionCode";
  static final String iOSUpdateMessage = "iOSUpdateMessage";
  static final String iOSAppId = "iOSAppId";

  static final String loginAccess = "loginAccess";
  static final String cmsConfiguration = "cmsConfiguration";
  static final String roleTherapist = "therapist";
  static final String roleSpv = "spv";
  static final String roleEtc = "etc";

  /// Secure Storage Service
  static final String apiToken = "api_token";
  static final String refreshApiToken = "refresh_api_token";
  static final String fcmToken = "fcm_token";
  static final String deviceId = "device_id";
  static final String otpToken = "otp_token";
  static final String isOnboardingPage = "onboarding_page";
  static final String userRole = "user_role";
  static final String userProfile = "user_profile";
  static final String discount = "discount";
  static final String discountType = "discount_type";
  static final String note = "note";
  static final String reorder = "reorder";
  static final String orderType = "order_type";
  static final String orderTypeGuid = "order_type_guid";
  static final String orderTypeName = "order_type_name";
  static final String customer = "customer";
  static final String customProduct = "Custom Product By POS";
  static final String customCategoryProduct = "Custom Category Product By POS";
  static final String transaction = "transaction";
  static final String rememberMe = "remember_me";
  static final String rememberUsername = "remember_username";
  static final String rememberPassword = "remember_password";
  //Network Connection
  static final String validateNetwork = "validate_networks";

  /// Constant
  static final String mobileApp = "mobile-app";

  // Status Transaction
  static final String openBill = "Open Bills";
  static final String awaitingPayment = "Awaiting Payment";
  static final String openAccepted = "Order Accepted";
  static final String makingOrder = "Order Made";
  static final String partialyPaid = "Partialy Paid";
  static final String completed = "Completed";
  static final String cancelled = "Canceled";

  // Error Message
  static final String errorMessageName = "Nama tidak boleh kosong";
  static final String errorMessagePhone = "Nomor telepon tidak boleh kosong";
  static final String errorMessageEmail = "Email tidak valid";
  static final String errorMessageBirthDate =
      "Tanggal lahir tidak boleh kosong";
  static final String errorMessageGender = "Pilih jenis kelamin";
  static final String errorMessagePassword =
      "Min. 6 karakter termasuk angka dan karakter spesial";
  static final String errorMessageConfirmPassword = "Password tidak cocok";
}

/// Global Key
final globalKeyNavbar = GlobalKey();
