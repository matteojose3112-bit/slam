# SLAM

**Make your exit memorable.**

SLAM is a retro-inspired mobile soundboard built with **Dart + Flutter** for Android and iOS. Choose a sign-off sound inspired by the satisfying clunk of an old 1980s telephone handset being slammed down.

## The prototype

- Five selectable sound effects
- In-app preview and local playback
- Original prototype WAV sounds synthesized in Dart
- Dark retro-inspired interface with a bright lime accent
- Offline-first: no account or backend required

## Sound collection

| Sound | Character |
|---|---|
| The Handset Slam | Chunky retro receiver drop |
| Hard Disconnect | Crisp mechanical click |
| The Busy Signal | Classic two-tone telephone signal |
| Record Stop | Dramatic descending pitch |
| The Mic Drop | Deep cinematic impact |

## Important platform note

The current build is a working soundboard prototype. It does **not** automatically detect ordinary phone-call endings yet.

- **Android:** Call-state APIs exist, but a native Kotlin proof of concept must validate permissions, background behavior, and post-call playback.
- **iOS:** CallKit is designed for calls managed by the app, not as a general-purpose observer for calls made through the system Phone app. A manual playback path is the baseline for ordinary calls.

SLAM plays sounds locally after the call. It does not record calls or inject sounds into live conversations.

See [Call-end integration research](docs/CALL_INTEGRATION.md) for the technical assessment.

## Technology

| Area | Choice |
|---|---|
| Language / framework | Dart + Flutter |
| UI | Material 3 |
| Audio playback | audioplayers |
| Temporary storage | path_provider |
| Prototype sound generation | Dart PCM/WAV synthesis |
| Architecture | Feature-first, platform integrations isolated |
| Backend | None; offline-first |
| Tests | Flutter widget and unit tests |
| CI | GitHub Actions |

## Getting started

Requires the Flutter SDK and a configured Android or iOS development environment.

    flutter pub get
    flutter analyze
    flutter test
    flutter run

Generate platform runner folders with:

    flutter create . --platforms=android,ios

## Repository structure

    .
    ├── lib/
    │   └── main.dart
    ├── test/
    │   └── widget_test.dart
    ├── docs/
    │   ├── PRODUCT_BRIEF.md
    │   ├── ARCHITECTURE.md
    │   └── CALL_INTEGRATION.md
    ├── .github/workflows/flutter-ci.yml
    ├── pubspec.yaml
    ├── CHANGELOG.md
    └── ROADMAP.md

## Project principles

1. Keep the soundboard useful offline.
2. Make playback user-controlled and easy to disable.
3. Avoid collecting call data or contacts.
4. Never claim automatic call-end behavior until verified on real devices.
5. Keep the README, roadmap, and changelog current.

## Project documents

- [Product brief](docs/PRODUCT_BRIEF.md)
- [Architecture decisions](docs/ARCHITECTURE.md)
- [Call-end integration research](docs/CALL_INTEGRATION.md)
- [Roadmap](ROADMAP.md)
- [Changelog](CHANGELOG.md)
