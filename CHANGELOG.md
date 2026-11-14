# Changelog

All notable project changes are recorded here.

## [Unreleased]

### Added
- Established SLAM as a dedicated Dart and Flutter cross-platform mobile project.
- Added a dark retro-inspired call sign-off soundboard with five selectable effects.
- Added locally synthesized WAV previews for a handset slam, mechanical disconnect, busy signal, record stop, and cinematic impact.
- Added local audio playback with audioplayers and temporary-file handling with path_provider.
- Added widget tests for the soundboard, selection behavior, and call-integration notice.\n- Extracted WAV synthesis into a dedicated `SoundWaveGenerator` service.\n- Added unit tests for WAV headers, PCM format metadata, and all five preset durations.
- Documented the product brief and Android/iOS call-end integration constraints.

### Changed
- Replaced the generic foundation screen with the first SLAM product prototype.
- Reworked the roadmap around soundboard MVP, device validation, and platform-specific call integration.\n- Corrected the selection widget test to account for the selected card scrolling off-screen.\n- Aligned mechanical-click and record-stop generated durations with their displayed preset durations.

### Technical notes
- Automatic ordinary cellular call-end playback is not implemented.
- iOS CallKit is intended for calls managed by the app; Android call-state observation requires a separate native feasibility and permission review.
