# SLAM Roadmap

SLAM is a retro-inspired mobile soundboard that gives users a memorable sign-off sound after a call. The core soundboard is cross-platform; automatic call-end integration is a separate, platform-specific research track.

## Phase 0 — Foundation and concept prototype

- [x] Establish the public repository and project identity
- [x] Select Dart and Flutter for Android/iOS
- [x] Add the Flutter application shell and CI
- [x] Define the retro call sign-off product concept
- [x] Build a dark soundboard interface with five selectable effects
- [x] Generate original prototype WAV effects locally in Dart
- [x] Add in-app playback and preview controls
- [x] Document iOS and Android call-end constraints
- [ ] Verify playback on physical Android and iOS devices

## Phase 1 — Product validation

- [ ] Review stakeholder notes and confirm the desired sound styles
- [ ] Decide whether the app should feel playful, nostalgic, customizable, or all three
- [ ] Validate the five prototype sounds and identify the signature effect
- [ ] Define the default sound, volume, mute, and accessibility behavior
- [ ] Confirm whether users expect manual post-call playback or automatic triggering
- [ ] Agree on privacy language and permission rationale

## Phase 2 — Soundboard MVP

- [x] Extract the WAV generator into a testable audio service
- [ ] Add persistent selected-sound and volume preferences
- [ ] Add custom sound import, with format and duration validation
- [ ] Add favorites and a compact quick-play interaction
- [ ] Test audio focus, interruptions, Bluetooth, speaker, and silent mode
- [x] Add WAV header and preset-duration unit tests\n- [ ] Expand widget coverage for playback errors, interruptions, and preferences

## Phase 3 — Call-end integration research

- [ ] Build a small Android Kotlin proof of concept for call-state observation
- [ ] Test READ_PHONE_STATE consent and lifecycle behavior on real devices
- [ ] Validate playback after cellular calls across Android versions and OEMs
- [ ] Document iOS ordinary-call limitations and user-triggered fallback
- [ ] Decide whether automatic Android support is reliable and worth maintaining
- [ ] Keep unsupported automatic behavior clearly disabled on iOS

## Phase 4 — Release readiness

- [ ] Accessibility, privacy, and security review
- [ ] Test on representative Android and iOS devices
- [ ] Add app icon, launch experience, and store screenshots
- [ ] Prepare release notes and platform-specific feature descriptions
- [ ] Submit to stores only after explicit approval

## Working rules

- No call recording, contact scraping, or audio injection into active calls.
- Do not request phone-state permissions before the Android proof of concept.
- Do not promise automatic call-end playback on iOS for ordinary cellular calls.
- Keep the basic soundboard useful offline and independently of call integration.
