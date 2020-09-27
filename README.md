# flutter_firebase_crashlist

Flutter Firebase Crash List Installation

## Getting Started

1. Setup the firebase console settings


1. Then Setup the firebase settings in flutter
   `android/build.gradle file`

   - `classpath 'com.google.gms:google-services:4.3.3'`
   - `classpath 'com.google.firebase:firebase-crashlytics-gradle:2.3.0'`

3. Then Setup the firebase settings in flutter
   `android/app/build.gradle file`

   - `apply plugin: 'com.google.gms.google-services'`

   - `apply plugin: 'com.google.firebase.crashlytics'`
   - `implementation 'com.google.firebase:firebase-analytics:17.5.0'`
   - `implementation 'com.google.firebase:firebase-crashlytics:17.2.1'`

4. Install package `firebase_crashlytics` for flutter
