import 'package:flutter/material.dart';

// All custom colors generate
class AppColors {
  static const primary_light = steelblue_tint_200; //for widget color
  static const secondary_light = gray_primary_100; //for background color
  static const accent_light = blue_3D6796;
  static const disabled_light = gray_primary_300;
  static const hint_light = neutral_surface_500;
  static const app_bar_light = gray_primary_100;
  static const icon_light = steelblue_shade_500;
  static const primary_container_light = light_blue_main_25;
  static const secondary_container_light = light_blue_main_100;

  static const primary_dark = steelblue_shade_500; //for widget color
  static const secondary_dark = steelblue_shade_400; //for background color
  static const accent_dark = blue_3D6796;
  static const disabled_dark = gray_primary_300;
  static const hint_dark = neutral_surface_500;
  static const app_bar_dark = steelblue_shade_400;
  static const icon_dark = steelblue_tint_200;
  static const primary_container_dark = light_blue_main_800;
  static const secondary_container_dark = light_blue_main_900;

  static const black_000000 = Color(0xFF000000);

  static const white_FFFFFF = Color(0xFFffffff);

  /// PRIMARY COLOR
  static const blue_3D6796 = Color(0xFF3D6796);

  // --- Tints (mix with white) ---
  static const steelblue_tint_900 = Color(0xFF5076A1);
  static const steelblue_tint_800 = Color(0xFF6485AB);
  static const steelblue_tint_700 = Color(0xFF7795B6);
  static const steelblue_tint_600 = Color(0xFF8BA4C0);
  static const steelblue_tint_500 = Color(0xFF9EB3CB);
  static const steelblue_tint_400 = Color(0xFFB1C2D5);
  static const steelblue_tint_300 = Color(0xFFC5D1E0);
  static const steelblue_tint_200 = Color(0xFFD8E1EA);
  static const steelblue_tint_100 = Color(0xFFECF0F5);
  static const steelblue_tint_50 = Color(0xFFFFFFFF);

  // --- Tones (mix with gray) ---
  static const steelblue_tone_900 = Color(0xFF446A94);
  static const steelblue_tone_800 = Color(0xFF4A6C92);
  static const steelblue_tone_700 = Color(0xFF516F8F);
  static const steelblue_tone_600 = Color(0xFF58718D);
  static const steelblue_tone_500 = Color(0xFF5F748B);
  static const steelblue_tone_400 = Color(0xFF657689);
  static const steelblue_tone_300 = Color(0xFF6C7987);
  static const steelblue_tone_200 = Color(0xFF737B84);
  static const steelblue_tone_100 = Color(0xFF797E82);
  static const steelblue_tone_50 = Color(0xFF808080);

  // --- Shades (mix with black) ---
  static const steelblue_shade_900 = Color(0xFF375D87);
  static const steelblue_shade_800 = Color(0xFF315278);
  static const steelblue_shade_700 = Color(0xFF2B4869);
  static const steelblue_shade_600 = Color(0xFF253E5A);
  static const steelblue_shade_500 = Color(0xFF1F344B);
  static const steelblue_shade_400 = Color(0xFF18293C);
  static const steelblue_shade_300 = Color(0xFF12232D);
  static const steelblue_shade_200 = Color(0xFF0C151E);
  static const steelblue_shade_100 = Color(0xFF060A0F);
  static const steelblue_shade_50 = Color(0xFF000000);

  // Main Color
  // RED
  static const red_main_25 = Color(0xFFFFF1F2);
  static const red_main_50 = Color(0xFFFFDFE0);
  static const red_main_100 = Color(0xFFFFC5C7);
  static const red_main_200 = Color(0xFFFF9DA1);
  static const red_main_300 = Color(0xFFFF656B);
  static const red_main_400 = Color(0xFFFE353D);
  static const red_main_500 = Color(0xFFED1C24);
  static const red_main_600 = Color(0xFFC70E15);
  static const red_main_700 = Color(0xFFA41016);
  static const red_main_800 = Color(0xFF881418);
  static const red_main_900 = Color(0xFF4A0508);

