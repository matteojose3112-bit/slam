# SLAM

**Choose your weapon. End the call right.**

SLAM is a retro-inspired Flutter mobile app prototype built around the theatrical sound of hanging up an old telephone.

## Current prototype

- Four phone styles: classic rotary, payphone, 90s office phone, and cordless
- Three-screen flow: home soundboard → dialer → simulated active call
- Large red SLAM action to play the selected recording
- Low volume is the free-tier default; high volume is a Pro feature concept
- Remote audio playback with selected clip offsets
- Clear disclosure that the dialer is a simulation and does not place calls

## Sound collection

| Phone style | Recording |
|---|---|
| Classic rotary | Rotary pick-up / hang-up recording, starting at 3 seconds |
| Payphone | Payphone handset slam recording |
| 90s office phone | Shared recording, 22-second offset, 2.5-second clip |
| Cordless phone | Shared recording, 7-second offset, 2-second clip |

The URLs were reconstructed from the stakeholder's pasted code, whose filenames were partially corrupted by line breaks. They need confirmation against the original source. Recordings are remote and playback currently requires network access.

## Important platform note

The current flow is a **simulation**. It does not place or control real phone calls and does not automatically detect ordinary cellular call endings.

- **Android:** Call-state APIs require a separate native Kotlin proof of concept and permission review.
- **iOS:** CallKit is not a general-purpose observer for ordinary calls made through Apple's Phone app. A user-triggered flow remains the baseline.

SLAM must play locally on the user's device, never inject sound into the other person's call audio, and never record calls.

## Monetization prototype

The free-tier / Pro distinction is UI-only. High volume displays an explanatory gate, but no real purchase, subscription, restore-purchase, or entitlement implementation exists. The example $2.99 price from the source code is not an active offer.

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
    │   ├── ARCHITECTURE.md
    │   └── CALL_INTEGRATION.md
    ├── .github/workflows/flutter-ci.yml
    ├── pubspec.yaml
    ├── CHANGELOG.md
    └── ROADMAP.md

## Project principles

1. Use the stakeholder's intended recorded sounds rather than the retired synthetic prototype.
2. Keep playback user-controlled and volume conservative by default.
3. Be explicit about simulated calls and platform limitations.
4. Do not claim purchases or automatic call-end behavior before implementation and verification.
5. Keep the README, roadmap, and changelog current.
