# SLAM

**Touchscreens are too polite. End the call right.**

SLAM is a retro-inspired entertainment app prototype built around the theatrical sound of hanging up an old telephone. Its appeal is humor, nostalgia, expressive timing, and shareable short-form content—not call management or productivity.

## Current prototype

- Four phone styles: classic rotary, payphone, 90s office phone, and cordless
- Three-screen flow: home soundboard → dialer → simulated active call
- Large red SLAM action to play the selected recording
- Home-screen preview controls for each sound
- Low volume is the default; high volume is a Pro concept only
- Remote audio playback with selected clip offsets
- Clear disclosure that the dialer is a simulation and does not place calls

## Product direction

The three initial creative territories are:

1. **Corporate burnout:** deadpan workplace humor and meeting fatigue.
2. **Gaming / internet rage quit:** exaggerated reactions to familiar gaming and group-chat frustrations.
3. **Vintage-tech nostalgia:** tactile sound, retro-inspired UI, and mechanical audio payoff.

The preferred hero line is **“Touchscreens are too polite. End the call right.”**

See [docs/PRODUCT_STRATEGY.md](docs/PRODUCT_STRATEGY.md) for audience profiles, short-form video concepts, taglines, creator briefs, product ideas, platform evaluation, monetization hypotheses, measurement, and developer interview questions.

## Sound collection

| Phone style | Recording |
|---|---|
| Classic rotary | Rotary pick-up / hang-up recording, starting at 3 seconds |
| Payphone | Payphone handset slam recording |
| 90s office phone | Shared recording, 22-second offset, 2.5-second clip |
| Cordless phone | Shared recording, 7-second offset, 2-second clip |

The URLs were reconstructed from the stakeholder's pasted code, whose filenames were partially corrupted by line breaks. They need confirmation against the original source. Recordings are remote and playback currently requires network access.

## Platform status and strategy

The current repository is a **Flutter** prototype. A low-friction **PWA** may be a better acquisition surface for creator link-in-bio traffic, but that is not yet a platform decision. The recommended next experiment is a narrow browser prototype that tests one-tap playback on iOS Safari and Android Chrome before considering a rewrite or parallel web client.

Mobile browsers restrict autoplay. Audio must be initialized in response to a user gesture, and reliable low-latency playback needs preloading, caching, and real-device testing.

The current flow is a **simulation**. It does not place or control real phone calls and does not automatically detect ordinary cellular call endings.

- **Android:** Call-state APIs require a separate native Kotlin proof of concept and permission review.
- **iOS:** CallKit is not a general-purpose observer for ordinary calls made through Apple's Phone app. A user-triggered flow remains the baseline.

SLAM must play locally on the user's device, never inject sound into the other person's call audio, and never record calls.

## Monetization prototype

The free-tier / Pro distinction is UI-only. High volume displays an explanatory gate, but no real purchase, subscription, restore-purchase, or entitlement implementation exists. The example $2.99 price from the source code is a hypothesis, not an active offer.

Potential future paid value to validate includes licensed sound packs, custom presets, and creator-oriented skit templates. Do not implement billing until willingness to pay and the entitlement model are validated.

## Technology

| Area | Choice |
|---|---|
| Language / framework | Dart + Flutter |
| UI | Material 3 |
| Audio playback | audioplayers |
| Audio source | Remote WAV recordings supplied in the stakeholder prototype |
| State | Local widget state |
| Backend | None |
| Tests | Flutter widget tests |
| CI | GitHub Actions |

## Getting started

    flutter pub get
    flutter analyze
    flutter test
    flutter run

## Repository structure

    .
    ├── lib/main.dart
    ├── test/widget_test.dart
    ├── docs/
    │   ├── PRODUCT_BRIEF.md
    │   ├── PRODUCT_STRATEGY.md
    │   ├── ARCHITECTURE.md
    │   └── CALL_INTEGRATION.md
    ├── .github/workflows/flutter-ci.yml
    ├── pubspec.yaml
    ├── CHANGELOG.md
    └── ROADMAP.md

## Project principles

1. Keep the core interaction immediate, playful, and user-controlled.
2. Use only recordings with confirmed distribution and commercial-use rights.
3. Keep playback volume conservative by default.
4. Be explicit about simulated calls and platform limitations.
5. Do not claim purchases or automatic call-end behavior before implementation and verification.
6. Keep the README, roadmap, and changelog current.


## Documentation maintenance — 2026-11-27

SLAM remains a Flutter concept prototype, not a released call-management product. The dialer is simulated and does not place or observe ordinary cellular calls. Remote audio URLs were reconstructed from damaged pasted source and still require confirmation; distribution and commercial-use rights must be documented before release. The Pro gate is UI-only—no billing or entitlement system exists. A PWA remains an experiment, not an approved platform rewrite.
