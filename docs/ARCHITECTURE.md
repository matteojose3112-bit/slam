# SLAM — Architecture

## Guiding approach

Start with a small, understandable Flutter application and evolve toward feature-first modularity as product requirements become clear. Avoid introducing abstractions or packages without a concrete need.

## Initial stack

| Concern | Choice | Adoption rule |
|---|---|---|
| Language | Dart | Project default |
| UI framework | Flutter / Material 3 | Project default; customize visual identity after product discovery |
| State | Riverpod | Add when real shared or asynchronous state appears |
| Routing | GoRouter | Add when the app needs multiple named routes or deep links |
| Backend | Undecided | Select only after data, auth, sync, and hosting needs are known |
| Tests | flutter_test | Widget tests from the beginning; add unit/integration coverage with features |
| CI | GitHub Actions | Run format, analyze, and test checks |

## Proposed source layout

```
lib/
  app/
    app.dart
    router/
  core/
    theme/
    errors/
    utils/
  features/
    <feature_name>/
      data/
      domain/
      presentation/
  main.dart
test/
  features/
```

This is a target layout, not a requirement to create empty folders now. Each feature should own its presentation and data behavior; shared code belongs in core only when reuse is real.

## Architecture decisions

### ADR-001 — Flutter and Dart

**Status:** Accepted

Use Flutter with Dart to target Android and iOS from a shared application codebase. This avoids maintaining two independent native implementations for the first release.

### ADR-002 — Feature-first structure

**Status:** Accepted as direction

Organize code around product capabilities rather than technical layers alone. Introduce feature folders when the first real feature is known.

### ADR-003 — Delay backend selection

**Status:** Accepted

Do not assume Supabase or another backend before understanding whether the app needs accounts, remote storage, synchronization, or server-side logic.

### ADR-004 — Add dependencies just in time

**Status:** Accepted

Riverpod and GoRouter are preferred candidates, but they should enter the dependency graph when the application has a concrete need for them.

## Quality gates

Before a change is considered ready:

- `dart format` produces no changes.
- `flutter analyze` has no unresolved issues.
- `flutter test` passes.
- User-facing states include appropriate loading, empty, and error handling.
- Sensitive data is minimized and never committed to source control.
- Platform-specific behavior is checked on both Android and iOS when applicable.
