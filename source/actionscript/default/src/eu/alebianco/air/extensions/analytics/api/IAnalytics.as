/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 16.34
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

import eu.alebianco.core.IDisposable;

/**
 * Manages the trackers and provide facilities to dispatch the collected hits and set behavioral flags.
 */
public interface IAnalytics extends IDisposable {
	/**
	 * Current version of the extension.
	 */
	function get version():String;
	/**
	 * Indicates whether or not the debug mode is enabled.
	 * <p>When debug is enabled, the Google tracker will write additional messages to the device logs.</p>
	 * @default false
	 */
	function get debug():Boolean;
	/**
	 * @private
	 */
	function set debug(value:Boolean):void;
	/**
	 * Sets or resets the application-level opt out flag.
	 * <p>If set, no hits will be sent to Google Analytics. The value of this flag will persist across app starts.</p>
	 * @default false
	 */
	function get optOut():Boolean;
	/**
	 * @private
	 */
	function set optOut(value:Boolean):void;
	/**
	 * Indicates whether or not manual dispatching is enabled.
	 * <p>When enabled, the application will need to manually dispatch events with the dispatch() method.</p>
	 * @see #dispatch()
	 * @default false
	 */
	function get dispatchManually():Boolean;
	/**
	 * @private
	 */
	function set dispatchManually(value:Boolean):void;
	/**
	 * Indicates the interval of time, in seconds, between automatic dispatches of events.
	 * <p>If zero, dispatching happens on every hit, if the device has internet connectivity.</p>
	 * @default 120
	 */
	function get dispatchInterval():uint;
	/**
	 * @private
	 */
	function set dispatchInterval(seconds:uint):void;
	/**
	 * Dispatches queued hits (view, events, etc) to Google Analytics if a network connection is available.
	 * <p>This has no effect on the dispatch interval and it can be used in conjunction with automatic dispatching to
	 * force the dispatch at any point, like before exiting the application.</p>
	 */
	function dispatch():void;
	/**
	 * Returns a tracker for the specified Google Analytics account ID.
	 * <p>When the tracker is created, some information about the current application (id, name and version) are
	 * automatically set. They can be overridden before tracking any kind of data.</p>
	 * <p>Multiple trackers can be created for multiple accounts. If a tracker for a given ID has already been created,
	 * and not yet disposed, the existing instance will be returned.</p>
	 * @param trackingId String in the form UA-xxxx-y
	 * @return The tracker from which send tracking events to Google Analytics
	 * @throws ArgumentError if the trackingId specified doesn't match the requested format.
	 */
	function getTracker(trackingId:String):ITracker;
	/**
	 * Checks whether a tracker for the given ID already exists or not.
	 * @param trackingId String in the form UA-xxxx-y
	 * @return true if the tracker already exists, false otherwise.
	 * @throws ArgumentError if the trackingId specified doesn't match the requested format.
	 */
	function hasTracker(trackingId:String):Boolean;
	/**
	 * Dispose the tracker for the given ID, if it exists.
	 * <p>After being disposed the tracker can't be used anymore and should be recreated using getTracker().</p>
	 * @see #getTracker()
	 * @param trackingId String in the form UA-xxxx-y
	 * @throws ArgumentError if the trackingId specified doesn't match the requested format.
	 */
	function closeTracker(trackingId:String):void;
}
}