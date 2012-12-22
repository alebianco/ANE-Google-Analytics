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

import eu.alebianco.air.extensions.analytics.api.IEventBuilder;
import eu.alebianco.air.extensions.analytics.api.IExceptionBuilder;
import eu.alebianco.air.extensions.analytics.api.ISocialBuilder;
import eu.alebianco.air.extensions.analytics.api.ITimingBuilder;
import eu.alebianco.air.extensions.analytics.api.ITracker;
import eu.alebianco.air.extensions.analytics.api.ITransactionBuilder;
import eu.alebianco.air.extensions.analytics.api.IViewBuilder;

import flash.desktop.NativeApplication;
import flash.errors.IllegalOperationError;
import flash.events.Event;
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

	public function Tracker(id:String, context:ExtensionContext) {
		this.id = id;
		this.context = context;
		parseAppDescriptor();
		createTimer();
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
	public function get appInstallerID():String {
		return handleResultFromExtension(context.call("getAppInstallerID", id), String) as String;
	}
	public function set appInstallerID(value:String):void {
		handleResultFromExtension(context.call("setAppInstallerID", id, value));
	}
	public function get appName():String {
		return _appName;
	}
	public function set appName(value:String):void {
		_appName = value;
		handleResultFromExtension(context.call("setAppName", id, _appName));
	}
	public function get appVersion():String {
		return _appVersion;
	}
	public function set appVersion(value:String):void {
		_appVersion = value;
		handleResultFromExtension(context.call("setAppVersion", id, _appVersion));
	}

	public function get anonymous():Boolean {
		return handleResultFromExtension(context.call("getAnonymous", id), Boolean) as Boolean;
	}
	public function set anonymous(value:Boolean):void {
		handleResultFromExtension(context.call("setAnonymous", id, value));
	}
	public function get secure():Boolean {
		return handleResultFromExtension(context.call("getSecure", id), String) as String;
	}
	public function set secure(value:Boolean):void {
		handleResultFromExtension(context.call("setSecure", id, value));
	}

	public function get sampleRate():Number {
		return handleResultFromExtension(context.call("getSampleRate", id), Number) as Number;
	}
	public function set sampleRate(value:Number):void {
		handleResultFromExtension(context.call("setSampleRate", id, value));
	}

	public function set campaign(value:String):void {
		throw new IllegalOperationError("Method not implemented yet.")
	}
	public function set referrer(value:String):void {
		throw new IllegalOperationError("Method not implemented yet.")
	}

	public function closeSession():void {
		handleResultFromExtension(context.call("closeSession", id));
	}
	public function startSession():void {
		handleResultFromExtension(context.call("startSession", id));
	}

	public function send(type:HitType, data:Hit):void {
	    handleResultFromExtension(context.call("trackData", type, data));
	}

	public function buildViewHit(screenName:String):IViewBuilder {
		return new ViewBuilder(this, screenName);
	}

	public function buildEventHit(category:String, action:String):IEventBuilder {
		return new EventBuilder(this, category, action);
	}

	public function buildExceptionHit(fatal:Boolean):IExceptionBuilder {
		return new ExceptionBuilder(this, fatal);
	}

	public function buildTimingHit(category:String, interval:uint):ITimingBuilder {
		return new TimingBuilder(this, category, interval);
	}

	public function buildSocialHit(network:String, action:String):ISocialBuilder {
		return new SocialBuilder(this, network, action);
	}

	public function buildTransactionHit(id:String, cost:Number):ITransactionBuilder {
		return new TransactionBuilder(this, id, cost);
	}

	public function dispose():void {
		disposeTimer();
		context = null;
	}

	private function parseAppDescriptor():void {
		const descriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
		const ns:Namespace = descriptor.namespace();
		if (appID == null) appID = descriptor.ns::id[0];
		appName = descriptor.ns::filename[0];
		appVersion = descriptor.ns::version[0];
	}
	private function createTimer():void {
		if (timeout == 0) return;
		timer = new Timer(timeout*1000, 1);
		timer.addEventListener(TimerEvent.TIMER, sessionTimerHandler);
		NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, appResumedHandler);
		NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, appSuspendedHandler);
	}
	private function disposeTimer():void {
		if (!timer) return;
		NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, appResumedHandler);
		NativeApplication.nativeApplication.removeEventListener(Event.DEACTIVATE, appSuspendedHandler);
		timer.removeEventListener(TimerEvent.TIMER, sessionTimerHandler);
		timer.stop();
		timer = null;
	}

	private function sessionTimerHandler(event:TimerEvent):void {
		startSession();
	}
	private function appResumedHandler(event:Event):void {
		if (timer)
			timer.stop();
	}
	private function appSuspendedHandler(event:Event):void {
		if (timer)
			timer.start();
	}
}
}
