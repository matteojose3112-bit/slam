# Changelog

All notable project changes are recorded here.

## [Unreleased]

### Added
- Translated the stakeholder's PHONE SLAM concept into the Flutter application.
- Added four phone styles: classic rotary, payphone, 90s office phone, and cordless.
- Added home, dialer, and simulated active-call screens.
- Added the large red SLAM action and supplied recording offsets/durations.
- Added a low-volume free-tier default and a Pro high-volume gate concept.
- Added widget tests for sound choices, screen navigation, and the Pro gate.

### Changed
- Replaced the first synthetic soundboard UI with the stakeholder's three-screen experience.
- Replaced generated WAV playback with remote recorded-audio playback through audioplayers.
- Removed the superseded Dart sound generator, its tests, and the unused path_provider dependency.
- Added explicit copy that the call flow is a simulation and does not place calls.
- Kept the Pro gate honest: real in-app purchases and entitlements are not connected.

### Technical notes
- Audio URLs were reconstructed from pasted source code and require confirmation; filenames were line-break corrupted.
- Remote audio currently requires network access; local asset bundling/caching remains future work.
- Automatic ordinary cellular call-end playback is not implemented.
