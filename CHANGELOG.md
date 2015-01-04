## HEAD

### 3.0.0 (TBD)

* New project name!
* New build system powered by Gradle
* Upgraded to build with Apache Flex 4.13 and AIR 15
* Added support for Android-x86 platform

### 2.0.7 RC 2 (June 4, 2014)

* (beta) Automatic uncaught error reporting
* Fixed issue #42
* Fixed issue #44

### 2.0.7 RC 1 (March 26, 2014)

* Upgraded to AIR 13
* Upgrade Android native library to v2.0beta6
* Added ASDocs back into packaged release
* Implemented Google Play Campaign Attribution tracking (Android only)
* Implemented General Campaign & Traffic Source Attribution (Android only)
* Added transaction's currency code property (Android only)
* [Android] Verify app has needed permissions when checking if extension is supported
* Fixed issue #32 - transaction's shipping cost being replaced by tax cost
* Fixed issue #34 - improved app version identification from descriptor

### 2.0.6 (February 10, 2014)

* Updated to AIR 4.0

### 2.0.5 (January 14, 2014)

* Update to AIR 3.9
* Fixed issue #23 - sending hits without setting optional parameters

### 2.0.4 (September 08, 2013)

* Updated native tracker to version 2.0b4
* API refinement
* Fixed debug flag bug
* Fixed bug for reading optOut value not available in iOS
* Initializing dispatch period on first usage to fix inconsistent values
* ASdoc update & integration (scratch that, still having problems with iOS)
* Updated and improved build scripts
* Moved demo project to a separate repository

### 2.0.3 (December 28, 2012)

* Totally rewritten Flash API
* Totally rewritten native code for Android and iOS
* Upgraded to the new Google tracker (v2.0 beta 3) to support the new "Application" analytics' profile
* Full support to the new Google tracker, including e-commerce, multiple trackers support, custom metrics and dimensions
* Brand new demo project built specifically for mobile devices (in progress)

### 1.2.3 (December 2, 2012)

* Upgraded to AIR 3.5
* Updated Google Analytics libraries (Android 1.5.1 and iOS 1.5)
* Improved error handling
* Added account ID validation

### 1.2.2 (October 11, 2012)

* Upgraded to AIR 3.4
* Fixed more compatibility issues for cross-system compilation

### 1.2.1 (October 2, 2012)

* Finally tested on real iOS devices, thanks to [@digitaljohn](http://github.com/digitaljohn)
* Fixed incompatibility issues with earlier versions of iOS
* Added some utility methods to the Enums related to custom variables

### 1.2.0 (August 17, 2012)

* Upgraded to AIR 3.3
* Added target in the ANT script to run the demo project on the iOS simulator
* Cleaned and updated the ANT build file
* Fixed issues with the iOS version of the extension