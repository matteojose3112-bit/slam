# SLAM — Call-End Integration Research

**Status:** Initial feasibility assessment, not device-tested  
**Last reviewed:** 2026-11-14

## Requirement

After an ordinary cellular call ends, SLAM should ideally play the chosen sign-off locally on the phone. It must not inject sound into the other person's call audio or record the conversation.

## iOS

Apple documents CallKit as the framework for integrating calling services provided by an app, including that app's VoIP calls. It is not a general-purpose API for an unrelated app to observe the end of calls handled by Apple's Phone app.

- Do not build the ordinary cellular-call experience around observing the native Phone app.
- A future SLAM-owned VoIP calling service could use CallKit, but that is a much larger product.
- Keep user-triggered playback as the baseline for ordinary calls on iOS.

References:
- [Apple CallKit overview](https://developer.apple.com/documentation/callkit)
- [Apple: Responding to VoIP notifications and call hang-ups](https://developer.apple.com/documentation/pushkit/responding-to-voip-notifications-from-pushkit)
- [Apple: Preparing an app to be the default calling app](https://developer.apple.com/documentation/callkit/preparing-your-app-to-be-the-default-calling-app)

## Android

Android provides telephony call-state APIs. The current Android reference identifies TelephonyCallback.CallStateListener as the modern listener and documents READ_PHONE_STATE as the permission required for call-state access.

This is a possible technical path, not a product guarantee. A native proof of concept must test:

- Permission request and consent flow
- Android versions, OEMs, dual-SIM devices, and VoIP behavior
- Background lifecycle and reliable post-call playback
- Audio focus and output routing after the call
- Battery, privacy, Play policy, and background-execution implications

Do not request call-state permission until the proof of concept is ready and the user understands why it is needed.

References:
- [Android PhoneStateListener / TelephonyCallback](https://developer.android.com/reference/android/telephony/PhoneStateListener)
- [Android READ_PHONE_STATE permission](https://developer.android.com/reference/android/Manifest.permission#READ_PHONE_STATE)
- [Android TelephonyManager call state](https://developer.android.com/reference/android/telephony/TelephonyManager)

## Recommended strategy

1. Keep the sound catalog, selection, local playback, preferences, and UI in Flutter/Dart.
2. Build a small native Kotlin Android spike to test call-state events and post-call playback on physical devices.
3. Keep a user-triggered fallback for ordinary calls on iOS.
4. Keep UI and marketing copy honest about manual versus automatic playback.

## Decision

For the prototype, build the soundboard and local playback first. Do not add telephony permissions, background services, or native call hooks yet.