  // GREEN
  static const green_main_25 = Color(0xFFEFFAF5);
  static const green_main_50 = Color(0xFFD8F3E4);
  static const green_main_100 = Color(0xFFB4E6CD);
  static const green_main_200 = Color(0xFF83D2B0);
  static const green_main_300 = Color(0xFF6AC29F);
  static const green_main_400 = Color(0xFF2D9C73);
  static const green_main_500 = Color(0xFF1E7D5C);
  static const green_main_600 = Color(0xFF18644B);
  static const green_main_700 = Color(0xFF164F3D);
  static const green_main_800 = Color(0xFF134133);
  static const green_main_900 = Color(0xFF09251D);

  // BLUE
  static const blue_main_25 = Color(0xFFEEF8FF);
  static const blue_main_50 = Color(0xFFD8EFFF);
  static const blue_main_100 = Color(0xFFBAE3FF);
  static const blue_main_200 = Color(0xFF8BD4FF);
  static const blue_main_300 = Color(0xFF55B9FF);
  static const blue_main_400 = Color(0xFF2D99FF);
  static const blue_main_500 = Color(0xFF177AF9);
  static const blue_main_600 = Color(0xFF0F63E6);
  static const blue_main_700 = Color(0xFF144FB9);
  static const blue_main_800 = Color(0xFF15428A);
  static const blue_main_900 = Color(0xFF132C58);

  // LIGHT BLUE
  static const light_blue_main_25 = Color(0xFFEEF6FF);
  static const light_blue_main_50 = Color(0xFFD9EBFF);
  static const light_blue_main_100 = Color(0xFFBCDCFF);
  static const light_blue_main_200 = Color(0xFF8EC7FF);
  static const light_blue_main_300 = Color(0xFF59A8FF);
  static const light_blue_main_400 = Color(0xFF267DFF);
  static const light_blue_main_500 = Color(0xFF1B64F5);
  static const light_blue_main_600 = Color(0xFF144EE1);
  static const light_blue_main_700 = Color(0xFF173FB6);
  static const light_blue_main_800 = Color(0xFF193A8F);
  static const light_blue_main_900 = Color(0xFF142457);

  // Primary
  // Gray
  static const gray_primary_25 = Color(0xFFFCFCFD);
  static const gray_primary_50 = Color(0xFFF9FAFB);
  static const gray_primary_100 = Color(0xFFF2F4F7);
  static const gray_primary_200 = Color(0xFFE4E7EC);
  static const gray_primary_300 = Color(0xFFD0D5DD);
  static const gray_primary_400 = Color(0xFF98A2B3);
  static const gray_primary_500 = Color(0xFF667085);
  static const gray_primary_600 = Color(0xFF475467);
  static const gray_primary_700 = Color(0xFF344054);
  static const gray_primary_800 = Color(0xFF1D2939);
  static const gray_primary_900 = Color(0xFF101828);

  // Error
  static const error_primary_25 = Color(0xFFFFFBFA);
  static const error_primary_50 = Color(0xFFFEF3F2);
  static const error_primary_100 = Color(0xFFFEE4E2);
  static const error_primary_200 = Color(0xFFFECDCA);
  static const error_primary_300 = Color(0xFFFDA29B);
  static const error_primary_400 = Color(0xFFF97066);
  static const error_primary_500 = Color(0xFFF04438);
  static const error_primary_600 = Color(0xFFD92D20);
  static const error_primary_700 = Color(0xFFB42318);
  static const error_primary_800 = Color(0xFF912018);
  static const error_primary_900 = Color(0xFF7A271A);

  // Warning
  static const warning_primary_25 = Color(0xFFFFFCF5);
  static const warning_primary_50 = Color(0xFFFFFAEB);
  static const warning_primary_100 = Color(0xFFFEF0C7);
  static const warning_primary_200 = Color(0xFFFEDF89);
  static const warning_primary_300 = Color(0xFFFEC84B);
  static const warning_primary_400 = Color(0xFFFDB022);
  static const warning_primary_500 = Color(0xFFF79009);
  static const warning_primary_600 = Color(0xFFDC6803);
  static const warning_primary_700 = Color(0xFFB54708);
  static const warning_primary_800 = Color(0xFF93370D);
  static const warning_primary_900 = Color(0xFF7A2E0E);

