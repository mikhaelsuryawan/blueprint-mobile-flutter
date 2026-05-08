import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  ///
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @prosesPayment.
  ///
  /// In en, this message translates to:
  /// **'Processing Payment'**
  String get prosesPayment;

  /// No description provided for @prosesPaymentDesc.
  ///
  /// In en, this message translates to:
  /// **'We are processing your payment, please wait a moment longer'**
  String get prosesPaymentDesc;

  /// No description provided for @successPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment Success'**
  String get successPayment;

  /// No description provided for @successPaymentDesc.
  ///
  /// In en, this message translates to:
  /// **'We have received your payment, thank you'**
  String get successPaymentDesc;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @nationalIdentityNumber.
  ///
  /// In en, this message translates to:
  /// **'NIK / No Passport / SIM'**
  String get nationalIdentityNumber;

  /// No description provided for @uploadNationalIdentityNumber.
  ///
  /// In en, this message translates to:
  /// **'Upload NIK / No Passport / SIM'**
  String get uploadNationalIdentityNumber;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @replace.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get replace;

  /// No description provided for @reUpload.
  ///
  /// In en, this message translates to:
  /// **'Re-upload'**
  String get reUpload;

  /// No description provided for @religion.
  ///
  /// In en, this message translates to:
  /// **'Religion'**
  String get religion;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @profession.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get profession;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @point.
  ///
  /// In en, this message translates to:
  /// **'Point'**
  String get point;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @citizenship.
  ///
  /// In en, this message translates to:
  /// **'Citizenship'**
  String get citizenship;

  /// No description provided for @bloodType.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get bloodType;

  /// No description provided for @maritalStatus.
  ///
  /// In en, this message translates to:
  /// **'Marital Status'**
  String get maritalStatus;

  /// No description provided for @homePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Home Phone Number'**
  String get homePhoneNumber;

  /// No description provided for @fullAddress.
  ///
  /// In en, this message translates to:
  /// **'Full Address'**
  String get fullAddress;

  /// No description provided for @province.
  ///
  /// In en, this message translates to:
  /// **'Province'**
  String get province;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @subdistrict.
  ///
  /// In en, this message translates to:
  /// **'Subdistrict'**
  String get subdistrict;

  /// No description provided for @rTrW.
  ///
  /// In en, this message translates to:
  /// **'RT/RW'**
  String get rTrW;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @showBy.
  ///
  /// In en, this message translates to:
  /// **'Show By'**
  String get showBy;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @emptyData.
  ///
  /// In en, this message translates to:
  /// **'Data Not Found'**
  String get emptyData;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @familyData.
  ///
  /// In en, this message translates to:
  /// **'Family Data'**
  String get familyData;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @queueNumber.
  ///
  /// In en, this message translates to:
  /// **'Queue Number'**
  String get queueNumber;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @promo.
  ///
  /// In en, this message translates to:
  /// **'Promo'**
  String get promo;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get birthDate;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @myDataAndFamily.
  ///
  /// In en, this message translates to:
  /// **'My Data & Family'**
  String get myDataAndFamily;

  /// No description provided for @myDataAndFamilyInfo.
  ///
  /// In en, this message translates to:
  /// **'See all the data in this account'**
  String get myDataAndFamilyInfo;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logoutConfirmationTitle;

  /// No description provided for @logoutConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmationMessage;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @repeatNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat New Password'**
  String get repeatNewPassword;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordInfo.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered phone number to reset your password'**
  String get resetPasswordInfo;

  /// No description provided for @emailOrPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Email / Phone Number'**
  String get emailOrPhoneNumber;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @submittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Submitted Successfully'**
  String get submittedSuccessfully;

  /// No description provided for @submittedSuccessfullyInfo.
  ///
  /// In en, this message translates to:
  /// **'The link to reset password has been sent, please check your email or message soon.'**
  String get submittedSuccessfullyInfo;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @repeatPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat Password'**
  String get repeatPassword;

  /// No description provided for @inputOtp.
  ///
  /// In en, this message translates to:
  /// **'Input OTP'**
  String get inputOtp;

  /// No description provided for @pointMenuAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get pointMenuAll;

  /// No description provided for @pointMenuMerchandise.
  ///
  /// In en, this message translates to:
  /// **'Merchandise'**
  String get pointMenuMerchandise;

  /// No description provided for @pointTitle.
  ///
  /// In en, this message translates to:
  /// **'My Point'**
  String get pointTitle;

  /// No description provided for @exchangePoint.
  ///
  /// In en, this message translates to:
  /// **'Exchange Point'**
  String get exchangePoint;

  /// No description provided for @valid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get valid;

  /// No description provided for @pointsExchanged.
  ///
  /// In en, this message translates to:
  /// **'Points Exchanged'**
  String get pointsExchanged;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @adminFee.
  ///
  /// In en, this message translates to:
  /// **'Admin Fee'**
  String get adminFee;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @totalCost.
  ///
  /// In en, this message translates to:
  /// **'Total cost'**
  String get totalCost;

  /// No description provided for @yourQueueNumber.
  ///
  /// In en, this message translates to:
  /// **'Your Queue Number'**
  String get yourQueueNumber;

  /// No description provided for @scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQrCode;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @dateofVisit.
  ///
  /// In en, this message translates to:
  /// **'Date of Visit'**
  String get dateofVisit;

  /// No description provided for @guarantor.
  ///
  /// In en, this message translates to:
  /// **'Guarantor'**
  String get guarantor;

  /// No description provided for @clinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic'**
  String get clinic;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'Alert!'**
  String get alert;

  /// No description provided for @detail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get detail;

  /// No description provided for @noBack.
  ///
  /// In en, this message translates to:
  /// **'No, Back'**
  String get noBack;

  /// No description provided for @yesCancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel'**
  String get yesCancel;

  /// No description provided for @confirmDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this account?'**
  String get confirmDeleteAccount;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yesDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete Account'**
  String get yesDeleteAccount;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @yourReason.
  ///
  /// In en, this message translates to:
  /// **'Give Your Reason'**
  String get yourReason;

  /// No description provided for @reasonCancellation.
  ///
  /// In en, this message translates to:
  /// **'Enter the reason for cancellation'**
  String get reasonCancellation;

  /// No description provided for @currentQueue.
  ///
  /// In en, this message translates to:
  /// **'Current Queue'**
  String get currentQueue;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @leaveSchedule.
  ///
  /// In en, this message translates to:
  /// **'Leave Schedule'**
  String get leaveSchedule;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @practiceSchedule.
  ///
  /// In en, this message translates to:
  /// **'Practice Schedule'**
  String get practiceSchedule;

  /// No description provided for @dataNotFound.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any registered data now, let\'s start adding new data now!'**
  String get dataNotFound;

  /// No description provided for @veryBad.
  ///
  /// In en, this message translates to:
  /// **'Very Bad'**
  String get veryBad;

  /// No description provided for @bad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get bad;

  /// No description provided for @quietGood.
  ///
  /// In en, this message translates to:
  /// **'Quiet Good'**
  String get quietGood;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @veryGood.
  ///
  /// In en, this message translates to:
  /// **'Very Good'**
  String get veryGood;

  /// No description provided for @answer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmail;

  /// No description provided for @checkEmail.
  ///
  /// In en, this message translates to:
  /// **'Check Email'**
  String get checkEmail;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'Email Successfully Sent!'**
  String get emailSent;

  /// No description provided for @emailSentDesc1.
  ///
  /// In en, this message translates to:
  /// **'We have sent a link to your email address'**
  String get emailSentDesc1;

  /// No description provided for @emailSentDesc2.
  ///
  /// In en, this message translates to:
  /// **'Immediately check your email or click the button below to carry out the verification process.'**
  String get emailSentDesc2;

  /// No description provided for @surveyReceived.
  ///
  /// In en, this message translates to:
  /// **'We have received your survey results, and you will get'**
  String get surveyReceived;

  /// No description provided for @addNew.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get addNew;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @seeDetail.
  ///
  /// In en, this message translates to:
  /// **'More Details'**
  String get seeDetail;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @nikIsAvailable.
  ///
  /// In en, this message translates to:
  /// **'NIK is Available!'**
  String get nikIsAvailable;

  /// No description provided for @nikIsAvailableDesc.
  ///
  /// In en, this message translates to:
  /// **'The NIK number you entered is already available, please check again.'**
  String get nikIsAvailableDesc;

  /// No description provided for @clearData.
  ///
  /// In en, this message translates to:
  /// **'Clear Data'**
  String get clearData;

  /// No description provided for @iAgree.
  ///
  /// In en, this message translates to:
  /// **'I Agree'**
  String get iAgree;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @termsAndConditionsCheck.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree with applicable terms and conditions'**
  String get termsAndConditionsCheck;

  /// No description provided for @termsAndConditionsDesc.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Malesuada nibh in scelerisque in nulla at. Fringilla cursus sit ultrices sem enim euismod tempor, posuere. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Malesuada nibh in scelerisque in nulla at. Fringilla cursus sit ultrices sem enim euismod tempor, posuere. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Malesuada nibh in scelerisque in nulla at. Fringilla cursus sit ultrices sem enim euismod tempor, posuere. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Malesuada nibh in scelerisque in nulla at. Fringilla cursus sit ultrices sem enim euismod tempor, posuere.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Malesuada nibh in scelerisque in nulla at. Fringilla cursus sit ultrices sem enim euismod tempor, posuere.'**
  String get termsAndConditionsDesc;

  /// No description provided for @sureDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete the data'**
  String get sureDelete;

  /// No description provided for @voucher.
  ///
  /// In en, this message translates to:
  /// **'Voucher'**
  String get voucher;

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enter;

  /// No description provided for @entaerVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get entaerVerificationCode;

  /// No description provided for @sixDigitCode.
  ///
  /// In en, this message translates to:
  /// **'six-digit code has been sent to your mobile number'**
  String get sixDigitCode;

  /// No description provided for @enterCodeToContinue.
  ///
  /// In en, this message translates to:
  /// **'Enter code to continue'**
  String get enterCodeToContinue;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @makeYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account!'**
  String get makeYourAccount;

  /// No description provided for @fillDataBelow.
  ///
  /// In en, this message translates to:
  /// **'Fill the data below to create a new account.'**
  String get fillDataBelow;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @choosenLanguage.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get choosenLanguage;

  /// No description provided for @languageIcon.
  ///
  /// In en, this message translates to:
  /// **'assets/images/img_english.png'**
  String get languageIcon;

  /// No description provided for @voucherCode.
  ///
  /// In en, this message translates to:
  /// **'Voucher Code'**
  String get voucherCode;

  /// No description provided for @exchangedPoint.
  ///
  /// In en, this message translates to:
  /// **'Point Exchanged'**
  String get exchangedPoint;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @checkUpHistory.
  ///
  /// In en, this message translates to:
  /// **'Check-up History'**
  String get checkUpHistory;

  /// No description provided for @checkUpDetailDownload.
  ///
  /// In en, this message translates to:
  /// **'Download Check-up Details'**
  String get checkUpDetailDownload;

  /// No description provided for @checkCheckUpResult.
  ///
  /// In en, this message translates to:
  /// **'Check-up Results'**
  String get checkCheckUpResult;

  /// No description provided for @successRegisterMessage.
  ///
  /// In en, this message translates to:
  /// **'User register successful, please login to continue'**
  String get successRegisterMessage;

  /// No description provided for @successRegisterCard.
  ///
  /// In en, this message translates to:
  /// **'Direct Debit Card added successfully, please continue payment'**
  String get successRegisterCard;

  /// No description provided for @successResetMessage.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get successResetMessage;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @serviceNotFound.
  ///
  /// In en, this message translates to:
  /// **'Service not found'**
  String get serviceNotFound;

  /// No description provided for @anErrorOccurredPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'An error occurred, please try again later'**
  String get anErrorOccurredPleaseTryAgainLater;

  /// No description provided for @problemWithNetwork.
  ///
  /// In en, this message translates to:
  /// **'There is a problem with the network, please wait a few more moments'**
  String get problemWithNetwork;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account'**
  String get alreadyHaveAnAccount;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @fillDataToLogin.
  ///
  /// In en, this message translates to:
  /// **'Fill in the data below to log in to your account'**
  String get fillDataToLogin;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account'**
  String get dontHaveAnAccount;

  /// No description provided for @pullUpToLoad.
  ///
  /// In en, this message translates to:
  /// **'Pull Up to Load'**
  String get pullUpToLoad;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Load failed'**
  String get loadFailed;

  /// No description provided for @releaseToLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Release to load more'**
  String get releaseToLoadMore;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @passwordDoesntMatch.
  ///
  /// In en, this message translates to:
  /// **'Password doesn\'t match'**
  String get passwordDoesntMatch;

  /// No description provided for @descDialogUpdateProfile.
  ///
  /// In en, this message translates to:
  /// **'You have successfully changed your personal data.'**
  String get descDialogUpdateProfile;

  /// No description provided for @descDialogChangePassword.
  ///
  /// In en, this message translates to:
  /// **'You have successfully changed your password.'**
  String get descDialogChangePassword;

  /// No description provided for @descDialogDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Your account has been successfully deleted.'**
  String get descDialogDeleteAccount;

  /// No description provided for @question_1.
  ///
  /// In en, this message translates to:
  /// **'Question '**
  String get question_1;

  /// No description provided for @question_2.
  ///
  /// In en, this message translates to:
  /// **' cannot be empty'**
  String get question_2;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @birthPlace.
  ///
  /// In en, this message translates to:
  /// **'Birth Place'**
  String get birthPlace;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressKtp.
  ///
  /// In en, this message translates to:
  /// **'Address according to identity card'**
  String get addressKtp;

  /// No description provided for @addressDomicile.
  ///
  /// In en, this message translates to:
  /// **'Address according to domicile'**
  String get addressDomicile;

  /// No description provided for @addressDomicileMatchesKtp.
  ///
  /// In en, this message translates to:
  /// **'The domicile address matches the ID card address'**
  String get addressDomicileMatchesKtp;

  /// No description provided for @addressGuardianMatchesPatient.
  ///
  /// In en, this message translates to:
  /// **'The address is the same as the patient'**
  String get addressGuardianMatchesPatient;

  /// No description provided for @addressNo.
  ///
  /// In en, this message translates to:
  /// **'Address Number'**
  String get addressNo;

  /// No description provided for @village.
  ///
  /// In en, this message translates to:
  /// **'Village'**
  String get village;

  /// No description provided for @rT.
  ///
  /// In en, this message translates to:
  /// **'RT'**
  String get rT;

  /// No description provided for @rW.
  ///
  /// In en, this message translates to:
  /// **'RW'**
  String get rW;

  /// No description provided for @selectProvinceFirst.
  ///
  /// In en, this message translates to:
  /// **'Select province first'**
  String get selectProvinceFirst;

  /// No description provided for @selectCityFirst.
  ///
  /// In en, this message translates to:
  /// **'Select city first'**
  String get selectCityFirst;

  /// No description provided for @selectDistrictFirst.
  ///
  /// In en, this message translates to:
  /// **'Select district first'**
  String get selectDistrictFirst;

  /// No description provided for @selectVillageFirst.
  ///
  /// In en, this message translates to:
  /// **'Select village first'**
  String get selectVillageFirst;

  /// No description provided for @zipCode.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zipCode;

  /// No description provided for @familyRelation.
  ///
  /// In en, this message translates to:
  /// **'Family Relation'**
  String get familyRelation;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @notice.
  ///
  /// In en, this message translates to:
  /// **'Notice'**
  String get notice;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @paymentCode.
  ///
  /// In en, this message translates to:
  /// **'Payment Code'**
  String get paymentCode;

  /// No description provided for @waitingPayment.
  ///
  /// In en, this message translates to:
  /// **'Waiting Payment'**
  String get waitingPayment;

  /// No description provided for @copyClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to your clipboard!'**
  String get copyClipboard;

  /// No description provided for @totalPayment.
  ///
  /// In en, this message translates to:
  /// **'Total Payment'**
  String get totalPayment;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @totalNominal.
  ///
  /// In en, this message translates to:
  /// **'Nominal Total'**
  String get totalNominal;

  /// No description provided for @transferAmount.
  ///
  /// In en, this message translates to:
  /// **'Transfer Amount'**
  String get transferAmount;

  /// No description provided for @uniqueCode.
  ///
  /// In en, this message translates to:
  /// **'Unique Code'**
  String get uniqueCode;

  /// No description provided for @howToPay.
  ///
  /// In en, this message translates to:
  /// **'How to Pay'**
  String get howToPay;

  /// No description provided for @expPaymentInfo.
  ///
  /// In en, this message translates to:
  /// **'You need to complete the payment before '**
  String get expPaymentInfo;

  /// No description provided for @uniqueCodeInformation.
  ///
  /// In en, this message translates to:
  /// **'Pastikan nominal sesuai hingga 4 digit terakhir!'**
  String get uniqueCodeInformation;

  /// No description provided for @paymentInformation.
  ///
  /// In en, this message translates to:
  /// **'Pesanan akan otomatis dibatalkan apabila Anda tidak menyelesaikan pembayaran dalam satu hari setelah munculnya kode pembayaran.'**
  String get paymentInformation;

  /// No description provided for @registerByDate.
  ///
  /// In en, this message translates to:
  /// **'Register By Date'**
  String get registerByDate;

  /// No description provided for @registerByDoctor.
  ///
  /// In en, this message translates to:
  /// **'Register By Doctor'**
  String get registerByDoctor;

  /// No description provided for @minimal6character.
  ///
  /// In en, this message translates to:
  /// **'1. Minimal 6 character'**
  String get minimal6character;

  /// No description provided for @upperCase.
  ///
  /// In en, this message translates to:
  /// **'2. Uppercase'**
  String get upperCase;

  /// No description provided for @lowerCase.
  ///
  /// In en, this message translates to:
  /// **'3. Lowercase'**
  String get lowerCase;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'4. Number'**
  String get number;

  /// No description provided for @symbol.
  ///
  /// In en, this message translates to:
  /// **'5. Symbol'**
  String get symbol;

  /// No description provided for @selectDateFirst.
  ///
  /// In en, this message translates to:
  /// **'Select Date First'**
  String get selectDateFirst;

  /// No description provided for @selectClinicFirst.
  ///
  /// In en, this message translates to:
  /// **'Select Clinic First'**
  String get selectClinicFirst;

  /// No description provided for @selectDoctorFirst.
  ///
  /// In en, this message translates to:
  /// **'Select Doctor First'**
  String get selectDoctorFirst;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @failedPayment.
  ///
  /// In en, this message translates to:
  /// **'Failed Payment'**
  String get failedPayment;

  /// No description provided for @last4Card.
  ///
  /// In en, this message translates to:
  /// **'The last 4 card numbers'**
  String get last4Card;

  /// No description provided for @addDirectDebit.
  ///
  /// In en, this message translates to:
  /// **'Add Direct Debit'**
  String get addDirectDebit;

  /// No description provided for @inputActiveOVOPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Input active OVO phone number'**
  String get inputActiveOVOPhoneNumber;

  /// No description provided for @activeOVOPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Active OVO phone number'**
  String get activeOVOPhoneNumber;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @youHaventSavedaDebitCard.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t saved a debit card.'**
  String get youHaventSavedaDebitCard;

  /// No description provided for @comeOnAddYourCardFirst.
  ///
  /// In en, this message translates to:
  /// **'Come on, add your card first!'**
  String get comeOnAddYourCardFirst;

  /// No description provided for @addDebitCard.
  ///
  /// In en, this message translates to:
  /// **'Add Debit Card'**
  String get addDebitCard;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Do you want to exit an App'**
  String get exitApp;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @newApplicationAvailable.
  ///
  /// In en, this message translates to:
  /// **'The latest Application is now available'**
  String get newApplicationAvailable;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @inputYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Input your email address'**
  String get inputYourEmailAddress;

  /// No description provided for @inputYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Input your password'**
  String get inputYourPassword;

  /// No description provided for @inputYourName.
  ///
  /// In en, this message translates to:
  /// **'Input your name'**
  String get inputYourName;

  /// No description provided for @inputYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Input your phone number'**
  String get inputYourPhoneNumber;

  /// No description provided for @inputYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Input your address'**
  String get inputYourAddress;

  /// No description provided for @inputYourOldPassword.
  ///
  /// In en, this message translates to:
  /// **'Input your old password'**
  String get inputYourOldPassword;

  /// No description provided for @inputYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Input your new password'**
  String get inputYourNewPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @inputYourConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Input your confirm password'**
  String get inputYourConfirmPassword;

  /// No description provided for @myCareer.
  ///
  /// In en, this message translates to:
  /// **'My Career'**
  String get myCareer;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get notFound;

  /// No description provided for @aiChat.
  ///
  /// In en, this message translates to:
  /// **'AI Chat'**
  String get aiChat;

  /// No description provided for @eventList.
  ///
  /// In en, this message translates to:
  /// **'There are currently no events available for you.'**
  String get eventList;

  /// No description provided for @homeWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get homeWelcomeTitle;

  /// No description provided for @homeWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s schedule your projects'**
  String get homeWelcomeSubtitle;

  /// No description provided for @homeOngoingProjects.
  ///
  /// In en, this message translates to:
  /// **'Ongoing Projects'**
  String get homeOngoingProjects;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @careerHighlights.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get careerHighlights;

  /// No description provided for @aiChatHintMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get aiChatHintMessage;

  /// No description provided for @aiChatEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Start a conversation'**
  String get aiChatEmptyTitle;

  /// No description provided for @aiChatEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask me anything and I\'ll help you'**
  String get aiChatEmptySubtitle;

  /// No description provided for @aiChatSimulatedResponse.
  ///
  /// In en, this message translates to:
  /// **'This is a simulated AI response. Replace this with your actual AI integration.'**
  String get aiChatSimulatedResponse;

  /// No description provided for @aiChatMissingApiKey.
  ///
  /// In en, this message translates to:
  /// **'AI chat is not configured. Add GOOGLE_GENAI_API_KEY to your .env file.'**
  String get aiChatMissingApiKey;

  /// No description provided for @aiChatErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get aiChatErrorGeneric;

  /// No description provided for @aiChatNoResponse.
  ///
  /// In en, this message translates to:
  /// **'No response was returned. Please try again.'**
  String get aiChatNoResponse;

  /// No description provided for @aiChatLoading.
  ///
  /// In en, this message translates to:
  /// **'Thinking…'**
  String get aiChatLoading;

  /// No description provided for @remoteUpdateDefaultMessage.
  ///
  /// In en, this message translates to:
  /// **'A new version of the app is available. Please update to continue.'**
  String get remoteUpdateDefaultMessage;

  /// No description provided for @unableToOpenAppStore.
  ///
  /// In en, this message translates to:
  /// **'Unable to open app store. Please update manually.'**
  String get unableToOpenAppStore;

  /// No description provided for @connectionDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'No Connection'**
  String get connectionDialogTitle;

  /// No description provided for @connectionDialogCheckInternet.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connectivity'**
  String get connectionDialogCheckInternet;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @pleaseEnterValidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get pleaseEnterValidPhoneNumber;

  /// No description provided for @pleaseSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Please select gender'**
  String get pleaseSelectGender;

  /// No description provided for @errorOldPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your current password'**
  String get errorOldPasswordRequired;

  /// No description provided for @errorNewPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a new password'**
  String get errorNewPasswordRequired;

  /// No description provided for @errorConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your new password'**
  String get errorConfirmPasswordRequired;

  /// No description provided for @errorPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get errorPasswordMinLength;

  /// No description provided for @errorNewPasswordSameAsOld.
  ///
  /// In en, this message translates to:
  /// **'New password must be different from your current password'**
  String get errorNewPasswordSameAsOld;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
