# SLAM Roadmap

SLAM is a retro phone sign-off entertainment concept. The existing implementation is a Flutter prototype; the PWA route is an experiment to validate, not an assumed rewrite. Product strategy and creator campaign direction live in [docs/PRODUCT_STRATEGY.md](docs/PRODUCT_STRATEGY.md).

## Phase 0 — Foundation and concept prototype

- [x] Establish the public repository and project identity
- [x] Select Dart and Flutter for the initial mobile prototype
- [x] Add the Flutter application shell and CI workflow
- [x] Translate the stakeholder's three-screen flow into Flutter
- [x] Add four phone-style choices and clip offsets
- [x] Add the low-volume default and Pro-gate concept
- [x] Clearly label the dialer as a call simulation
- [x] Document product positioning, three audiences, campaign scripts, taglines, and validation questions
- [ ] Confirm the three original audio asset URLs
- [ ] Verify all four recordings on physical devices

## Phase 1 — Product and audience validation

- [x] Capture the corporate burnout, gaming rage-quit, and vintage-tech creative territories
- [x] Define short-form video hooks, shot sequences, overlays, and CTAs
- [x] Document measurement ideas and developer interview criteria
- [ ] Review the remaining stakeholder conversation and confirm final product direction
- [ ] Confirm the four phone styles and exact sound clips
- [ ] Confirm audio asset ownership and commercial-use rights
- [ ] Test the three campaign concepts with small creator posts or mock videos
- [ ] Compare hook retention, link clicks, first successful playback, and repeat use

## Phase 2 — Soundboard MVP quality

- [x] Replace synthesized prototype tones with the supplied recorded-audio approach
- [x] Implement remote playback and source offsets
- [x] Add home / dialer / simulated active-call navigation
- [x] Add home-screen preview controls for each sound
- [x] Add widget coverage for navigation and the free-tier gate
- [ ] Confirm and test original audio URLs
- [ ] Bundle licensed recordings locally or implement robust download caching
- [ ] Add persistent sound and volume preferences
- [ ] Add loading, retry, interruption, and offline states
- [ ] Add a Random SLAM mode
- [ ] Test audio focus, Bluetooth, speaker, and silent-mode behavior
- [ ] Add accessibility and reduced-motion checks

## Phase 3 — Creator-friendly experience

- [ ] Prototype a fictional Skit Mode with prompt, optional caption, countdown, and sound cue
- [ ] Add a share-card / end-card treatment for creator videos
- [ ] Create reusable 10–20 second creator briefs and editable campaign templates
- [ ] Add campaign-specific landing URLs and UTM measurement
- [ ] Test whether creators can capture the UI and sound cleanly in one take

## Phase 4 — PWA validation and platform decision

- [ ] Build a narrow PWA experiment with four sounds and one-tap playback
- [ ] Verify user-gesture audio initialization on iOS Safari and Android Chrome
- [ ] Preload/decode audio and measure tap-to-sound responsiveness
- [ ] Add a manifest and service-worker caching only after browser playback works
- [ ] Compare PWA first-play success and repeat usage with Flutter
- [ ] Decide whether Flutter remains primary, PWA becomes primary, or both are maintained

## Phase 5 — Monetization and native platform research

- [ ] Validate willingness to pay before selecting a price
- [ ] Test demand for extra licensed sound packs and creator presets
- [ ] Implement real store billing only after pricing and entitlements are approved
- [ ] Build an Android Kotlin proof of concept for call-state observation
- [ ] Test permissions, lifecycle, and post-call playback on real Android devices
- [ ] Define the iOS user-triggered fallback for ordinary cellular calls

## Phase 6 — Release readiness

- [ ] Complete accessibility, privacy, security, and licensing review
- [ ] Test on representative Android and iOS devices
- [ ] Add app icon, launch experience, and store screenshots
- [ ] Prepare release notes and platform-specific feature descriptions
- [ ] Submit to stores or publish the PWA only after explicit approval

## Current quality gate

- [ ] Resolve the Dart parse/format failure from the latest CI run
- [ ] Run Flutter analyze successfully
- [ ] Run Flutter test successfully
- [ ] Verify audio playback manually on physical devices

## Working rules

- No call recording, contact scraping, or audio injection into active calls.
- Do not request phone-state permissions before the Android proof of concept.
- Do not promise automatic call-end playback on iOS for ordinary cellular calls.
- Do not simulate a successful purchase or claim Pro without store verification.
- Clearly distinguish a simulated call from a real phone call.
- Use only audio with documented rights for distribution and commercial use.
- Do not encourage users to physically slam or damage their phones.
- Do not replace the Flutter implementation until the PWA experiment provides evidence.
