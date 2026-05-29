# Styling

This document covers the theming system, color palette, typography, and design guidelines used in **Blueprint Mobile Flutter**.

---

## Theme System

The app supports **light** and **dark** mode, toggled by the user and persisted in `SharedPreferences`.

### Theme Architecture

```
AppThemeNotifier (Provider / ChangeNotifier)
├── getLightTheme() → ThemeData (Material 3)
└── getDarkTheme() → ThemeData (Material 3)

Consumed via:
├── Consumer<AppThemeNotifier>
└── context.read<AppThemeNotifier>().toggleTheme()
```

**Key files:**
- `lib/config/themes/notifiers/theme_manager.dart` — `AppThemeNotifier` (builds full `ThemeData`)
- `lib/config/themes/app_colors.dart` — Central color palette

### ThemeData Configuration

Both light and dark themes are configured with:

- **Material 3** (`useMaterial3: true`)
- **Google Fonts Inter** (all weights: Regular, Medium, SemiBold, Bold)
- **Custom ColorScheme** derived from the SteelBlue primary palette
- **System overlay styles** (status bar, navigation bar colors)
- **Consistent Card, AppBar, BottomNavigationBar, Dialog, and InputDecoration theming**

---

## Color Palette

All colors are defined in `lib/config/themes/app_colors.dart` as `static const` members of the `AppColors` class.

### Naming Convention

```
[COLOR NAME]_[HEX VALUE]
```

**Examples:**
```dart
static const black_393939 = Color(0xFF393939);
static const white_FFFFFF = Color(0xFFFFFFFF);
static const steelBlue_4682B4 = Color(0xFF4682B4);
```

### Primary Palette — SteelBlue

| Name | Hex | Usage |
|------|-----|-------|
| `steelBlue_4682B4` | `#4682B4` | Primary color |
| `steelBlue_100_79B5E0` | `#79B5E0` | Light tint |
| `steelBlue_200_6BA3D4` | `#6BA3D4` | Medium tint |
| `steelBlue_300_5B91C4` | `#5B91C4` | Standard |
| `steelBlue_400_4C7FB4` | `#4C7FB4` | Muted |
| `steelBlue_shade_800` | `#1A3A5E` | Dark shade |
| `steelBlue_shade_900` | `#0F2640` | Deepest shade |

### Semantic Colors

| Name | Hex | Usage |
|------|-----|-------|
| `red_F44336` | `#F44336` | Error / destructive actions |
| `green_4CAF50` | `#4CAF50` | Success / confirmation |
| `blue_2196F3` | `#2196F3` | Information links |
| `lightBlue_03A9F4` | `#03A9F4` | Secondary info |
| `yellow_FFEB3B` | `#FFEB3B` | Warnings |
| `purple_9C27B0` | `#9C27B0` | Accent |
| `violet_7C3AED` | `#7C3AED` | Accent variant |
| `rose_F43F5E` | `#F43F5E` | Highlight / sale |
| `fuchsia_D946EF` | `#D946EF` | Decorative |
| `indigo_6366F1` | `#6366F1` | Brand accent |

### Gray / Neutral Scale

| Name | Hex | Usage |
|------|-----|-------|
| `gray_50_F9FAFB` | `#F9FAFB` | Background (light) |
| `gray_100_F3F4F6` | `#F3F4F6` | Card background |
| `gray_200_E5E7EB` | `#E5E7EB` | Borders |
| `gray_300_D1D5DB` | `#D1D5DB` | Disabled |
| `gray_400_9CA3AF` | `#9CA3AF` | Placeholder text |
| `gray_500_6B7280` | `#6B7280` | Secondary text |
| `gray_600_4B5563` | `#4B5563` | Body text |
| `gray_700_374151` | `#374151` | Primary text |
| `gray_800_1F2937` | `#1F2937` | Headings |
| `gray_900_111827` | `#111827` | Darkest text |

### Extended Neutral Tones

