# Introduction

**Blueprint Mobile Flutter** is a production-grade Flutter mobile starter kit built by **Mikhael Suryawan Putra**. It provides a complete, battle-tested foundation for building handheld / employee-facing mobile applications with modern architecture, security patterns, and developer experience baked in.

---

## What is Blueprint Mobile?

A ready-made starting point for any Flutter mobile project that needs:

- **Authentication** — login, sign-up, onboarding, change password, token management with automatic 401 recovery
- **Navigation** — animated GoRouter with 14 routes, deep linking support
- **State Management** — BLoC for feature logic + Provider for theme/language
- **Networking** — Dio stack with AuthInterceptor (3-tier token recovery), TokenManager, flavor-based config
- **Firebase Suite** — FCM push notifications, Analytics, Remote Config, Crashlytics
- **AI Integration** — streaming chat via OpenRouter API, Google AI (Gemini) support
- **Localization** — English & Indonesian (ARB-driven codegen)
- **Theming** — light/dark mode with 317-color palette + Google Fonts Inter
- **Storage** — SharedPreferences + FlutterSecureStorage + SQLite
- **UI Components** — 30+ reusable shared widgets (buttons, dialogs, text fields, shimmers, images)

---

## Tech Stack Overview

| Area | Choice |
|------|--------|
| **Framework** | Flutter 3.x / Dart 3.x |
| **State Management** | `flutter_bloc` (business logic) + `provider` (app-level notifiers) |
| **Routing** | `go_router` with custom animated transitions |
| **HTTP Client** | `dio` + `pretty_dio_logger` + queued interceptor |
| **AI** | `googleai_dart` (Gemini) + OpenRouter REST API |
| **Firebase** | Core, Messaging, Analytics, Remote Config, Crashlytics |
| **Local Storage** | `shared_preferences` + `flutter_secure_storage` + `sqflite` |
| **Localization** | ARB files → `flutter gen-l10n` (EN/ID) |
| **Theming** | Material 3–oriented, custom `AppColors` palette, Inter font |
| **Responsive** | `sizer` + custom `pxToSp()` utility |
| **Testing** | `flutter_test` + `bloc_test` + `mocktail` |
| **Linting** | `flutter_lints` |

---

## Architecture Overview

```
┌──────────────────────────────────────────────────────────┐
│                    SCREENS (lib/screens/)                │
│  screen/ → body/ → controller/ → item/                  │
│  Thin screen injects BLoC providers → body renders UI   │
└────────────────────────────────┬─────────────────────────┘
                                 │ BlocProvider
┌────────────────────────────────▼─────────────────────────┐
│                CORE (lib/core/{feature}/)                │
│  bloc/ (Events → BLoC → States)                         │
│  repository/ (data access layer)                        │
│  model/request/ + model/response/ (DTOs)                │
└────────────────────────────────┬─────────────────────────┘
                                 │ uses
┌────────────────────────────────▼─────────────────────────┐
│              SERVICES (lib/utils/services/)              │
│  api/ (Client, DioFactory, AuthInterceptor, TokenManager)│
│  storage/ (LocalStorageService, SecureStorageService)    │
│  notification/ (NotificationService)                    │
│  remote_config/ (RemoteConfigService)                   │
└──────────────────────────────────────────────────────────┘
```

**Data flow:**
1. User action → **Screen Controller** (text controllers, form validation)
2. Screen → **BLoC event** via `context.read<SomeBloc>().add(Event())`
3. BLoC → **Repository** (API call via `Client.initWithToken()`)
4. Repository → **Dio** (via cached Client singletons)
5. AuthInterceptor on 401 → **TokenManager** (refresh or device auth)
6. Response → Repository parses DTO → BLoC emits state → UI rebuilds

---

## Key Design Decisions

**Dual state management:** BLoC for complex feature state (login, profile, chat, FCM, etc.) + Provider for simple app-level toggles (theme mode, locale). This avoids over-engineering simple state while keeping business logic testable and reactive.

**No Clean Architecture folders:** The project intentionally avoids `features/`, `domain/`, `data/`, `presentation/` layers. Instead, it uses `core/` for business logic and `screens/` for UI — a simpler convention that works well for small-to-medium teams.

**3-tier API stack:** `DioFactory` creates configured Dio instances → `Client` caches 3 flavors (plain, with-auth, with-refresh) → `AuthInterceptor` handles 401 recovery automatically with queued retry logic.

**GoRouter with animated pages:** All routes use custom fade/slide transitions via `buildAnimatedPage()`, giving a polished feel without extra navigation packages.

---

## Related Documents

| Document | Content |
|----------|---------|
| `1_installation.md` | Flutter + project setup guide |
| `2_setup_project.md` | How to rename, rebrand, and customize the blueprint |
| `3_structure.md` | Detailed folder structure reference |
| `4_styling.md` | Theming, colors, typography, and design system |