  // Success
  static const success_primary_25 = Color(0xFFF6FEF9);
  static const success_primary_50 = Color(0xFFECFDF3);
  static const success_primary_100 = Color(0xFFD1FADF);
  static const success_primary_200 = Color(0xFFA6F4C5);
  static const success_primary_300 = Color(0xFF6CE9A6);
  static const success_primary_400 = Color(0xFF32D583);
  static const success_primary_500 = Color(0xFF12B76A);
  static const success_primary_600 = Color(0xFF039855);
  static const success_primary_700 = Color(0xFF027A48);
  static const success_primary_800 = Color(0xFF05603A);
  static const success_primary_900 = Color(0xFF054F31);

  // Surface
  // Neutral
  static const neutral_surface_25 = Color(0xFFFAFAFA);
  static const neutral_surface_50 = Color(0xFFF5F5F5);
  static const neutral_surface_100 = Color(0xFFE5E5E5);
  static const neutral_surface_200 = Color(0xFFD4D4D4);
  static const neutral_surface_300 = Color(0xFFA3A3A3);
  static const neutral_surface_400 = Color(0xFF737373);
  static const neutral_surface_500 = Color(0xFF525252);
  static const neutral_surface_600 = Color(0xFF404040);
  static const neutral_surface_700 = Color(0xFF262626);
  static const neutral_surface_800 = Color(0xFF171717);
  static const neutral_surface_900 = Color(0xFF0A0A0A);

  // Zinc
  static const zinc_surface_25 = Color(0xFFFAFAFA);
  static const zinc_surface_50 = Color(0xFFF4F4F5);
  static const zinc_surface_100 = Color(0xFFE4E4E7);
  static const zinc_surface_200 = Color(0xFFD4D4D8);
  static const zinc_surface_300 = Color(0xFFA1A1AA);
  static const zinc_surface_400 = Color(0xFF71717A);
  static const zinc_surface_500 = Color(0xFF52525B);
  static const zinc_surface_600 = Color(0xFF3F3F46);
  static const zinc_surface_700 = Color(0xFF27272A);
  static const zinc_surface_800 = Color(0xFF18181B);
  static const zinc_surface_900 = Color(0xFF09090B);

  // Stone
  static const stone_surface_25 = Color(0xFFFAFAF9);
  static const stone_surface_50 = Color(0xFFF5F5F4);
  static const stone_surface_100 = Color(0xFFE7E5E4);
  static const stone_surface_200 = Color(0xFFD6D3D1);
  static const stone_surface_300 = Color(0xFFA8A29E);
  static const stone_surface_400 = Color(0xFF78716C);
  static const stone_surface_500 = Color(0xFF57534E);
  static const stone_surface_600 = Color(0xFF44403C);
  static const stone_surface_700 = Color(0xFF292524);
  static const stone_surface_800 = Color(0xFF1C1917);
  static const stone_surface_900 = Color(0xFF0C0A09);

  // Gray
  static const gray_surface_25 = Color(0xFFF9FAFB);
  static const gray_surface_50 = Color(0xFFF3F4F6);
  static const gray_surface_100 = Color(0xFFE5E7EB);
  static const gray_surface_200 = Color(0xFFD1D5DB);
  static const gray_surface_300 = Color(0xFF9CA3AF);
  static const gray_surface_400 = Color(0xFF6B7280);
  static const gray_surface_500 = Color(0xFF4B5563);
  static const gray_surface_600 = Color(0xFF374151);
  static const gray_surface_700 = Color(0xFF1F2937);
  static const gray_surface_800 = Color(0xFF111827);
  static const gray_surface_900 = Color(0xFF030712);

  // Slate
  static const slate_surface_25 = Color(0xFFF8FAFC);
  static const slate_surface_50 = Color(0xFFF1F5F9);
  static const slate_surface_100 = Color(0xFFE2E8F0);
  static const slate_surface_200 = Color(0xFFCBD5E1);
  static const slate_surface_300 = Color(0xFF94A3B8);
  static const slate_surface_400 = Color(0xFF64748B);
  static const slate_surface_500 = Color(0xFF475569);
  static const slate_surface_600 = Color(0xFF334155);
  static const slate_surface_700 = Color(0xFF1E293B);
  static const slate_surface_800 = Color(0xFF0F172A);
  static const slate_surface_900 = Color(0xFF020617);

