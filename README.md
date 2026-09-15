# Online Archive

A Flutter (Android-only) library management client, built with a feature-based clean architecture (`domain` / `data` / `presentation` per feature) and Riverpod for state management. The backend is a .NET Clean Architecture API (books, members, borrowings), but the app is **not connected to it yet** — data is read from local JSON files bundled with the app, through mocked repositories that mirror the real API contract, so a real backend repository can be swapped in later with minimal changes.

## Implemented

- Book search and book details
- Member home page with bottom navigation
- Borrowing history (per member)
- Returning a borrowed book, including empty-state handling

## Not yet implemented

- **Backend integration** — the app is not wired up to the real .NET API. All data currently comes from local JSON files, not a live server.
- **Auth / login & registration flow** — there is no login or registration screen yet. The member ID is currently **hardcoded** and passed directly to the providers instead of being resolved from an authenticated session.
- **Book borrowing** — creating a new borrowing (borrowing a book) is not implemented yet. Only returning an existing borrowing works today.
- **Profile editing** — there is no screen yet for a member to view/edit their own profile details or change their password.

## Commands

- Install dependencies: `flutter pub get`
- Run the app (device/emulator required): `flutter run`
- Run all tests: `flutter test`
- Run a single test file: `flutter test test/widget_test.dart`
- Static analysis / lint: `flutter analyze`
- Format code: `dart format .`

## Getting started with Flutter

A few resources if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
