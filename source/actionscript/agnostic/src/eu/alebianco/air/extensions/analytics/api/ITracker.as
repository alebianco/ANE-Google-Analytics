/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 18.43
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

import eu.alebianco.core.IDisposable;

public interface ITracker extends IDisposable {

	function get trackingID():String;

	function get sessionTimeout():uint;
	function set sessionTimeout(value:uint):void;

	function get appID():String;
	function set appID(value:String):void;

	function set appName(value:String):void;
	function get appName():String;

	function set appVersion(value:String):void;
	function get appVersion():String;

	function get sampleRate():Number;
	function set sampleRate(value:Number):void;

	function get secure():Boolean;
	function set secure(value:Boolean):void;

	function get anonymous():Boolean;
	function set anonymous(value:Boolean):void;

	function startNewSession():void;

	function setCustomMetric(index:uint, value:int):void;
	function setCustomDimension(index:uint, value:String):void;
	function clearCustomMetric(index:uint):void;
	function clearCustomDimension(index:uint):void;

	function buildEvent(category:String, action:String):IEventBuilder;
	function buildView(screenName:String):IViewBuilder;
	function buildException(fatal:Boolean):IExceptionBuilder;
	function buildTiming(category:String, interval:uint):ITimingBuilder;
	function buildSocial(network:String, action:String):ISocialBuilder;
	function buildTransaction(id:String, cost:Number):ITransactionBuilder;
}
}
