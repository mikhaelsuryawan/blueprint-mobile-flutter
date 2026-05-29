# Installation

This guide covers how to install **Flutter** on your machine and set up the **Blueprint Mobile Flutter** project for development.

---

## Prerequisites

| Tool | Minimum Version | Notes |
|------|----------------|-------|
| **Flutter** | Stable (3.x+) | Tested on Flutter 3.41.x / Dart 3.11.x |
| **Dart SDK** | >=2.17.0 <4.0.0 | Bundled with Flutter |
| **Android SDK** | 36 (compileSdk) | Part of Android Studio |
| **Java** | 17 | Required for Android builds |
| **Kotlin** | JVM target 17 | Configured in Gradle |
| **Xcode** | Latest stable | macOS only, required for iOS builds |
| **iOS Deployment Target** | 15.0 | Minimum iOS version |

---

## Step 1: Install Flutter

Choose your operating system and follow the official Flutter installation guide:

| OS | Installation Guide |
|----|-------------------|
| **macOS** | https://docs.flutter.dev/get-started/install/macos |
| **Windows** | https://docs.flutter.dev/get-started/install/windows |
| **Linux** | https://docs.flutter.dev/get-started/install/linux |
| **Chrome OS** | https://docs.flutter.dev/get-started/install/chromeos |

After installation, verify everything is working:

```bash
flutter doctor
```

This checks for all required dependencies and platforms. Address any issues marked with ❌ before proceeding.

---

## Step 2: Clone the Repository

```bash
git clone <repository-url> blueprint-mobile-flutter
cd blueprint-mobile-flutter
```

> If you plan to customize this for your own project, see `2_setup_project.md` for renaming and rebranding instructions.

---

## Step 3: Install Dependencies

```bash
flutter pub get
```

This fetches all 56+ packages listed in `pubspec.yaml`.

---

## Step 4: Configure Environment Variables

Create a `.env` file in the project root:

```bash
touch .env
```

At minimum, you need variables for your API connection. The full list (from `lib/constants/app_settings.dart`):

| Variable | Required | Purpose |
|----------|----------|---------|
| `APP_NAME_DEVELOPMENT` | Yes | Dev build app name |
| `APP_NAME_PRODUCTION` | Yes | Release build app name |
| `API_BASE_URL_DEVELOPMENT` | Yes | Dev REST API host |
| `API_BASE_URL_PRODUCTION` | Yes | Prod REST API host |
| `API_PORT_DEVELOPMENT` | If IS_USE_PORT_* is 1 | Dev API port |
| `API_PORT_PRODUCTION` | If IS_USE_PORT_* is 1 | Prod API port |
| `TRAFFIC_TYPE_DEVELOPMENT` | Recommended | Firebase Analytics traffic type |
| `TRAFFIC_TYPE_PRODUCTION` | Recommended | Firebase Analytics traffic type |
| `AUTH_APP_NAME_DEVELOPMENT` | Yes | Auth app identifier (dev) |
| `AUTH_APP_NAME_PRODUCTION` | Yes | Auth app identifier (prod) |
| `AUTH_APP_KEY_DEVELOPMENT` | Yes | Auth app key (dev) |
| `AUTH_APP_KEY_PRODUCTION` | Yes | Auth app key (prod) |
| `IS_USE_PORT_DEVELOPMENT` | Recommended | "1" to append port to URL |
| `IS_USE_PORT_PRODUCTION` | Recommended | "1" to append port to URL |
| `OPENROUTER_API_KEY` | For AI Chat | OpenRouter API key |
| `OPENROUTER_BASE_URL` | For AI Chat | OpenRouter base URL |

**Flavor selection** is automatic:
- **Development** settings apply when NOT in release mode (`kReleaseMode == false`)
- **Production** settings apply in release builds (`kReleaseMode == true`)

> ⚠️ **Never commit `.env` to version control.** It contains secrets. The file is already in `.gitignore`.

---

## Step 5: Configure Firebase

1. Go to **Firebase Console** → Create or select your project
2. Add an **Android app** (package name: `id.wit.blueprint_mobile_flutter`)
3. Download `google-services.json` → place in `android/app/`
4. Add an **iOS app** (bundle ID: `id.wit.blueprintMobileDart`)
5. Download `GoogleService-Info.plist` → place in `ios/Runner/` (use Xcode's Add Files)

> If you changed the package name, regenerate `lib/firebase_options.dart`:
> ```bash
> flutterfire configure --project=your-firebase-project-id
> ```

---

## Step 6: Run the App

### Development Mode

```bash
flutter run
```

This uses **Development** environment settings from `.env`.

### Release Mode (Production Flavor)

```bash
flutter run --release
```

Uses **Production** environment settings with full minification and optimization.

### Specific Device

```bash
flutter run -d <device-id>
# or
flutter devices  # list available devices
flutter emulators --launch <emulator-name>
```

---

## Step 7: Verify Setup

### Static Analysis

```bash
flutter analyze
```

Ensures no lint violations or type errors.

### Run Tests

```bash
flutter test
```

Runs unit and widget tests with `mocktail` and `bloc_test`.

### Format Code

```bash
dart format lib test
```

---

## Common Issues & Solutions

### "No Firebase App '[DEFAULT]'"

Make sure `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in the correct location. Run `flutter clean` and `flutter pub get` again.

### Build fails with "compileSdk 36 not found"

Update your Android SDK via Android Studio → SDK Manager, then:

```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get
```

### iOS build fails on CocoaPods

```bash
cd ios
pod deintegrate
pod install --repo-update
cd ..
flutter clean
flutter pub get
```

### API calls fail with SSL error

The `DioFactory` includes an SSL bypass for development flexibility (`badCertificateCallback`). For production, remove this or configure proper certificate pinning.

---

## Next Steps

| Guide | What It Covers |
|-------|---------------|
| `0_intro.md` | Project overview & architecture |
| `2_setup_project.md` | Customizing for your own app |
| `3_structure.md` | Full folder structure reference |
| `4_styling.md` | Theming, colors, typography |
