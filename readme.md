# Air Native Extension for Google Analytics on iOS and Android

This is an Air native extension for Google Analytics on the iOS and Android platforms.

# Notice

The v0.2 version of the extension supports the new "Application" profile for Google Analytics.

# Warning: dragons ahead

This release is being actively developed and it's still incomplete.
Not all the native code has been written, the flash API may change before the final release and it may crash unexpectedly.
Use it at your own risk (and if you do, please don't open issues about it).

# Binary files

The _bin_ folder contains the compiled extension and the default swc, which can be used for local testing if required by your development environment (Flash Builder shouldn't need it, but other IDEs may).

# Changelog

**v0.2.03-dev**

* totally rewritten Flash API
* totally rewritten native code for Android
* upgraded to the new Google tracker (v2.0 beta 3) to support the new "Application" analytics' profile
* full support to the new Google tracker, including e-commerce, multiple tracker support
* brand new demo project built specifically for mobile devices
* still in progress:
    * support for custom metrics and dimensions
    * iOS support
    * brand new demo application
    * documentation

**v0.1.23**

* upgraded to AIR 3.5
* updated Google Analytics libraries (Android 1.5.1 and iOS 1.5)
* improved error handling
* added account ID validation

**v0.1.22**

* upgraded to AIR 3.4
* fixed more compatibility issues for cross-system compilation

**v0.1.21**

* finally tested on real iOS devices, thanks to [@digitaljohn](http://github.com/digitaljohn)
* fixed incompatibility issues with earlier versions of iOS
* added some utility methods to the Enums related to custom variables

**v0.1.2**

* upgraded to AIR 3.3
* added target in the ANT script to run the demo project on the iOS simulator
* cleaned and updated the ANT build file
* fixed issues with the iOS version of the extension

**v0.1.1**

* updated Google Analytics libraries (Android 1.4.2 and iOS 1.4)
* added demo project to showcase usage and capabilities
* added some documentation on usage

**v0.1.0**

* initial release

# Using the extension

First of all, add the *NativeGATracker.ane* to your project.
Then you should check if the library is supported, get an instance of the tracker, start a tracking session using your Analytics ID and actually track something.

The code below shows the most basic example:

	import eu.alebianco.air.extensions.analytics.GATracker;

	if (GATracker.isSupported()) {
		var tracker:GATracker = GATracker.getInstance();
		tracker.startNewSession("UA-00000000-0", interval);
		tracker.trackPageView("/custom/view/url");
	}

For any additional information you can reference the [Google Analytics Developer Guides & Reference](https://developers.google.com/analytics/devguides/) pages or the *ASDocs* on the code.
The extension follow closely the original SDK methods and functionalities, so it shouldn't be a problem to understand how it works.

If you have any problem or questions, hit me on Twitter [@alebianco](http://twitter.com/alebianco).

# Compiling your project

The extension requires that your project is built against version 5.1 of the iOS SDK.  
It doesn't require version 5.1 at run-time, version 4.0 should be sufficient, but it is required at compile-time.
Due to this limitation, any project using the extension must be compiled on a computer running Mac OS X and with version 5 or later of the iOS SDK. Specify the path to the SDK when compiling the project, if the functionality is built in to your IDE (like in Flash Builder) or using parameter **-platformsdk** when building with adt from the command line or a build script.  
Use Adobe Air SDK 3.5 or later.
	
# Building


## Requirements

* Adobe Air SDK 3.4 or later
* XCode IDE, iOS SDK 5.1 or later
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