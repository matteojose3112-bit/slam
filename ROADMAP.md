# SLAM Roadmap

This roadmap separates foundational engineering from product decisions. Feature scope stays intentionally flexible until the initial requirements are reviewed.

## Phase 0 — Foundation

- [x] Establish the public repository and project identity
- [x] Select Dart and Flutter for Android/iOS
- [x] Define initial architecture and dependency principles
- [x] Add the runnable Flutter application scaffold
- [x] Add baseline formatting, analysis, and widget tests
- [x] Add GitHub Actions CI for Flutter checks

## Phase 1 — Product discovery

- [ ] Review the original notes and intended use case
- [ ] Identify primary users and the core problem
- [ ] Define the smallest useful first release
- [ ] Map the main user journey and key screens
- [ ] Agree on privacy, accessibility, and offline requirements
- [ ] Record product decisions in the brief

## Phase 2 — First usable release

- [ ] Implement the approved core user journey
- [ ] Add state management and navigation only where justified
- [ ] Add persistence or backend only if required
- [ ] Add error, loading, and empty states
- [ ] Add unit and widget coverage for critical behavior
- [ ] Validate on Android and iOS

## Phase 3 — Quality and release

- [ ] Accessibility and responsive-layout review
- [ ] Security and data-handling review
- [ ] Integration and device testing
- [ ] App icon, launch experience, and store assets
- [ ] Release notes and distribution plan
- [ ] Prepare Play Store / App Store submission when approved

## Working rule

No speculative feature work, external services, paid infrastructure, or store submission before the product brief and user approval establish the need.