  // INDIGO
  static const indigo_50 = Color(0xFFEEF2FF);
  static const indigo_100 = Color(0xFFE0E7FF);
  static const indigo_200 = Color(0xFFC7D2FE);
  static const indigo_300 = Color(0xFFA5B4FC);
  static const indigo_400 = Color(0xFF818CF8);
  static const indigo_500 = Color(0xFF6366F1);
  static const indigo_600 = Color(0xFF4F46E5);
  static const indigo_700 = Color(0xFF4338CA);
  static const indigo_800 = Color(0xFF3730A3);
  static const indigo_900 = Color(0xFF312E81);
  static const indigo_950 = Color(0xFF1E1B4B);

  // PURPLE
  static const purple_50 = Color(0xFFFAF5FF);
  static const purple_100 = Color(0xFFF3E8FF);
  static const purple_200 = Color(0xFFE9D5FF);
  static const purple_300 = Color(0xFFD8B4FE);
  static const purple_400 = Color(0xFFC084FC);
  static const purple_500 = Color(0xFFA855F7);
  static const purple_600 = Color(0xFF9333EA);
  static const purple_700 = Color(0xFF7E22CE);
  static const purple_800 = Color(0xFF6B21A8);
  static const purple_900 = Color(0xFF581C87);
  static const purple_950 = Color(0xFF3B0764);

  // YELLOW
  static const yellow_50 = Color(0xFFFEFCE8);
  static const yellow_100 = Color(0xFFFEF9C3);
  static const yellow_200 = Color(0xFFFEF08A);
  static const yellow_300 = Color(0xFFFDE047);
  static const yellow_400 = Color(0xFFFACC15);
  static const yellow_500 = Color(0xFFEAB308);
  static const yellow_600 = Color(0xFFCA8A04);
  static const yellow_700 = Color(0xFFA16207);
  static const yellow_800 = Color(0xFF854D0E);
  static const yellow_900 = Color(0xFF713F12);
  static const yellow_950 = Color(0xFF422006);

  // VIOLET
  static const violet_50 = Color(0xFFFAF5FF);
  static const violet_100 = Color(0xFFEDE9FE);
  static const violet_200 = Color(0xFFDDD6FE);
  static const violet_300 = Color(0xFFC4B5FD);
  static const violet_400 = Color(0xFFA78BFA);
  static const violet_500 = Color(0xFF8B5CF6);
  static const violet_600 = Color(0xFF7C3AED);
  static const violet_700 = Color(0xFF6D28D9);
  static const violet_800 = Color(0xFF5B21B6);
  static const violet_900 = Color(0xFF4C1D95);
  static const violet_950 = Color(0xFF2E1065);

// ROSE
  static const rose_50 = Color(0xFFFFF1F2);
  static const rose_100 = Color(0xFFFFE4E6);
  static const rose_200 = Color(0xFFFECDD3);
  static const rose_300 = Color(0xFFFDA4AF);
  static const rose_400 = Color(0xFFFB7185);
  static const rose_500 = Color(0xFFF43F5E);
  static const rose_600 = Color(0xFFE11D48);
  static const rose_700 = Color(0xFFBE123C);
  static const rose_800 = Color(0xFF9F1239);
  static const rose_900 = Color(0xFF881337);
  static const rose_950 = Color(0xFF4C0519);

// FUCHSIA
  static const fuchsia_50 = Color(0xFFFDF4FF);
  static const fuchsia_100 = Color(0xFFFAE8FF);
  static const fuchsia_200 = Color(0xFFF5D0FE);
  static const fuchsia_300 = Color(0xFFF0ABFC);
  static const fuchsia_400 = Color(0xFFE879F9);
  static const fuchsia_500 = Color(0xFFD946EF);
  static const fuchsia_600 = Color(0xFFC026D3);
  static const fuchsia_700 = Color(0xFFA21CAF);
  static const fuchsia_800 = Color(0xFF86198F);
  static const fuchsia_900 = Color(0xFF701A75);
  static const fuchsia_950 = Color(0xFF4A044E);
}
