# Air Native Extension for Google Analytics on iOS and Android

This is an Air native extension for Google Analytics on the iOS and Android platforms.

# Version

This is version 0.1 of this extension.
The compiled extension contains version 1.4 of the Google Analytics mobile SDK.

# Binary files

The _bin_ folder contains the compiled extension and the default swc, which can be used for local testing if required by your development environment (Flash Builder shouldn’t need it, but other IDEs may).

# Building

## Requirements

* Adobe Air SDK 3.1 or later
* XCode IDE, iOS SDK 5.0 or later
* Google Android SDK 2.2
* Google Analytics mobile SDKs for iOS and Android

## Set up

* Download the [Google Analytics mobile SDKs](http://code.google.com/apis/analytics/docs/mobile/download.html) for both iOS and Android platforms.
    * From the iOS SDK, copy the files _GANTracker.h_ and _libGoogleAnalytics.a_ from the _Library_ folder within the .tar.gz archive, to the _source/ios/Libraries_ folder in the project.
	* From the Android SDK, copy the file _libGoogleAnalytics.jar_ from inside the .zip archive, to the _source/android/libs_ folder in the project.
* Add the _FlashRuntimeExtensions.h_ file from the Adobe Air SDK to the _source/ios/Libraries_ folder in the project.
* Add the _FlashRuntimeExtensions.jar_ file from the Adobe Air SDK to the _source/android/libs_ folder in the project.
* Substitute the file _certificate.p12_ in the _build_ folder with your own. This may be a self-signed certificate created by Adobe Air.
* Edit the _build.config_ file in the _build_ folder and change the properties in this file to match your system.
* Run the ant build script _build.ant_ from the _build_ folder. This creates the native extension, and the default swc file, inside the _bin_ folder.

# Compiling your project

The extension requires that your project is built against version 5 of the iOS SDK. It doesn’t require version 5 at run-time (version 4 is sufficient), but it is required at compile-time. Due to this limitation, any project using the extension must be compiled on a computer running Mac OS X and with version 5 or later of the iOS SDK. Specify the path to the SDK when compiling the project,  if the functionality is built in to your IDE (like in Flash Builder) or using parameter **platformsdk** when building with adt from the command line or a build script.
Use Adobe Air SDK 3.1 or later.

# Coming up

* Documentation
* Usage examples
* ECommerce support
* Better error logging

# Projects using this extension

* none yet, yet