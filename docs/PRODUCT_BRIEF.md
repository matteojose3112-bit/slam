# SLAM — Product Brief

**Status:** Prototype / product discovery  
**Platforms:** Android and iOS  
**Implementation:** Dart + Flutter

## Product idea

SLAM is a playful mobile sound-effects companion that makes the end of a phone call feel memorable. The signature experience is the satisfying clunk of an old 1980s telephone handset being slammed down—plus other customizable sign-offs.

**Core promise:** Choose the sound you want associated with ending a call, preview it, and make your exit memorable.

The first prototype includes five original, locally synthesized sound effects. It is a soundboard demonstration, not yet an automatic phone-call integration.

## The signature sound collection

- **The Handset Slam** — a chunky retro receiver drop
- **Hard Disconnect** — a crisp mechanical click
- **The Busy Signal** — a classic two-tone telephone signal
- **Record Stop** — a dramatic descending pitch
- **The Mic Drop** — a deep cinematic impact

The first sound designs are synthesized in-app for prototyping. A later production library can use carefully designed, licensed, original recordings.

## Intended user journey

1. Open SLAM.
2. Browse the sign-off sounds.
3. Preview a sound and choose a favorite/default.
4. End a call.
5. Trigger the chosen sound using a platform-supported action.

Step 5 is the main technical risk. The current build supports in-app preview and manual playback. Automatic detection of ordinary cellular call endings has not been implemented and must not be advertised as available.

## Platform feasibility

- **Android:** Native telephony APIs expose call-state changes with appropriate permission, but background execution, device behavior, Android version differences, and app-store policy need a dedicated proof of concept.
- **iOS:** CallKit is designed to integrate calls managed by the app, especially its own VoIP calling service. It is not a general-purpose hook for detecting the end of calls made in Apple's Phone app. The iOS experience therefore needs a user-triggered fallback unless platform capabilities change.

SLAM will play its effects locally on the user's device. It will not inject sounds into an active phone conversation or record call audio.

See [Call-end integration research](CALL_INTEGRATION.md).

## Prototype scope

### Implemented
- Five selectable sign-off sounds
- In-app preview and playback
- Original synthesized WAV sound effects generated locally
- Dark retro-inspired interface with a high-contrast lime accent
- Clear notice that automatic call-end playback is still under exploration

### Next
- Confirm the product direction and sound preferences with the original stakeholder
- Add a persistent default sound and volume control
- Test audio focus, interruptions, Bluetooth, speaker, and silent-mode behavior
- Build an Android call-state feasibility spike
- Define the best iOS manual trigger experience

## Product guardrails

- Do not promise automatic call-end playback until proven on real devices.
- Do not collect contacts, call logs, phone numbers, or call audio for the soundboard.
- Do not play a sound into the other person's call audio.
- Keep playback user-controlled, with a clear way to disable it.
- Respect platform audio focus, user volume, and accessibility needs.

## First-release definition

- **Primary user:** People who enjoy personalizing small everyday interactions.
- **Problem:** Phone calls end abruptly and without personality.
- **Core promise:** Give the end of a call a signature sound.
- **Must-have:** Sound library, preview, selected default, reliable local playback, user-triggered sign-off.
- **Stretch goal:** Automatic post-call trigger on platforms where it is permitted and dependable.
- **Out of scope:** Call recording, call interception, sound injection into live calls, contact management, call analytics.
- **Success measure:** A user can choose a sound and play it reliably in a few taps without disrupting normal phone use.
