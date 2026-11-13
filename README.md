# SLAM

**A cross-platform mobile app project built with Dart and Flutter.**

SLAM is the seventh project in this portfolio and the dedicated home for mobile application development. The goal is to build a thoughtful, polished product for **Android and iOS** from one shared Flutter codebase.

> **Product direction is intentionally open.** The first app will be shaped by real requirements and notes before we lock in features, data models, or backend decisions.

## Current status

- [x] Public repository established
- [x] Initial product and technical direction documented
- [x] Flutter starter app and first widget test added
- [ ] Confirm the product brief and primary user problem
- [ ] Generate the complete Flutter platform scaffold and run tests
- [ ] Build the first user-approved feature

## Technology

| Area | Initial choice |
|---|---|
| Language | Dart |
| Mobile framework | Flutter |
| UI | Material 3 via `material_ui`, responsive layouts |
| Architecture | Feature-first, modular |
| State management | Riverpod (introduce with first meaningful stateful feature) |
| Navigation | GoRouter (introduce when multiple routes are needed) |
| Backend | Undecided; evaluate Supabase only if the product needs it |
| Testing | Flutter widget and integration tests |
| CI | GitHub Actions |

Dependencies will be added when needed rather than front-loading the project with packages.

## Repository structure

```
.
├── lib/
│   └── main.dart
├── test/
│   └── widget_test.dart
├── docs/
│   ├── PRODUCT_BRIEF.md
│   └── ARCHITECTURE.md
├── .github/
│   └── workflows/
│       └── flutter-ci.yml
├── analysis_options.yaml
├── .gitignore
├── pubspec.yaml
├── CHANGELOG.md
└── ROADMAP.md
```

## Getting started

Requires the Flutter SDK and a configured Android or iOS development environment.

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Generate platform-specific runner folders with `flutter create . --platforms=android,ios` from the project root when the Flutter SDK is available.

## Project principles

1. **Solve the real problem.** Do not invent features before understanding the intended users.
2. **Mobile-first.** Design for touch, small screens, accessibility, and platform conventions.
3. **Build in deliberate increments.** Keep the app runnable and testable as it grows.
4. **Protect user data.** Make privacy, validation, and secure defaults part of design decisions.
5. **Document decisions.** Keep this README, the roadmap, and changelog current.

## Project documents

- [Product brief](docs/PRODUCT_BRIEF.md)
- [Architecture decisions](docs/ARCHITECTURE.md)
- [Roadmap](ROADMAP.md)
- [Changelog](CHANGELOG.md)

---

*SLAM is in its foundation phase. The product brief will become specific once the initial requirements are reviewed.*