The palette also includes Zinc, Stone, Slate, and Neutral scales (50–900) for fine-grained surface/foreground control:

- **Zinc** — `zinc_50_FAFAFA` through `zinc_900_18181B`
- **Stone** — `stone_50_FAF9F6` through `stone_900_1C1917`
- **Slate** — `slate_50_F8FAFC` through `slate_900_0F172A`
- **Neutral** — `neutral_50_FAFAFA` through `neutral_900_171717`

---

## Typography

### Font Family

**Inter** (via `google_fonts: ^8.0.1`) is used throughout the application.

The `AppThemeNotifier.getLightTheme()` and `getDarkTheme()` methods configure:

```dart
textTheme: GoogleFonts.interTextTheme(
  ThemeData.dark().textTheme.copyWith(
    headlineLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
    headlineMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
    titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
    titleMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    bodyLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    bodyMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
    labelLarge: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
  ),
)
```

### Font Weights Used

| Weight | Variable Name | Usage |
|--------|---------------|-------|
| `w700` (Bold) | `FontWeight.bold` | Headlines, section headers |
| `w600` (SemiBold) | `FontWeight.w600` | Navigation labels, button text |
| `w500` (Medium) | `FontWeight.w500` | Subheadings, emphasized body |
| `w400` (Regular) | `FontWeight.normal` | Body text, descriptions |

---

## Responsive Sizing

The app uses two responsive layers:

### 1. `Sizer` (package)

Wraps the entire widget tree in `Sizer()` from the `sizer` package, providing:
- `.w` / `.h` — percentage-based width/height
- `.sp` — scaled font sizes
- `.h1` / `.h2` / ... — predefined type scale

### 2. Custom `pxToSp()` Utility

Defined in `lib/utils/responsive_configuration.dart`:

```dart
double pxToSp(double px)
```

Uses **interpolated exponent tables** for mobile and tablet devices to smoothly scale font sizes across screen sizes. This gives more control than `Sizer.sp` alone, especially for tablets where text should scale differently.

---

## Component Styling

### Buttons (14 variants)

| Variant | Style |
|---------|-------|
| `OvalButton` | Fully rounded, filled background, primary color |
| `OvalBorderButton` | Fully rounded, outlined border, transparent background |
| `EdgeButton` | Square corners, filled background, primary color |
| `EdgeBorderButton` | Square corners, outlined border, transparent background |

Each comes in **Small (S)**, **Medium (M)**, **Large (L)**, and **Icon** sizes.

### Text Fields (3 variants)

| Variant | Style |
|---------|-------|
| `textfield_default` | Standard underline/border input |
| `textfield_icon_border` | Input with leading icon + border |
| `textfield_password` | Input with visibility toggle suffix |

### Dialogs

All dialogs follow a consistent style:
- Rounded corners
- Custom icon for each type (success → checkmark, error → X, etc.)
- Primary button + optional secondary button
- Semi-transparent barrier color

### Shimmers

Three skeleton variants for loading states:
- `shimmer_circle` — Circular placeholder (avatars)
- `shimmer_corner` — Square placeholder with rounded corners
- `shimmer_rounded_rectangle` — Full-width card placeholder

---

## Localization Context

When displaying user-facing styled text, always use the localization system:

```dart
AppLocalizations.of(context)!.helloWorld
```

Available locales:
- **en** — English (default)
- **id** — Bahasa Indonesia

The `AppLanguageNotifier` toggles between them and is persisted in `SharedPreferences`.

---

## Code Conventions

1. Never hardcode colors in widgets — always reference `AppColors.{name}`
2. Never hardcode font sizes — use `Sizer` scale or `pxToSp()`
3. Never hardcode user-facing strings — use `AppLocalizations.of(context)`
4. Never hardcode padding/margin — prefer theme `EdgeInsets` or `Sizer` dimensions
5. Use `const` constructors for any widget that doesn't change
6. Follow the color naming convention: `[COLOR]_[HEX]`
