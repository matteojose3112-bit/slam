# SLAM Roadmap

SLAM is a retro phone sign-off app prototype. The current direction is based on the stakeholder's React/Web Audio concept, translated into the existing Flutter repository.

## Phase 0 — Foundation and concept prototype

- [x] Establish the public repository and project identity
- [x] Select Dart and Flutter for Android/iOS
- [x] Add the Flutter application shell and CI
- [x] Translate the stakeholder's three-screen flow into Flutter
- [x] Add four phone-style choices and clip offsets
- [x] Add the low-volume free-tier default and Pro-gate concept
- [x] Clearly label the dialer as a call simulation
- [ ] Confirm the three original audio asset URLs
- [ ] Verify all four recordings on physical devices

## Phase 1 — Product validation

- [ ] Review remaining stakeholder notes and confirm product direction
- [ ] Confirm the four phone styles and exact sound clips
- [ ] Decide whether volume levels and Pro restrictions are appropriate
- [ ] Confirm whether the dialer is a playful simulation or a shortcut into the native phone app
- [ ] Confirm manual post-call flow versus automatic triggering
- [ ] Confirm audio asset ownership and commercial-use rights

## Phase 2 — Soundboard MVP

- [x] Replace synthesized prototype tones with the supplied recorded-audio approach
- [x] Implement remote playback and source offsets
- [x] Add home / dialer / simulated active-call navigation
- [x] Add widget coverage for navigation and the free-tier gate
- [ ] Confirm and test original audio URLs
- [ ] Bundle licensed recordings locally or implement robust download caching
- [ ] Add persistent sound and volume preferences
- [ ] Add loading, retry, interruption, and offline states
- [ ] Test audio focus, Bluetooth, speaker, and silent-mode behavior

## Phase 3 — Monetization and platform research

- [ ] Decide whether a paid tier belongs in the product
- [ ] Implement real store billing only after pricing and entitlements are approved
- [ ] Build an Android Kotlin proof of concept for call-state observation
- [ ] Test permissions, lifecycle, and post-call playback on real Android devices
- [ ] Define the iOS user-triggered fallback for ordinary cellular calls

## Phase 4 — Release readiness

- [ ] Accessibility, privacy, security, and licensing review
- [ ] Test on representative Android and iOS devices
- [ ] Add app icon, launch experience, and store screenshots
- [ ] Prepare release notes and platform-specific feature descriptions
- [ ] Submit to stores only after explicit approval

## Working rules

- No call recording, contact scraping, or audio injection into active calls.
- Do not request phone-state permissions before the Android proof of concept.
- Do not promise automatic call-end playback on iOS for ordinary cellular calls.
- Do not simulate a successful purchase or claim Pro without store verification.
- Clearly distinguish a simulated call from a real phone call.
