# SLAM — Architecture

## Guiding approach

Build the shared soundboard in Flutter and keep platform-specific call integration isolated. Do not add native telephony permissions or background services until a platform proof of concept establishes feasibility and user value.

## Initial stack

| Concern | Choice | Adoption rule |
|---|---|---|
| Language | Dart | Project default |
| UI framework | Flutter / Material 3 | Shared Android/iOS UI |
| Audio playback | audioplayers | Local short sound effects |
| Temporary audio files | path_provider | Store generated WAV previews in app temp storage |
| Sound generation | Dart PCM/WAV synthesis | Prototype-only original tones and effects |
| State | Local widget state initially | Add Riverpod when preferences or state become shared |
| Routing | No router yet | Add GoRouter when multiple screens/routes are needed |
| Backend | None | Sound library and preferences should work offline |
| Tests | flutter_test | Widget coverage plus pure Dart sound-generation tests |
| CI | GitHub Actions | Format, analyze, test |

## Current runtime flow

1. User selects one of the built-in sound presets.
2. SLAM synthesizes a short mono PCM WAV in Dart.
3. The WAV is written to the app's temporary directory.
4. audioplayers plays the local file on the device.
5. The temporary file may be regenerated when the user previews that preset.

This avoids remote audio dependencies and keeps prototype sound playback offline.

## Platform integration boundary

Any future automatic call-end behavior must sit behind a platform interface:

- CallEndTrigger exposes supported capability and lifecycle events.
- Android implementation: native Kotlin proof of concept using supported telephony APIs and explicit permission.
- iOS implementation: manual user-triggered flow for ordinary cellular calls; CallKit only if SLAM later owns a VoIP calling experience.

The shared Flutter UI must never assume automatic call-end detection is available on every platform.

## Architecture decisions

### ADR-001 — Flutter and Dart
**Accepted.** Use Flutter with Dart for a shared Android/iOS application.

### ADR-002 — Feature-first structure
**Accepted as direction.** Organize code around product capabilities. Extract modules as the product grows.

### ADR-003 — Offline-first soundboard
**Accepted.** The sound library and playback should work without accounts, remote services, or network access.

### ADR-004 — No automatic call detection in the initial prototype
**Accepted.** Android and iOS have different telephony capabilities. Validate each platform separately before requesting sensitive permissions or promising automatic behavior.

### ADR-005 — Original prototype sounds
**Accepted.** Generate initial sound effects in Dart for rapid iteration. Replace or supplement these with original/licensed production audio after sound direction is approved.

## Quality gates

- dart format produces no changes.
- flutter analyze has no unresolved issues.
- flutter test passes.
- Sound playback is user-triggered and handles interruptions/errors.
- Sensitive call data is not collected.
- Android and iOS platform behavior is tested separately before release.
