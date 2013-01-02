# Air Native Extension for Google Analytics on iOS and Android

This is an Air native extension for Google Analytics on the iOS and Android platforms.

# Notice

The v0.2 version of the extension supports the new "Application" profile for Google Analytics.

# Warning: (lesser) dragons ahead

The release is almost complete. Both native implementations for Android and iOS are complete and i don't expect to change the Flash API anymore. The extension will be moved to the _master_ branch for a proper release once I've completed a couple of additional tasks and performed some more tests.

The documentation is ready, but apparently there's no way to add it to the .ane file without breaking iOS apps (Android apps seems to compile and run just fine).
 I'm looking into the issue, hoping in some help directly from Adobe.

The extension so far has been tested on Android (2.3 and 4.0) and on the iPhone simulator. I think I've covered all the major bugs, but some error could still come up. It's your turn now to test it on as many devices as possible and let me know if there's still any problem to fix.

# Binary files

The _bin_ folder contains the compiled extension and the default swc, which can be used for local testing if required by your development environment (Flash Builder shouldn't need it, but other IDEs may).

# Changelog

**v0.2.03**

* totally rewritten Flash API
* totally rewritten native code for Android and iOS
* upgraded to the new Google tracker (v2.0 beta 3) to support the new "Application" analytics' profile
* full support to the new Google tracker, including e-commerce, multiple trackers support, custom metrics and dimensions

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

	import eu.alebianco.air.extensions.analytics.Analytics;
    import eu.alebianco.air.extensions.analytics.api.ITracker;

	if (Analytics.isSupported()) {
		var analytics:Analytics = Analytics.getInstance();
        var tracker:ITracker = analytics.getTracker(ANALYTICS_ID);

        // Track a page view
        tracker.buildView("Home").track();

        // Track an event
        tracker.buildEvent("click", "button").withLabel("play").withValue(10).track();
        tracker.buildEvent("click", "button").withLabel("stop").track();
        tracker.buildEvent("swipe", "screen").withValue(1).track();
        tracker.buildEvent("app", "quit").track();

        // Track an exception
        tracker.buildException(false).withDescription("ok, an error occurred, but it wasn't that bad").track();
        tracker.buildException(true).withDescription("panic! this shit is hitting the fan!").track();
        tracker.buildException(false).track();

        // Track a timer
        tracker.buildTiming("loading", 5000).withName("resources").withLabel("audio.mp3").track();
        tracker.buildTiming("waiting", 1000).track();

        // Track a social interaction
        tracker.buildSocial("GooglePlus", "+1").forContent("http://alessandrobianco.eu").track();
        tracker.buildSocial("Facebook", "like").track();

        // Track an ecommerce transaction
        tracker.buildTransaction(UIDUtil.createUID(), 10.5)
                .withAffiliation("In-App Purchase")
                .withTaxCost(0.5)
                .createProduct("cr-300", "300 credits pack", 7, 1).inCategory("credits").add()
                .createProduct("it-156", "extra life item", 1.5, 2).add()
                .track();
	}

For any additional information you can reference the [Google Analytics Developer Guides & Reference](https://developers.google.com/analytics/devguides/) pages or the *ASDocs* on the code.
The extension follow closely the original SDK methods and functionalities, so it shouldn't be a problem to understand how it works.

If you have any problem or questions, hit me on Twitter [@alebianco](http://twitter.com/alebianco).

# Compiling your project

The extension requires that your project is built against version 5.1 of the iOS SDK.  
It doesn't require version 5.1 at run-time, version 4.3 should be sufficient, but it is required at compile-time.
Due to this limitation, any project using the extension must be compiled on a computer running Mac OS X and with version 5.1 or later of the iOS SDK. Specify the path to the SDK when compiling the project, if the functionality is built in to your IDE (like in Flash Builder) or using parameter **-platformsdk** when building with adt from the command line or a build script.
Use Adobe Air SDK 3.5 or later.
	
# Building


## Requirements

* Adobe Air SDK 3.5 or later
* XCode IDE, iOS SDK 5.1 or later
* Google Android SDK 2.2
* Google Analytics v2 mobile SDKs for iOS and Android

## Set up

* Download the [Google Analytics mobile SDKs](http://code.google.com/apis/analytics/docs/mobile/download.html) for both iOS and Android platforms.
    * From the iOS SDK, copy the files _GANTracker.h_ and _libGoogleAnalytics.a_ from the _Library_ folder within the .tar.gz archive, to the _source/ios/Libraries_ folder in the project.
	* From the Android SDK, copy the file _libGoogleAnalytics.jar_ from inside the .zip archive, to the _source/android/libs_ folder in the project.
* Add the _FlashRuntimeExtensions.h_ file from the Adobe Air SDK to the _source/ios/Libraries_ folder in the project.
* Add the _FlashRuntimeExtensions.jar_ file from the Adobe Air SDK to the _source/android/libs_ folder in the project.
* Substitute the file _certificate.p12_ in the _build_ folder with your own. This may be a self-signed certificate created by Adobe Air.
* Edit the _build.config_ files in the _build_ folder and change the properties in this file to match your system.
* Run the ant build script _build.ant_ from the _build_ folder. This creates the native extension, and the default swc file, inside the _bin_ folder.