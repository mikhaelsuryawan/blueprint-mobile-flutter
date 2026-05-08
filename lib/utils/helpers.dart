import 'dart:math';

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../widgets/dialog/dialog_error.dart';
import '../widgets/loadings/loading.dart';

class Helpers {
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

  // Build widget after data is updated
  static void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  // logging data
  static void log(String type, String data) {
    print("xxx : (" + type + ") : " + data);
  }

  // Setup status bar
  static void transparentStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.white,
      // systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
  }

  static void transparentStatusBarDark() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.white,
      // systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  static void transparentStatusBarLight() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.white,
      // systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
  }

  // currency formatter (Rupiah)
  static String rupiahFormat(dynamic value) {
    final formatCurrency =
        new NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'id_ID');
    try {
      return formatCurrency.format(double.tryParse(value));
    } catch (e) {
      // print(e);
      try {
        return formatCurrency.format(value);
      } catch (e) {
        // print(e);
      }
    }
    return value.toString();
  }

  // date formater
  static String formatDate(DateTime date) {
    return dateFormatdMMMMyyyy().format(date);
  }

  // date formater Local
  static String formatDateToLocal(DateTime date) {
    return dateFormatdMMMMyyyy().format(date.add(Duration(hours: 7)));
  }

  // date formater with time
  static String formatDateTime(DateTime date) {
    return DateFormat('d MMMM yyyy - H:mm').format(date);
  }

  static String formatDateTime2(DateTime date) {
    return DateFormat('d MMMM yyyy - HH:mm').format(date);
  }

  static String formatDateTime3(DateTime date) {
    return DateFormat('d MMMM yyyy (HH:mm)').format(date);
  }

  static String formatDateTime4(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy HH:mm').format(date);
  }

  static String formatDateTime5(DateTime date) {
    return DateFormat('d MMM yyyy HH:mm').format(date);
  }

  // date formater
  static String formatDayDate(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy').format(date);
  }

  // date only formater
  static String formatDateOnly(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // date only formater
  static String formatDateOnlyForRequest(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // time formater
  static String formatTime(DateTime date) {
    return DateFormat('H:mm').format(date);
  }

  // time formater
  static String formatTimeToLocal(DateTime date) {
    return DateFormat('H:mm').format(date.add(Duration(hours: 7)));
  }

  // time formater
  static String formatTimeSecond(DateTime date) {
    return DateFormat('H:mm:ss').format(date);
  }

  static String formatTimeSecondForRequest(DateTime date) {
    return DateFormat('HH:mm:ss').format(date);
  }

  static DateFormat dateFormatdMMMMyyyy() {
    return DateFormat('d MMMM yyyy');
  }

  static String formatDateMonth(DateTime date) {
    return DateFormat('dd/MM').format(date);
  }

  static bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = DateTime.now();
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isAfter(dateTime);
  }

  static bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = DateTime.now();
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isBefore(dateTime);
  }

  static bool? isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final isAfter = isAfterOrEqualTo(fromDateTime) ?? false;
    final isBefore = isBeforeOrEqualTo(toDateTime) ?? false;
    return isAfter && isBefore;
  }

  static DateTime nextDate(DateTime dateTime, int day) {
    return dateTime.add(
      Duration(
        days: (day - dateTime.weekday) % DateTime.daysPerWeek,
      ),
    );
  }

  static String calculatePercent(int from, int to) {
    double data = (from / to * 100);

    return data.toStringAsFixed(0);
  }

  static String calculatePercentDouble(double from, double to) {
    double data = (from / to * 100);

    return data.toStringAsFixed(0);
  }

  static Future<String> getIpAddress() async {
    var ipAddress = IpAddress(type: RequestType.text);
    String data = await ipAddress.getIpAddress();

    return data;
  }

  static dialogError(BuildContext context, String errorMessage) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext bc) {
        return DialogError(
          errorMessage: errorMessage,
          onSubmit: () {
            Navigator.pop(bc);
          },
        );
      },
    );
  }

  static dialogLoading(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Loading(
              isShow: true,
            ),
          ),
        );
      },
    );
  }

  static String capitalized(String value) {
    String data = value.split(' ').map((word) => word.capitalize()).join(' ');
    return data;
  }

  static DateTime parseDate(String date) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date);
  }

  static DateTime parseDate2(String date) {
    return DateFormat('yyyy-MM-dd').parse(date);
  }

  static DateTime parseDateFromUtcToLocale(String date) {
    DateTime from = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date, true);
    return from.toLocal();
  }

  static String getDateFromDateTime(DateTime date) {
    return DateFormat('dd').format(date);
  }

  static String getMonthFromDateTime(DateTime date) {
    return DateFormat('MMM').format(date);
  }

  static String getYearFromDateTime(DateTime date) {
    return DateFormat('yyyy').format(date);
  }

  static String getTimeFromDateTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String getTimeSecondFromDateTime(DateTime date) {
    return DateFormat('HH:mm:ss').format(date);
  }

  static String getStringFullDateFromDateTime(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static String getStringFullDateAndTimeFromDateTime(DateTime date) {
    return DateFormat('dd MMMM yyyy HH:mm').format(date);
  }

  static String getStringFullDate2FromDateTime(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String getStringYyyyMMdd(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static dynamic showToast(BuildContext context, String text) {
    return DelightToastBar(
            builder: (context) => ToastCard(
                  leading: Icon(
                    Icons.info_outline,
                    size: 17.sp,
                  ),
                  title: Text(
                    text,
                    style:
                        Theme.of(context).textTheme.bodyMedium ?? TextStyle(),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                ),
            autoDismiss: true,
            snackbarDuration: Duration(seconds: 2))
        .show(context);
  }

  static String strDigits(int n) => n.toString().padLeft(2, '0');

  /// Validates phone number format. Returns [true] if valid, [false] otherwise.
  /// Handles empty/whitespace and invalid format safely.
  static bool validatePhoneNumber(String phoneNumber) {
    bool result = false;

    if ((phoneNumber.startsWith("08") || phoneNumber.startsWith("+628")) &&
        ((phoneNumber.length >= 8) && (phoneNumber.length <= 18))) {
      result = true;
    }

    return result;
  }

  /// Validates email format. Returns [true] if valid, [false] otherwise.
  /// Handles empty/whitespace and invalid format safely.
  static bool validateEmail(String email) {
    final trimmed = email.trim();
    if (trimmed.isEmpty) return false;
    try {
      return EmailValidator.validate(trimmed);
    } catch (_) {
      return false;
    }
  }

  /// Validates password: min 6 characters, at least one number and one special character.
  /// Returns [true] if valid, [false] otherwise.
  static bool validatePassword(String password) {
    if (password.length < 6) return false;
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecial = RegExp(
      "[!@#\$%^&*(),.?\":{}|<>_\\-+=\\[\\]\\\\;/'`~]",
    ).hasMatch(password);
    return hasNumber && hasSpecial;
  }

  static double percentToNominal(
      {required double originalPrice,
      required double discountAmount,
      required String discountType}) {
    if (discountType == 'decimal' ||
        discountType == 'amount' ||
        discountType == 'nominal') {
      return discountAmount;
    }

    double discountNominal = originalPrice * (discountAmount / 100);

    return discountNominal;
  }

  // Check if device is tablet
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  // Check if device is in portrait orientation
  static bool isPortrait(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait;
  }

  // Check screen device Small or Large
  static bool isSmallScreen(BuildContext context) {
    return !isTablet(context) && isPortrait(context);
  }
}

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension DynamicExtension on dynamic {
  String toRupiah() {
    final formatCurrency =
        new NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'id_ID');
    try {
      return formatCurrency.format(double.tryParse(this));
    } catch (e) {
      // print(e);
      try {
        return formatCurrency.format(this);
      } catch (e) {
        // print(e);
      }
    }
    return this;
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension ListUtils<T> on List<T> {
  num sumBy(num f(T element)) {
    num sum = 0;
    for (var item in this) {
      sum += f(item);
    }
    return sum;
  }
}

String removeLastChars(Object eval, String text) {
  String res = '$eval';
  int length = text.length;

  if (res.length > length) {
    res = res.substring((res.length - length), res.length) == text
        ? res.substring(0, (res.length - length))
        : res;
  }

  return res;
}

DateTime getLastMonday(DateTime date) {
  // Cek hari sekarang, jika hari Senin langsung kembalikan hari ini
  if (date.weekday == DateTime.monday) {
    return date;
  } else {
    // Menghitung selisih hari untuk kembali ke hari Senin sebelumnya
    int daysToLastMonday = (date.weekday - DateTime.monday);
    return date.subtract(Duration(days: daysToLastMonday));
  }
}

dynamic getSuggestPrice(double priceTotal, int numberSuggest,
    {bool isDouble = false}) {
  double suggest_option_1 = 1.0;
  int kali = 1;

  for (int i = 0; i < removeLastChars(priceTotal, '.0').length; i++) {
    kali = kali * 10;
    suggest_option_1 = suggest_option_1 * 10;
  }

  if (numberSuggest == 1) suggest_option_1 = suggest_option_1 / 10;

  double subtotal = priceTotal;

  num suggestResult = (subtotal / (suggest_option_1));

  double priceSuggest = suggestResult.ceil() * (suggest_option_1);

  if (numberSuggest == 1 && subtotal < 50000) {
    priceSuggest = 50000;
  } else if (numberSuggest == 1 &&
      subtotal > 50000 &&
      subtotal == priceSuggest) {
    priceSuggest += 50000;
  } else if (numberSuggest == 2 && subtotal > 50000 && subtotal < 100000) {
    priceSuggest = 100000;
  }

  if (isDouble) {
    return priceSuggest;
  }

  return priceSuggest.toRupiah();
}
