# Air Native Extension for Google Analytics on iOS and Android

This is an Air native extension for Google Analytics on the iOS and Android platforms.

> **WARNING**  
The iOS version of the library has not been tested on an actual device.  
It does compile whitout any problem, but my cause crashes or any kind of apocalypse when used.  
As soon as I can put my hands on an iPhone I'll test it and verify that everything's working as it should. In the meantime, you've been warned.

# Binary files

The _bin_ folder contains the compiled extension and the default swc, which can be used for local testing if required by your development environment (Flash Builder shouldn’t need it, but other IDEs may).

# Changelog

**v0.1.1**

* updated Google Analytics libraries (Android 1.4.2 and iOS 1.4)
* added demo project to showcase usage and capabilities
* added some documentation on usage

**v0.1.0**

* initial release

# Compiling your project

The extension requires that your project is built against version 5 of the iOS SDK.  
It doesn’t require version 5 at run-time (version 4 is sufficient), but it is required at compile-time.  
Due to this limitation, any project using the extension must be compiled on a computer running Mac OS X and with version 5 or later of the iOS SDK. Specify the path to the SDK when compiling the project, if the functionality is built in to your IDE (like in Flash Builder) or using parameter **-platformsdk** when building with adt from the command line or a build script.  
Use Adobe Air SDK 3.1 or later.

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
In any case, if you have any problem or questions, just drop me a line.
	
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


# Coming up

* Better documentation
* ECommerce support
* Better error logging

# Projects using this extension

* none, yet