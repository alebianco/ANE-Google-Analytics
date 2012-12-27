/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 18.55
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.Hit;
import eu.alebianco.air.extensions.analytics.api.IEventBuilder;
import eu.alebianco.air.extensions.analytics.api.IExceptionBuilder;
import eu.alebianco.air.extensions.analytics.api.ISocialBuilder;
import eu.alebianco.air.extensions.analytics.api.ITimingBuilder;
import eu.alebianco.air.extensions.analytics.api.ITracker;
import eu.alebianco.air.extensions.analytics.api.ITransactionBuilder;
import eu.alebianco.air.extensions.analytics.api.IViewBuilder;
import eu.alebianco.air.extensions.analytics.enums.HitType;

import flash.desktop.NativeApplication;
import flash.events.TimerEvent;
import flash.external.ExtensionContext;
import flash.utils.Timer;

internal class Tracker implements ITracker {

	private var context:ExtensionContext;

	private var id:String;

	private var timeout:uint = 30;
	private var timer:Timer;

	private var _appName:String;
	private var _appVersion:String;
	private var _lockAppData:Boolean = false;

	public function Tracker(id:String, context:ExtensionContext) {
		this.id = id;
		this.context = context;
		parseAppDescriptor();
		createTimer();
	}

	public function get appName():String {
		return _appName;
	}
	public function set appName(value:String):void {
		if (_lockAppData) return;
		_appName = value;
		handleResultFromExtension(context.call("setAppName", id, _appName));
	}
	public function get appVersion():String {
		return _appVersion;
	}
	public function set appVersion(value:String):void {
		if (_lockAppData) return;
		_appVersion = value;
		handleResultFromExtension(context.call("setAppVersion", id, _appVersion));
	}
	public function get trackingID():String {
		return id;
	}
	public function get sessionTimeout():uint {
		return timeout;
	}
	public function set sessionTimeout(value:uint):void {
		timeout = value;
		disposeTimer();
		createTimer();
	}
	public function get appID():String {
		return handleResultFromExtension(context.call("getAppID", id), String) as String;
	}
	public function set appID(value:String):void {
		handleResultFromExtension(context.call("setAppID", id, value));
	}
	public function get anonymous():Boolean {
		return handleResultFromExtension(context.call("getAnonymous", id), Boolean) as Boolean;
	}
	public function set anonymous(value:Boolean):void {
		handleResultFromExtension(context.call("setAnonymous", id, value));
	}
	public function get secure():Boolean {
		return handleResultFromExtension(context.call("getSecure", id), Boolean) as Boolean;
	}
	public function set secure(value:Boolean):void {
		handleResultFromExtension(context.call("setSecure", id, value));
	}
	public function get sampleRate():Number {
		return handleResultFromExtension(context.call("getSampleRate", id), Number) as Number;
	}
	public function set sampleRate(value:Number):void {
		handleResultFromExtension(context.call("setSampleRate", id, Math.max(0, Math.min(100, value))));
	}
	public function startNewSession():void {
		handleResultFromExtension(context.call("startNewSession", id));
	}
	public function setCustomMetric(index:uint, value:int):void {
		if (index == 0)
			throw new ArgumentError("Metrics and Dimensions indexes are 1-based.");

		handleResultFromExtension(context.call("setCustomMetric", id, index, value));
	}
	public function setCustomDimension(index:uint, value:String):void {
		if (index == 0)
			throw new ArgumentError("Metrics and Dimensions indexes are 1-based.");

		handleResultFromExtension(context.call("setCustomDimension", id, index, value));
	}
	public function send(type:HitType, data:Hit):void {
		_lockAppData = true;
		handleResultFromExtension(context.call("trackData", id, type.name, data));
	}
	public function buildView(screenName:String):IViewBuilder {
		return new ViewBuilder(this, screenName);
	}
	public function buildEvent(category:String, action:String):IEventBuilder {
		return new EventBuilder(this, category, action);
	}
	public function buildException(fatal:Boolean):IExceptionBuilder {
		return new ExceptionBuilder(this, fatal);
	}
	public function buildTiming(category:String, interval:uint):ITimingBuilder {
		return new TimingBuilder(this, category, interval);
	}
	public function buildSocial(network:String, action:String):ISocialBuilder {
		return new SocialBuilder(this, network, action);
	}
	public function buildTransaction(id:String, cost:Number):ITransactionBuilder {
		return new TransactionBuilder(this, id, cost);
	}
	public function dispose():void {
		handleResultFromExtension(context.call("closeTracker", id));
		disposeTimer();
		context = null;
	}
	private function parseAppDescriptor():void {
		const descriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
		const ns:Namespace = descriptor.namespace();
		if (appID == null) appID = descriptor.ns::id[0];
		appName = descriptor.ns::filename[0] || "";
		appVersion = descriptor.ns::versionLabel[0] || "";
	}
	private function createTimer():void {
		if (timeout == 0) return;
		timer = new Timer(timeout * 1000, 1);
		timer.addEventListener(TimerEvent.TIMER, sessionTimerHandler);
		NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, appResumedHandler);
		NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, appSuspendedHandler);
	}
	private function disposeTimer():void {
		if (!timer) return;
		NativeApplication.nativeApplication.removeEventListener(flash.events.Event.ACTIVATE, appResumedHandler);
		NativeApplication.nativeApplication.removeEventListener(flash.events.Event.DEACTIVATE, appSuspendedHandler);
		timer.removeEventListener(TimerEvent.TIMER, sessionTimerHandler);
		timer.stop();
		timer = null;
	}
	private function sessionTimerHandler(event:TimerEvent):void {
		startNewSession();
	}
	private function appResumedHandler(event:flash.events.Event):void {
		if (timer)
			timer.stop();
	}
	private function appSuspendedHandler(event:flash.events.Event):void {
		if (timer)
			timer.start();
	}
}
}
