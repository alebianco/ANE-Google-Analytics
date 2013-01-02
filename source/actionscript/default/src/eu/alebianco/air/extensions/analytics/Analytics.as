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

public final class Analytics implements IAnalytics {
	private static var instance:Analytics;
	private static var canBuild:Boolean;
	public static function isSupported():Boolean {
		return false;
	}
	public static function getInstance():Analytics {
		if (!instance) {
			canBuild = true;
			instance = new Analytics();
			canBuild = false;
		}
		return instance;
	}
	public function Analytics() {
		if (!canBuild)
			throw new Error("Can't instantiate a Singleton class, use getInstance() to get a reference.");
	}
	public function get version():String {
		return "";
	}
	public function get debug():Boolean {
		return false;
	}
	public function set debug(value:Boolean):void {
	}
	public function get optOut():Boolean {
		return false;
	}
	public function set optOut(value:Boolean):void {
	}
	public function get dispatchManually():Boolean {
		return false;
	}
	public function set dispatchManually(value:Boolean):void {
	}
	public function get dispatchInterval():uint {
		return 0;
	}
	public function set dispatchInterval(seconds:uint):void {
	}
	public function dispose():void {
	}
	public function getTracker(trackingId:String):ITracker {
		return null;
	}
	public function hasTracker(trackingId:String):Boolean {
		return false;
	}
	public function closeTracker(trackingId:String):void {
	}
	public function dispatch():void {
	}
}
}