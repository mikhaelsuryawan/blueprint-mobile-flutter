# Structure

This document explains the complete directory structure of **Blueprint Mobile Flutter** and the purpose of each folder.

---

## Top-Level Layout

```
blueprint-mobile-flutter/
├── android/              # Android native project (Kotlin, Gradle, google-services.json)
├── ios/                  # iOS native project (Swift, Podfile, Xcode config)
├── assets/               # App assets (images, Lottie animations)
├── lib/                  # Main Dart source code
├── test/                 # Unit + widget tests
├── documents/            # Project documentation
├── flutter_icons/        # App launcher icon source
├── .env                  # Environment variables (API URLs, keys)
├── pubspec.yaml          # Project manifest & dependencies
├── l10n.yaml             # Localization codegen config
├── AGENTS.md             # Codex / Claude Code instructions
└── analysis_options.yaml # Dart lint rules
```

---

## `lib/` — The Heart of the Application

```
lib/
├── main.dart                     # App entry point
├── firebase_options.dart         # Firebase per-platform config (auto-generated)
│
├── config/                       # Global app configuration
│   ├── language/
│   │   ├── app_localizations.dart      # Localization delegate
│   │   └── language_manager.dart        # AppLanguageNotifier (Provider)
│   ├── routes/
│   │   ├── animated_go_route.dart       # Animated page builder helper
│   │   ├── animated_route.dart          # Base animated transition definitions
│   │   ├── go_route_generator.dart      # Master GoRouter with 14 routes
│   │   ├── routes.dart                  # Route path string constants
│   │   └── routes_generator.dart        # Alternative route generator
│   └── themes/
│       ├── app_colors.dart              # 317-line color palette
│       └── notifiers/
│           └── theme_manager.dart        # AppThemeNotifier (Provider)
│
├── constants/                  # App-level constants & settings
│   ├── app_constants.dart      # Storage keys, error messages, statuses
│   ├── app_settings.dart       # Flavor-based config from .env
│   ├── assets_path.dart        # All asset file paths
│   └── open_router_constants.dart # OpenRouter API config
│
├── core/                       # FEATURE BUSINESS LOGIC
│   └── {feature}/              # Each feature has its own directory
│       ├── bloc/               # Events, BLoC class, States
│       ├── repository/         # Data access layer
│       └── model/
│           ├── request/        # Request DTOs
│           └── response/       # Response DTOs
│
├── l10n/                       # Localization
│   ├── app_en.arb              # English strings
│   ├── app_id.arb              # Indonesian strings
│   ├── app_localizations.dart  # Generated delegate
│   ├── app_localizations_en.dart
│   └── app_localizations_id.dart
│
├── screens/                    # FEATURE UI LAYER
│   └── {feature}/
│       ├── screen/             # Thin page wrapper (injects BLoCs)
│       ├── body/               # UI layout & BLoC state rendering
│       ├── controller/         # Form controllers, local state, interaction helpers
│       └── item/               # Repeated feature-specific item widgets
│
├── utils/                      # Utility classes & services
│   ├── helpers.dart            # Navigation, logging, formatting, validation
│   ├── responsive_configuration.dart  # Custom pxToSp() scaling
│   ├── compress_image.dart     # Image compression
│   ├── firebase_analytics_event.dart  # Analytics event helpers
│   └── services/
│       ├── api/                # Dio stack (Client, DioFactory, AuthInterceptor, TokenManager)
│       ├── notification/       # FCM + local notifications (NotificationService)
│       ├── remote_config/      # Firebase Remote Config (RemoteConfigService)
│       └── storage/            # SharedPreferences + FlutterSecureStorage wrappers
│
└── widgets/                    # REUSABLE SHARED WIDGETS
    ├── buttons/                # 14 button variants
    ├── dialog/                 # 7 dialog types
    ├── images/                 # 3 image widgets
    ├── shimmers/               # 3 shimmer skeletons
    ├── textfield/              # 3 text field variants
    ├── default_appbar.dart
    ├── fill_space.dart
    ├── separator.dart
    ├── safe_area_top.dart / safe_area_bottom.dart
    ├── loading.dart
    ├── menu/menu_chevron.dart
    └── pull_to_refresh/app_smart_refresher_parts.dart
```

