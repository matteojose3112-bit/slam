# SLAM — Product Brief

**Status:** Prototype / product discovery  
**Platforms:** Android and iOS  
**Implementation:** Dart + Flutter

## Product idea

SLAM makes ending a phone call feel theatrical. The concept centers on four recognizable telephone styles and a large red sign-off action that plays the corresponding handset recording.

**Core promise:** Choose your phone style, set your preferred volume, and end the simulated call with a satisfying slam.

## Experience

1. Open the home screen and choose one of four phone styles.
2. Preview a sound and choose low or Pro-gated high volume.
3. Open the in-app dialer and enter a display name.
4. Start a clearly labelled simulated call.
5. Press the large red SLAM button to play the selected sound.

The current prototype implements this simulated journey. It does not place a real phone call or automatically detect call endings.

## Sound collection

- **Classic rotary:** Recorded pick-up / hang-up effect, starting at 3 seconds.
- **Payphone:** Dedicated payphone handset slam recording.
- **90s office phone:** Shared recording, 22-second offset, 2.5-second segment.
- **Cordless phone:** Shared recording, 7-second offset, 2-second segment.

The asset URLs were reconstructed from the code pasted into the conversation. The filenames were split and partially corrupted by formatting, so all three URLs must be checked against the original source. Audio ownership and commercial-use rights must be confirmed before release.

## Volume and monetization concept

- Low volume is the default.
- High volume is presented as a Pro feature.
- The current Pro gate is a UI prototype only.
- No payment, subscription, restore purchase, or entitlement system exists.
- The example $2.99 price in the source code is not an approved or active price.

## Real call integration

The call screen is currently a simulation. Real call initiation and automatic call-end detection are separate product and platform decisions.

- **Android:** Native call-state APIs need a Kotlin proof of concept, explicit permission review, background lifecycle tests, and device testing.
- **iOS:** CallKit is designed for calls managed by the app, especially its own VoIP service. It is not a general-purpose observer for calls made in the system Phone app. A user-triggered sign-off remains the baseline.

SLAM must play sound locally for the user, never inject audio into the other participant's call audio, and never record calls.

## Prototype scope

### Implemented in the current branch
- Four phone-style choices
- Home / dialer / simulated active-call navigation
- Selected recording playback with clip offsets
- Low-volume default and a clearly disclosed Pro gate
- Widget tests for primary navigation and the free-tier gate

### Next
- Verify audio URLs and recording segments
- Confirm sound asset licensing
- Improve network failure/loading behavior
- Decide whether to bundle audio locally
- Validate the monetization concept before implementing billing

## Product guardrails

- Do not describe the simulated call as a real phone call.
- Do not claim purchases or Pro entitlements without store verification.
- Do not collect contacts, call logs, phone numbers, or call audio.
- Do not play a sound into the other person's call audio.
- Keep playback user-controlled and volume conservative by default.
