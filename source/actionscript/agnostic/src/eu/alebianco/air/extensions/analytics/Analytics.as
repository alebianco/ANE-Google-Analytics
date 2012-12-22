/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 16.22
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.IAnalytics;
import eu.alebianco.air.extensions.analytics.api.ITracker;

import flash.events.StatusEvent;
import flash.external.ExtensionContext;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;

import mx.logging.ILogger;
import mx.logging.Log;

public final class Analytics implements IAnalytics {

	private static const EXTENSION_ID:String = "eu.alebianco.air.extensions.analytics.NativeGATracker";
	private static const ID_VALIDATOR:RegExp = /^UA-\d{4,10}-\d{1,4}$/i;

	private static var instance:Analytics;
	private static var canBuild:Boolean;

	private var logger:ILogger;

	private var context:ExtensionContext;
	private var trackers:Dictionary;

	private var _dispatchInterval:uint = 180;
	private var _dispatchManually:Boolean = false;

	public static function getInstance():Analytics {
		if (!instance) {
			canBuild = true;
			instance = new Analytics();
			canBuild = false;
		}
		return instance;
	}

	public static function isSupported():Boolean {
		var c:ExtensionContext = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
		var result:Boolean = c.call("isSupported") as Boolean;
		c.dispose();
		return result;
	}

	public function Analytics() {
		if (!canBuild)
			throw new Error("Can't instantiate a Singleton class, use getInstance() to get a reference.");

		if (!context) {
			context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
			dispatchInterval = dispatchInterval;
			context.addEventListener(StatusEvent.STATUS, statusHandler);
		}

		trackers = new Dictionary();

		var className:String = getQualifiedClassName(this).replace("::", ".");
		logger = Log.getLogger(className);
	}

	public function get version():String {
		return handleResultFromExtension(context.call("getVersion"), String);
	}

	public function get debug():Boolean {
		return handleResultFromExtension(context.call("getDebug"), Boolean) as Boolean;
	}

	public function set debug(value:Boolean):void {
		handleResultFromExtension(context.call("setDebug", value));
	}

	public function get optOut():Boolean {
		return handleResultFromExtension(context.call("getOptOut"), Boolean) as Boolean;
	}

	public function set optOut(value:Boolean):void {
		handleResultFromExtension(context.call("setOptOut", value));
	}

	public function get dispatchManually():Boolean {
		return _dispatchManually;
	}

	public function set dispatchManually(value:Boolean):void {
		_dispatchManually = value;
		handleResultFromExtension(context.call("setDispatchInterval", _dispatchManually ? -1 : _dispatchInterval));
	}

	public function get dispatchInterval():uint {
		return _dispatchInterval;
	}

	public function set dispatchInterval(seconds:uint):void {
		_dispatchInterval = seconds;
		handleResultFromExtension(context.call("setDispatchInterval", _dispatchManually ? -1 : _dispatchInterval));
	}

	public function hasTracker(accountId:String):Boolean {
		if (!ID_VALIDATOR.test(accountId))
			throw new ArgumentError("The provided account ID (" + accountId + ") is invalid, it should follow the format UA-00000-0.");

		return handleResultFromExtension(context.call("hasTracker", accountId), Boolean) as Boolean;
	}

	public function getTracker(accountId:String):ITracker {
		if (!ID_VALIDATOR.test(accountId))
			throw new ArgumentError("The provided account ID (" + accountId + ") is invalid, it should follow the format UA-00000-0.");

		var tracker:ITracker;
		if (accountId in trackers) {
			tracker = trackers[accountId];
		} else {
			handleResultFromExtension(context.call("getTracker", accountId));
			tracker = new Tracker(accountId, context);
			trackers[accountId] = tracker;
		}
		return tracker;
	}

	public function dispatch():void {
		handleResultFromExtension(context.call("dispatch"));
	}

	public function dispose():void {
		disposeAllTrackers();
		context.dispose();
		context.removeEventListener(StatusEvent.STATUS, statusHandler);
		context = null;
		logger = null;
		trackers = null;
	}

	private function disposeAllTrackers():void {
		for (var id:String in trackers) {
			var tracker:ITracker = trackers[id];
			tracker.dispose();
			trackers[id] = null;
			delete trackers[id];
		}
	}

	private function statusHandler(event:StatusEvent):void {
		var level:StatusLevel = StatusLevel.parseConstant(event.level);
		if (level) {
			var ns:Namespace = level.ns;
			ns::processStatusEvent(level.name, event.code);
		}
	}

	logStatusLevel function processStatusEvent(level:String, code:String):void {
		switch (level.toUpperCase()) {
			case "INFO":
				logger.info(code);
				break;
			case "DEBUG":
				logger.debug(code);
				break;
			case "WARN":
				logger.warn(code);
				break;
			case "ERROR":
				logger.error(code);
				break;
			case "FATAL":
				logger.fatal(code);
				break;
			default:
				logger.debug("AsyncStatusEvent level (" + level + ") unknown.");
				break;
		}
	}
}
}