---

## Layer Responsibilities

### `config/` — Application Configuration

| Subfolder | Purpose |
|-----------|---------|
| `config/language/` | Localization delegate + `AppLanguageNotifier` (ChangeNotifier for EN/ID switching) |
| `config/routes/` | GoRouter definition, route path constants, animated page transitions |
| `config/themes/` | Color palette (`AppColors`), `AppThemeNotifier` (light/dark ThemeData with Google Fonts Inter) |

### `constants/` — App-Level Constants

| File | Purpose |
|------|---------|
| `app_constants.dart` | Storage keys (theme mode, language, profile data, login state), error messages, status enums |
| `app_settings.dart` | `AppSettings` singleton — reads `.env` values, determines `AppFlavor` (dev/prod) |
| `assets_path.dart` | `Assets` class — typed constants for every SVG, PNG, and Lottie file path |
| `open_router_constants.dart` | OpenRouter base URL, API key, model ID (from `.env`) |

### `core/` — Feature Business Logic

Each feature follows a strict **BLoC pattern**:

```
core/{feature}/
├── bloc/
│   ├── {feature}_bloc.dart     # Bloc<XEvent, XState>
│   ├── {feature}_event.dart    # Abstract event + IdleEvent + Fetched
│   └── {feature}_state.dart    # Abstract state + Init + Idle + Loading + Loaded + Error
├── repository/
│   └── {feature}_repository.dart  # API calls via Client factory
└── model/
    ├── request/{feature}_request.dart   # Request DTO with fromJson/toJson
    └── response/{feature}_response.dart  # Response DTO with fromJson/toJson
```

**Implemented features:**

| Feature | BLoC | Description |
|---------|------|-------------|
| `auth_token` | ✅ | Device auth token management |
| `change_password` | ✅ | Password change flow |
| `chat` | ✅ | Streaming AI chat (OpenRouter, chunk accumulation via StreamSubscription) |
| `ai_chat` | ✅ | Google AI / Gemini integration |
| `fcm` | ✅ | FCM token update to backend |
| `login` | ✅ | Authentication with error code checking |
| `logout` | ✅ | Session termination |
| `onboarding` | ✅ | Onboarding walkthrough data |
| `profile` | ✅ | User profile retrieval |
| `refresh_token` | ✅ | Token refresh cycle |
| `sign_up` | ✅ | User registration |
| `update_profile` | ✅ | Profile update |
| `update_profile_pictures` | — | Profile picture upload (repository only) |

### `screens/` — UI Layer

Each screen follows a consistent breakdown:

| Component | Responsibility |
|-----------|---------------|
| `screen/` | Thin widget that wraps the body, provides BLoC via `BlocProvider`, receives route arguments |
| `body/` | The main UI layout — renders BLoC states, composes widgets, handles user interactions |
| `controller/` | Dart classes (not widgets) for text editing controllers, form validation state, remember-me toggles, button state |
| `item/` | Feature-specific list/grid item widgets (e.g., `onboarding_item.dart`, `message_item.dart`, `item_menu.dart`) |

**Auth screens:**

| Screen | Controllers | BLoC |
|--------|-------------|------|
| `splash/` | RefreshTokenController, RemoteConfigController | RefreshToken, RemoteConfig |
| `onboarding/` | OnboardingBodyController | Onboarding |
| `login/` | FormLoginController, ButtonLoginController, RememberController | Login |
| `sign_up/` | FormSignUpController, ButtonSignUpController | SignUp |
| `change_password/` | ChangePasswordController | ChangePassword |

**Main app screens:**

| Screen | Controllers | BLoC |
|--------|-------------|------|
| `main/` (shell) | — | — |
| `home/` | HomeFcmController, HomeProfileController | Fcm, AuthToken, Profile |
| `my_career/` | MyCareerBodyController | — |
| `chat/` | ChatController | Chat (streaming) |
| `profile/` | ProfileController, LogoutController | Profile, Logout |
| `update_profile/` | UpdateProfileController | UpdateProfile |
| `theme/` | ThemeController, LanguageController | Provider (notifier) |

