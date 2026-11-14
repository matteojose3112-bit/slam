# SLAM — Architecture

## Guiding approach

Use Flutter for the shared Android/iOS UI. Keep the sound catalog and playback behavior simple until the supplied recordings and product flow are validated. Platform-specific call integration remains isolated and out of scope for the current prototype.

## Current stack

| Concern | Choice | Notes |
|---|---|---|
| Language | Dart | Project default |
| UI framework | Flutter / Material 3 | Shared Android/iOS UI |
| Audio playback | audioplayers | Plays supplied remote WAV recordings |
| Audio catalog | SlamSound constants in main.dart | Sound IDs, URL keys, offsets, and clip lengths |
| State | Local widget state | Current three-screen prototype |
| Routing | AnimatedSwitcher screen state | Home, dialer, simulated call |
| Backend | None | No account or server |
| Tests | flutter_test | UI flow and free-tier gate |
| CI | GitHub Actions | Format, analyze, test |

## Audio playback flow

1. User selects one of the four phone styles.
2. The selected sound resolves to a remote recording URL.
3. audioplayers loads the URL and starts at the configured offset.
4. Office and cordless sounds stop after their configured clip duration.
5. The player reports completion or an error to the UI.

The supplied recording URLs were reconstructed from pasted source code and must be verified. Remote playback currently requires connectivity. A future release should bundle properly licensed recordings or implement a resilient download cache.

## Screen flow

- **Home:** phone style selection, preview, volume tier, and dialer entry.
- **Dialer:** display-name input and simulated-call start.
- **Call:** simulated active-call state and large red SLAM action.

The UI explicitly states that no real phone call is placed.

## Monetization boundary

The current free/Pro treatment is a visual concept only. The high-volume gate explains that purchases are not connected. Do not add fake purchase success or local-only Pro entitlement state. Real store billing requires a separately approved design and store integration.

## Platform integration boundary

Future call-end behavior must be implemented behind a platform capability boundary:

- Android: native Kotlin feasibility work with explicit permission and device validation.
- iOS: user-triggered sign-off for ordinary system Phone calls; CallKit only if SLAM later owns a VoIP calling experience.

The shared Flutter UI must not assume automatic call-end detection is available on every platform.

## Architecture decisions

### ADR-001 — Flutter and Dart
**Accepted.** Use Flutter with Dart for a shared Android/iOS application.

### ADR-002 — Simulated call flow first
**Accepted.** Validate the product interaction without implying that the app places or observes real calls.

### ADR-003 — Recorded source sounds
**Accepted provisionally.** Use the four sound styles and remote audio approach supplied by the stakeholder. Confirm URLs, source ownership, and licensing before release.

### ADR-004 — Conservative volume and honest Pro gate
**Accepted provisionally.** Low volume is the default. High volume is a monetization concept only until store billing is implemented.

## Quality gates

- dart format produces no changes.
- flutter analyze has no unresolved issues.
- flutter test passes.
- Remote audio errors are visible and recoverable.
- Audio assets are licensed before distribution.
- Android and iOS call behavior is tested separately before release.
