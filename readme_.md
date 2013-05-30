# ANE-Google-Analytics: AIR Native Extension for Google Analytics on iOS and Android

This is an Air native extension for Google Analytics on the iOS and Android platforms.

**NOTE** The current release of the extension supports the new [Application profile](https://support.google.com/analytics/answer/1009714) for Google Analytics.

## Introduction

The Google Analytics Platform lets you measure user interactions with your business across various devices and environments.  
This extension for AIR applications leverages the Android and iOS native SDKs provided by Google Analytics, exposing their features through a common API that can be used seamlessly on both platforms.

This extension makes it easy for developers to collect user engagement data from their apps.  
Developers can then use Google Analytics reports to measure:
* The number of active users are using their applications.
* From where in the world the application is being used.
* Adoption and usage of specific features.
* In-app purchases and transactions.
* The number and type of application crashes.
* And many other useful metrics.

## Usage

First of all, add the *NativeGATracker.ane* to your project.  
Then you should check if the library is supported, get an instance of the tracker, start a tracking session using your Analytics ID and actually track something.

The code below shows the most basic example:
```ActionScript
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
```

A demo project aimed at showcasing all the features of the library will be committed soon.

## Building

Requirements:
* Adobe Air SDK 3.5 or later
* XCode IDE, iOS SDK 5.1 or later
* Google Android SDK 2.2

Add the _FlashRuntimeExtensions.h_ file from the Adobe Air SDK to the _source/ios/Libraries_ folder  
Add the _FlashRuntimeExtensions.jar_ file from the Adobe Air SDK to the _source/android/libs_ folder  
In the **build** folder, make a copy of the _user.properties.eg_ file and call it _user.properties_  
Edit that file to provide values specific to your system  
Use the `build.ant` ant script you'll find in the **build** folder, to build the project

## Contributing

If you want to contribute to the project refer to the [CONTRIBUTING.md](CONTRIBUTING.md) document for guidelines.

## Roadmap

You can follow the project planning on [Trello](https://trello.com/b/wk7wHEhS), you can even vote for the tasks that are more important for you and you'll like to see implemented.