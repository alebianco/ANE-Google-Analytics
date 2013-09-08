/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 16.21
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.IAnalytics;
import eu.alebianco.air.extensions.analytics.api.ITracker;

/**
 * The entry point of the extension.
 * <p>The class is implemented as a Singleton and will manage the trackers and provide facilities to dispatch the
 * collected hits and set behavioral flags.</p>
 */
public final class Analytics implements IAnalytics {
	private static var instance:Analytics;
	private static var canBuild:Boolean;
	/**
	 * Returns a reference to the only instance of the class.
	 * @return the instance reference.
	 * @example
	 * <listing version="3.0">
	 * var analytics:IAnalytics = Analytics.getInstance();
	 * </listing>
	 */
	public static function getInstance():Analytics {
		if (!instance) {
			canBuild = true;
			instance = new Analytics();
			canBuild = false;
		}
		return instance;
	}
	/**
	 * Checks if the extension is supported on the current platform.
	 * <p>This is a common best practice for AIR native extensions.</p>
	 * @internal this method creates a temporary context to verify the supports and then dispose it.
	 * @return true if the extension is supported and can be used, false otherwise.
	 * @example
	 * <listing version="3.0">
	 * if (Analytics.isSupported()) {
	 *     ....
	 * }
	 * </listing>
	 */
	public static function isSupported():Boolean {
		return false;
	}
	/**
	 * Analytics constructor.
	 * <p>Can't be used directly.</p>
	 * <p>The class follows the Singleton Pattern to ensure only one instance exists at any time.
	 * Use the getInstance() method to get a reference to the current instance.</p>
	 * @see #getInstance()
	 * @see http://en.wikipedia.org/wiki/Singleton_pattern
	 * @throws Error if trying to instantiate it without the getInstance() method.
	 */
	public function Analytics() {
		if (!canBuild)
			throw new Error("Can't instantiate a Singleton class, use getInstance() to get a reference.");
	}
	/**
	 * @inheritDoc
	 */
	public function get version():String {
		return "ANE-Google-Analytics v2.0.4";
	}
	/**
	 * @inheritDoc
	 */
	public function get debug():Boolean {
		return false;
	}
	/**
	 * @private
	 */
	public function set debug(value:Boolean):void {
	}
	/**
	 * @inheritDoc
	 */
	public function get optOut():Boolean {
		return false;
	}
	/**
	 * @private
	 */
	public function set optOut(value:Boolean):void {
	}
	/**
	 * @inheritDoc
	 */
	public function get dispatchManually():Boolean {
		return false;
	}
	/**
	 * @private
	 */
	public function set dispatchManually(value:Boolean):void {
	}
	/**
	 * @inheritDoc
	 */
	public function get dispatchInterval():uint {
		return 0;
	}
	/**
	 * @private
	 */
	public function set dispatchInterval(seconds:uint):void {
	}
	/**
	 * Dispose the extension and clear any object reference to ready it for garbage collection.
	 * <p>All existing trackers are closed immediately and can't be used anymore.</p>
	 * <p>Existing references to the class will be unusable.</p>
	 * <p>The extension can be initialized again by calling getInstance()</p>
	 * @see #getInstance()
	 * @see #closeTracker()
	 */
	public function dispose():void {
	}
	/**
	 * @inheritDoc
	 */
	public function getTracker(trackingId:String):ITracker {
		return null;
	}
	/**
	 * @inheritDoc
	 */
	public function hasTracker(trackingId:String):Boolean {
		return false;
	}
	/**
	 * @inheritDoc
	 */
	public function closeTracker(trackingId:String):void {
	}
	/**
	 * @inheritDoc
	 */
	public function dispatch():void {
	}
}
}