**Other screens:**
- `ai_chat/` — AI chat page (Google AI)
- `button/` — UI component showcase
- `not_found/` — 404 error page

### `utils/` — Services & Helpers

| File | Purpose |
|------|---------|
| `helpers.dart` | Navigation key, logging, status bar config, currency/date formatting, email/phone/password validation, toast messages, platform detection, string/list extensions |
| `responsive_configuration.dart` | `pxToSp()` with interpolated exponent tables for mobile and tablet |
| `compress_image.dart` | Image compression wrapper using `flutter_image_compress` |
| `firebase_analytics_event.dart` | Firebase Analytics event logging helpers |
| `services/api/dio_factory.dart` | `DioFactory.create()` — SSL bypass, JSON headers, 30s timeouts, PrettyDioLogger |
| `services/api/rest_api_service.dart` | `Client` factory — 3 cached Dio flavors: `init()`, `initWithToken()`, `initWithRefreshToken()` |
| `services/api/auth_interceptor.dart` | QueuedInterceptor — automatic 401 handling with 3-tier token recovery |
| `services/api/token_manager.dart` | TokenManager — device auth, refresh, secure storage |
| `services/notification/notification_service.dart` | Singleton: FCM + local notifications, foreground/background, deeplink extraction |
| `services/remote_config/remote_config_service.dart` | Firebase Remote Config: fetch/activate, force/recommend update checks |
| `services/storage/local_storage_service.dart` | SharedPreferences wrapper: profile, login, theme, language, etc. |
| `services/storage/secure_storage_service.dart` | FlutterSecureStorage singleton: API/refresh/FCM tokens, device ID, credentials |

### `widgets/` — Shared Widget Library

| Category | Widgets | Count |
|----------|---------|-------|
| **Buttons** | EdgeButton × S/M/L/Icon, EdgeBorderButton × S/M/L/Icon, OvalButton × S/M/L, OvalBorderButton × S/M/L | **14** |
| **Dialogs** | success, error, delete, confirmation, exit app, connection internet, remote config | **7** |
| **Text Fields** | default, icon border, password (with visibility toggle) | **3** |
| **Images** | image_extended (network/cached), image_preview (pinch-zoom), image_profile_extended | **3** |
| **Shimmers** | circle, corner, rounded rectangle | **3** |
| **Structural** | default_appbar, fill_space, separator, safe_area_top, safe_area_bottom, loading (Lottie), menu_chevron, app_smart_refresher_parts | **8** |

---

## Route Structure

Route path constants are defined in `config/routes/routes.dart`. The GoRouter graph is built in `config/routes/go_route_generator.dart` with custom animated transitions via `buildAnimatedPage()`.

| Path | Screen | Transition |
|------|--------|------------|
| `/` | Splash | Fade (600ms) |
| `/on-boarding` | Onboarding | Fade (600ms) |
| `/login` | Login | Fade (600ms) |
| `/sign-up` | SignUp | Slide Right (600ms) |
| `/main` | Main (shell) | Fade (600ms) |
| `/theme` | Theme | Slide Right (600ms) |
| `/change-password` | ChangePassword | Slide Right (600ms) |
| `/update-profile` | UpdateProfile | Slide Right (600ms) |
| `/button` | Button (showcase) | Slide Right (600ms) |
| `/my-career` | MyCareer | Fade (600ms) |
| `/ai-chat` | AiChat | Fade (600ms) |
| `/chat` | Chat (streaming) | Fade (600ms) |
| `/not-found` | NotFound | Fade (600ms) |
| `*` (error) | NotFound (fallback) | — |

Navigation helpers via `GoRouterExtension` on `BuildContext`:
- `context.goTo(path)` — push-replace
- `context.pushTo(path)` — push onto stack
- `context.popRoute()` — pop
- `context.replaceTo(path)` — replace current
