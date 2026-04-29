# starter_lib

Reusable Flutter boilerplate package for quickly starting new apps.

## What is included

- App bootstrap and dependency initialization
- GetX routing setup
- Light theme setup
- Reusable app color tokens
- Reusable `AppScaffold` + safe-area app bar structure
- Reusable primary/secondary buttons
- Reusable bottom-sheet helpers
- Reusable bottom tab bar + sample app shell
- Reusable local storage service (`SharedPreferences`)
- Reusable network service (`Dio`)
- Sample `Splash` and `Home` feature modules
- Configurable startup options for routes/theme/localization/transitions
- Reusable UI kit widgets for inputs/cards/loading/empty/error states

## Folder structure

```text
lib/
  starter_lib.dart
  example_main.dart
  src/
    app/
    bootstrap/
    core/
    features/
    routes/
    services/
    theme/
```

## Quick usage in a new app

1. Copy this `starter_lib` folder into your new Flutter project root.
2. Add dependency in the new app's `pubspec.yaml`:

```yaml
dependencies:
  starter_lib:
    path: ./starter_lib
```

3. Use this in your `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:starter_lib/starter_lib.dart';

Future<void> main() async {
  await AppBootstrap.initialize(
    baseUrl: 'https://api.example.com',
    defaultHeaders: <String, String>{'x-app': 'my-app'},
  );

  runApp(
    AppBootstrap.app(
      title: 'My New App',
      themeMode: ThemeMode.system,
      supportedLocales: const <Locale>[Locale('en'), Locale('hi')],
    ),
  );
}
```

4. Run:

```bash
flutter pub get
flutter run
```

## New configuration options

`AppBootstrap.initialize(...)`
- `baseUrl`: optional; skip if app has no backend.
- `setupLocalStorage`: toggle SharedPreferences initialization.
- `networkInterceptors`: inject Dio interceptors (auth/logging/retry).
- `connectTimeout` / `receiveTimeout` / `sendTimeout`.
- `defaultHeaders`.
- `networkService`: inject your own prebuilt `NetworkService`.
- `onInitialized`: run custom setup logic after bootstrapping.

`AppBootstrap.app(...)`
- `theme`, `darkTheme`, `themeMode`.
- `fontPreset` (Inter/Poppins/Montserrat/Lato/Nunito/DM Sans/Work Sans/Rubik).
- `customGoogleFontFamily` (any Google Font family name).
- `locale`, `fallbackLocale`, `supportedLocales`, `translations`.
- `getPages`, `unknownRoute`, `initialRoute`.
- `defaultTransition`, `transitionDuration`.
- `navigatorObservers`.
- `debugShowCheckedModeBanner`.

`LocalStorageService`
- Supports `String`, `bool`, `int`, `double`, `List<String>`.
- Includes `containsKey`, `remove`, and `clear`.

## UI starter options

Ready-to-use widgets:
- `AppSearchBar`: reusable search with clear button + debounced callback.
- `PaginatedListView<T>`: loading/empty/error/retry/load-more list wrapper.
- `AppDateTimePickerField`: reusable date/time/date-range form field.
  - Supports `pickerStyle: AppDateTimePickerStyle.cupertinoBottomSheet` for iOS-style sheet picker.
- `DynamicInputField`: config-driven input rendering (text/email/phone/number/password/multiline).
- `DynamicDropdownField<T>`: config-driven dropdown rendering with validation.
- `DynamicStepBar`: reusable multi-step progress indicator.
- `AppTextField`: consistent form input style with icons/validation.
- `AppSectionCard`: section container for dashboard/form blocks.
- `AppListTile`: reusable settings/profile list tile with destructive mode.
- `AppLoadingState`: centered loading message + spinner.
- `AppEmptyState`: first-time/empty-list screen block.
- `AppErrorState`: error with optional retry action.
- `AppPrimaryButton` / `AppSecondaryButton`: now customizable colors/radius.
- `AppFloatingActionButton`: reusable standard/extended FAB.
- `AppScaffold`: optional `padding`, `maxContentWidth`, `scrollable`, and `bottomSheet`.
- `AppBottomSheets.showConfirmation(...)`: reusable confirmation sheet for destructive actions (e.g., logout).

Image cache helpers:
- `AppImageCacheService.precacheNetworkImage(...)`
- `AppImageCacheService.precacheNetworkImages(...)`
- `AppImageCacheService.precacheAssetImage(...)`
- `AppImageCacheService.precacheAssetImages(...)`
- `AppImageCacheService.configureImageCache(...)`
- `AppImageCacheService.evictNetworkImage(...)` / `evictAssetImage(...)`
- `AppImageCacheService.clearAll()`

Theming defaults:
- Material 3 light + dark themes included.
- Input, button, and card themes are configured globally.
