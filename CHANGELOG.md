# Changelog

## Documentation maintenance — 2026-11-27

- Reaffirmed that SLAM is a Flutter prototype and the call flow is a simulation, not real call control.
- Kept audio URL confirmation, recording rights, physical-device playback, current CI verification, PWA validation, and real billing as outstanding work.
- No application code, platform permissions, billing, or release configuration changed.

All notable project changes are recorded here.

## [Unreleased]

### Added
- Translated the stakeholder's PHONE SLAM concept into the Flutter application.
- Added four phone styles: classic rotary, payphone, 90s office phone, and cordless.
- Added home, dialer, and simulated active-call screens.
- Added the large red SLAM action and supplied recording offsets/durations.
- Added home-screen sound preview controls.
- Added a low-volume default and a Pro high-volume gate concept.
- Added widget tests for sound choices, screen navigation, and the Pro gate.
- Added docs/PRODUCT_STRATEGY.md covering positioning, audiences, campaign hooks, short-form video scripts, taglines, creator experience ideas, platform strategy, monetization hypotheses, measurement, and developer interview questions.

### Changed
- Replaced the first synthetic soundboard UI with the stakeholder's three-screen experience.
- Replaced generated WAV playback with remote recorded-audio playback through audioplayers.
- Removed the superseded Dart sound generator, its tests, and the unused path_provider dependency.
- Added explicit copy that the call flow is a simulation and does not place calls.
- Kept the Pro gate honest: real in-app purchases and entitlements are not connected.
- Expanded README and roadmap to include creator-led validation and a PWA experiment without prematurely committing to a platform rewrite.

### Fixed
- Repaired malformed volume-label string interpolation.
- Added the TextField import to the widget test and migrated both app and test to the standalone `material_ui` package after CI exposed Flutter 3.50 Material API deprecation.
- Made the Pro preview flag immutable.

### Technical notes
- Audio URLs were reconstructed from pasted source code and require confirmation; filenames were line-break corrupted.
- Remote audio currently requires network access; local asset bundling/caching remains future work.
- Automatic ordinary cellular call-end playback is not implemented.
- The previous CI runs exposed a missing TextField test import and then Flutter 3.50 Material import deprecations; both were addressed and the latest source commit has a new CI run pending.
- See docs/REPOSITORY_ASSESSMENT.md for the current technical and release-readiness assessment.
