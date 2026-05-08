import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/responsive_configuration.dart';
import '../../../utils/services/storage/local_storage_service.dart';
import '../app_colors.dart';

class AppThemeNotifier extends ChangeNotifier {
  // Get Inter font family from interTextTheme to allow fontWeight changes via copyWith
  static String? get _interFontFamily =>
      GoogleFonts.interTextTheme(ThemeData.light().textTheme)
          .bodyLarge
          ?.fontFamily;

  // Setup dark mode
  ThemeData getDarkTheme(BuildContext context) => ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        primaryColor: AppColors.primary_dark,
        scaffoldBackgroundColor: ColorScheme.dark().surface,
        highlightColor: AppColors.gray_primary_300,
        visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
        focusColor: AppColors.primary_dark,
        disabledColor: AppColors.disabled_dark,
        cardColor: AppColors.primary_dark,
        canvasColor: AppColors.primary_dark,
        dialogTheme: DialogThemeData(
          backgroundColor: ColorScheme.dark().surface,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          modalBackgroundColor: ColorScheme.dark().surface,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.primary_dark,
        ),
        bottomAppBarTheme: BottomAppBarThemeData(color: AppColors.primary_dark),
        tabBarTheme: TabBarThemeData(
          indicatorColor: AppColors.accent_dark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.accent_dark),
          ),
          hintStyle: TextStyle(
            color: AppColors.hint_dark,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
            // backgroundColor: AppColors.bgDark,
            actionTextColor: AppColors.neutral_surface_500,
            contentTextStyle: TextStyle(
              color: AppColors.neutral_surface_500,
            )),
        buttonTheme: ButtonThemeData(
            buttonColor: AppColors.accent_dark,
            disabledColor: AppColors.disabled_dark,
            colorScheme: ColorScheme.light(
              primary: AppColors.primary_dark,
              secondary: AppColors.secondary_dark,
              surface: AppColors.accent_dark,
            ),
            textTheme: ButtonTextTheme.primary),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.disabled_dark,
            foregroundColor: AppColors.disabled_dark,
            disabledForegroundColor: AppColors.gray_primary_800,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.primary_dark,
          shadowColor: AppColors.gray_primary_800,
          elevation: 10,
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ).copyWith(
          displayLarge: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 18),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w800,
          ),
          displayMedium: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 16),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w800,
          ),
          displaySmall: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 14),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w800,
          ),
          headlineLarge: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 18),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 16),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 14),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 18),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 16),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 14),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 18),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 16),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 14),
            color: AppColors.white_FFFFFF,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 18),
            color: AppColors.slate_surface_500,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 16),
            color: AppColors.slate_surface_500,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 14),
            color: AppColors.slate_surface_500,
            fontWeight: FontWeight.w400,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.app_bar_dark,
          surfaceTintColor: AppColors.app_bar_dark,
          foregroundColor: AppColors.app_bar_dark,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.app_bar_dark,
            systemNavigationBarDividerColor: AppColors.app_bar_dark,
            statusBarColor: AppColors.app_bar_dark,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          iconTheme: IconThemeData(color: AppColors.icon_dark),
          titleTextStyle: TextStyle(color: AppColors.icon_dark),
          toolbarTextStyle: TextStyle(color: AppColors.icon_dark),
        ),
        iconTheme: IconThemeData(
          color: AppColors.icon_dark,
        ),
        hintColor: AppColors.hint_dark,
        colorScheme: ColorScheme.dark().copyWith(
          brightness: Brightness.dark,
          primary: AppColors.secondary_dark,
          onPrimary: AppColors.primary_dark,
          secondary: AppColors.steelblue_shade_800,
          onSecondary: AppColors.white_FFFFFF,
          primaryContainer: AppColors.primary_container_dark,
          onPrimaryContainer: AppColors.primary_container_dark,
          secondaryContainer: AppColors.secondary_container_dark,
          onSecondaryContainer: AppColors.secondary_container_dark,
          tertiary: Color(0xFFEFB8C8),
          onTertiary: Color(0xFF492532),
          tertiaryContainer: Color(0xFF633B48),
          onTertiaryContainer: Color(0xFFFFD8E4),
          error: Color(0xFFF2B8B5),
          onError: Color(0xFF601410),
          errorContainer: Color(0xFF8C1D18),
          onErrorContainer: Color(0xFFF9DEDC),
          outline: Color(0xFF938F99),
          surface: AppColors.secondary_dark,
          onSurface: Color(0xFFE6E1E5),
          surfaceContainerHighest: Color(0xFF49454F),
          onSurfaceVariant: Color(0xFFCAC4D0),
          inverseSurface: Color(0xFFE6E1E5),
          onInverseSurface: Color(0xFF313033),
          inversePrimary: Color(0xFF6750A4),
          shadow: Color(0xFF000000),
          surfaceTint: AppColors.secondary_dark,
        ),
      );

  // Setup light mode
  ThemeData getLightTheme(BuildContext context) => ThemeData.light().copyWith(
        brightness: Brightness.light,
        primaryColor: AppColors.primary_light,
        scaffoldBackgroundColor: ColorScheme.light().surface,
        highlightColor: AppColors.gray_primary_300,
        visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
        focusColor: AppColors.primary_light,
        disabledColor: AppColors.disabled_light,
        cardColor: AppColors.primary_light,
        canvasColor: AppColors.primary_light,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.primary_light,
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: ColorScheme.light().surface,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          modalBackgroundColor: ColorScheme.light().surface,
        ),
        bottomAppBarTheme:
            BottomAppBarThemeData(color: AppColors.primary_light),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.accent_light),
          ),
          hintStyle: TextStyle(
            color: AppColors.hint_light,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
            // backgroundColor: AppColors.bgDark,
            actionTextColor: AppColors.white_FFFFFF,
            contentTextStyle: TextStyle(
              color: AppColors.white_FFFFFF,
            )),
        buttonTheme: ButtonThemeData(
            buttonColor: AppColors.accent_light,
            disabledColor: AppColors.disabled_light,
            colorScheme: ColorScheme.light(
              primary: AppColors.primary_light,
              secondary: AppColors.secondary_light,
              surface: AppColors.accent_light,
            ),
            textTheme: ButtonTextTheme.primary),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.disabled_light,
            foregroundColor: AppColors.disabled_light,
            disabledForegroundColor: AppColors.gray_primary_300,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.primary_light,
          surfaceTintColor: AppColors.primary_light,
          shadowColor: AppColors.gray_primary_300,
          elevation: 10,
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.light().textTheme,
        ).copyWith(
          displayLarge: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 18),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w400,
          ),
          displayMedium: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 16),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w800,
          ),
          displaySmall: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 14),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w800,
          ),
          headlineLarge: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 18),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 16),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 14),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 18),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 16),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 14),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 18),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 16),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 14),
            color: AppColors.neutral_surface_900,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 18),
            color: AppColors.slate_surface_500,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 16),
            color: AppColors.slate_surface_500,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            fontFamily: _interFontFamily,
            fontSize: pxToSp(context, 14),
            color: AppColors.slate_surface_500,
            fontWeight: FontWeight.w400,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.app_bar_light,
          surfaceTintColor: AppColors.app_bar_light,
          foregroundColor: AppColors.app_bar_light,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.app_bar_light,
            systemNavigationBarDividerColor: AppColors.app_bar_light,
            statusBarColor: AppColors.app_bar_light,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          iconTheme: IconThemeData(color: AppColors.icon_light),
          titleTextStyle: TextStyle(color: AppColors.icon_light),
          toolbarTextStyle: TextStyle(color: AppColors.icon_light),
        ),
        iconTheme: IconThemeData(
          color: AppColors.icon_light,
        ),
        hintColor: AppColors.hint_light,
        colorScheme: ColorScheme.light().copyWith(
          brightness: Brightness.light,
          primary: AppColors.secondary_light,
          onPrimary: AppColors.primary_light,
          secondary: AppColors.gray_primary_300,
          onSecondary: AppColors.gray_primary_300,
          primaryContainer: AppColors.primary_container_light,
          onPrimaryContainer: AppColors.primary_container_light,
          secondaryContainer: AppColors.secondary_container_light,
          onSecondaryContainer: AppColors.secondary_container_light,
          tertiary: Color(0xFF7D5260),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFFFD8E4),
          onTertiaryContainer: Color(0xFF31111D),
          error: Color(0xFFB3261E),
          onError: Color(0xFFFFFFFF),
          errorContainer: Color(0xFFF9DEDC),
          onErrorContainer: Color(0xFF410E0B),
          outline: Color(0xFF79747E),
          surface: AppColors.secondary_light,
          onSurface: Color(0xFF1C1B1F),
          surfaceContainerHighest: Color(0xFFE7E0EC),
          onSurfaceVariant: Color(0xFF49454F),
          inverseSurface: Color(0xFF313033),
          onInverseSurface: Color(0xFFF4EFF4),
          inversePrimary: Color(0xFFD0BCFF),
          shadow: Color(0xFF000000),
          surfaceTint: AppColors.app_bar_light,
        ),
      );

  // get theme mode
  ThemeData getTheme(BuildContext context) =>
      isDarkMode ? getDarkTheme(context) : getLightTheme(context);

  // for get dark mode
  bool isDarkMode = false;

  bool getIsDarkMode() => isDarkMode;

  // Notifier Dark / Light mode
  AppThemeNotifier() {
    LocalStorageService.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        print('setting light theme');
        LocalStorageService.saveData('themeMode', 'light');
        isDarkMode = false;

        // Set system overlay style for light mode
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.app_bar_light,
            systemNavigationBarDividerColor: AppColors.app_bar_light,
            statusBarColor: AppColors.app_bar_light,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        );
      } else {
        print('setting dark theme');
        LocalStorageService.saveData('themeMode', 'dark');
        isDarkMode = true;

        // Set system overlay style for dark mode
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.app_bar_dark,
            systemNavigationBarDividerColor: AppColors.app_bar_dark,
            statusBarColor: AppColors.app_bar_dark,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        );
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    isDarkMode = true;
    LocalStorageService.saveData('themeMode', 'dark');

    // Update system overlay style for dark mode
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.app_bar_dark,
        systemNavigationBarDividerColor: AppColors.app_bar_dark,
        statusBarColor: AppColors.app_bar_dark,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    notifyListeners();
  }

  void setLightMode() async {
    isDarkMode = false;
    LocalStorageService.saveData('themeMode', 'light');

    // Update system overlay style for light mode
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.app_bar_light,
        systemNavigationBarDividerColor: AppColors.app_bar_light,
        statusBarColor: AppColors.app_bar_light,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    notifyListeners();
  }

  static TextStyle getTextStyleFromTheme({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    required TextStyle? baseStyle,
  }) {
    final finalFontSize = fontSize ?? baseStyle?.fontSize;
    final finalFontWeight = fontWeight ?? baseStyle?.fontWeight;
    final finalFontStyle = fontStyle ?? baseStyle?.fontStyle;
    final finalColor = color ?? baseStyle?.color;
    final finalHeight = height ?? baseStyle?.height;
    final finalLetterSpacing = letterSpacing ?? baseStyle?.letterSpacing;
    final finalDecoration = decoration ?? baseStyle?.decoration;
    final finalDecorationColor = decorationColor ?? baseStyle?.decorationColor;
    final finalDecorationStyle = decorationStyle ?? baseStyle?.decorationStyle;
    final finalDecorationThickness =
        decorationThickness ?? baseStyle?.decorationThickness;

    return GoogleFonts.inter(
      fontSize: finalFontSize,
      fontWeight: finalFontWeight,
      fontStyle: finalFontStyle,
      color: finalColor,
      height: finalHeight,
      letterSpacing: finalLetterSpacing,
      decoration: finalDecoration,
      decorationColor: finalDecorationColor,
      decorationStyle: finalDecorationStyle,
      decorationThickness: finalDecorationThickness,
    );
  }
}
