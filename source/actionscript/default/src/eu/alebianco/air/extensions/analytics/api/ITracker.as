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

/**
 * Tracks screens, events, transactions, timing, and exceptions data to the requested Google Analytics account.
 */
public interface ITracker extends IDisposable {
	/**
	 * The Google Analytics account to which the data will be sent.
	 */
	function get trackingID():String;
	/**
	 * Indicates the interval of time, in seconds, of inactivity (application in background) after which a new session is started.
	 * @see https://developers.google.com/analytics/devguides/collection/ios/v2/sessions
	 * @default 30
	 */
	function get sessionTimeout():uint;
	/**
	 * @private
	 */
	function set sessionTimeout(value:uint):void;
	/**
	 * The application ID.
	 * <p>If not set by the Google tracker, it will be retrieved from the application descriptor.</p>
	 * <p>Note that if you wish to override it, you should do it before tracking any data.</p>
	 */
	function get appID():String;
	/**
	 * @private
	 */
	function set appID(value:String):void;
	/**
	 * The application name.
	 * <p>By default it will be retrieved from the application descriptor.</p>
	 * <p>Note that if you wish to override it, you should do it before tracking any data.</p>
	 */
	function set appName(value:String):void;
	/**
	 * @private
	 */
	function get appName():String;
	/**
	 * The application version.
	 * <p>By default it will be retrieved from the application descriptor.</p>
	 * <p>Note that if you wish to override it, you should do it before tracking any data.</p>
	 */
	function get appVersion():String;
	/**
	 * @private
	 */
	function set appVersion(value:String):void;
	/**
	 * Controls the probability that the client will be sampled.
	 * <p>SampleRate may be set to any value between 0 and 100, inclusive. * A value of 90 means 90% of visitors should
	 * be sampled (10% of visitors to be sampled out).</p>
	 * @default 100
	 */
	function get sampleRate():Number;
	/**
	 * @private
	 */
	function set sampleRate(value:Number):void;
	/**
	 * Indicates if a secure connection should be used.
	 * <p>Tracking information collected while this is true will be submitted to Google Analytics using HTTPS
	 * connection(s); otherwise, HTTP will be used.</p>
	 * @default false
	 */
	function get secure():Boolean;
	/**
	 * @private
	 */
	function set secure(value:Boolean):void;
	/**
	 * Indicates if the anonymous mode is enabled.
	 * <p>When the anonymous mode is enabled, Google Analytics will anonymize the IP address information collected by
	 * zeroing out some of the least significant bits of the address.</p>
	 * @default false
	 */
	function get anonymous():Boolean;
	/**
	 * @private
	 */
	function set anonymous(value:Boolean):void;
	/**
	 * Specifies whether a new session should be started.
	 * <p>This method does not send a hit, but will add a parameters to the next hit marking it as the beginning
	 * of a new session.</p>
	 * <p>Note that when a tracker is first instantiated, this is initialized to true.</p>
	 */
	function startNewSession():void;
	/**
	 * Sets the value for a custom metric.
	 * <p>Note that all custom metrics are sent with the next hit then cleared.</p>
	 * @see https://developers.google.com/analytics/devguides/collection/ios/v2/customdimsmets
	 * @param index the metric slot, must be greater then one.
	 * @param value the metric value.
	 * @throws ArgumentError if the index is lower than one.
	 */
	function setCustomMetric(index:uint, value:int):void;
	/**
	 * Sets the value for a custom dimension.
	 * <p>Note that all custom metrics are sent with the next hit then cleared.</p>
	 * @see https://developers.google.com/analytics/devguides/collection/ios/v2/customdimsmets
	 * @param index the metric slot, must be greater then one.
	 * @param value the metric value.
	 * @throws ArgumentError if the index is lower than one.
	 */
	function setCustomDimension(index:uint, value:String):void;
	/**
	 * Clears the value for a custom metric.
	 * @see https://developers.google.com/analytics/devguides/collection/ios/v2/customdimsmets
	 * @param index the metric slot, must be greater then one.
	 * @throws ArgumentError if the index is lower than one.
	 */
	function clearCustomMetric(index:uint):void;
	/**
	 * Clears the value for a custom dimension.
	 * @see https://developers.google.com/analytics/devguides/collection/ios/v2/customdimsmets
	 * @param index the metric slot, must be greater then one.
	 * @throws ArgumentError if the index is lower than one.
	 */
	function clearCustomDimension(index:uint):void;
	/**
	 * Creates a builder, with the mandatory parameters, to setup all the model fields for an Event hit and then sending it.
	 * <p>Events can be used to track events such as button presses or other user interactions with your application.</p>
	 * @see IEventBuilder
	 * @see https://developers.google.com/analytics/devguides/collection/ios/v2/events
	 * @param category the event category.
	 * @param action the event action.
	 * @return a builder to help setup the optional fields and send the hit.
	 * @example
	 * <listing version="3.0">
	 * var tracker:ITracker = Analytics.getInstance().getTracker("UA-0000-0");
	 * tracker.buildEvent("click", "button").withLabel("stop").withValue(2).track();
	 * </listing>
	 */
	function buildEvent(category:String, action:String):IEventBuilder;
	/**
	 * Creates a builder, with the mandatory parameters, to setup all the model fields for a View hit and then sending it.
	 * <p>Collecting data about screen views allows you to see which content is being viewed most by your users, and
	 * how are they are navigating between different pieces of content.</p>
	 * @see IViewBuilder
	 * @see https://developers.google.com/analytics/devguides/collection/ios/v2/screens
	 * @param screenName the name of the section being viewed.
	 * @return a builder to help setup the optional fields and send the hit.
	 * @example
	 * <listing version="3.0">
	 * var tracker:ITracker = Analytics.getInstance().getTracker("UA-0000-0");
	 * tracker.buildView("home").track();
	 * </listing>
	 */
	function buildView(screenName:String):IViewBuilder;
	/**
	 * Creates a builder, with the mandatory parameters, to setup all the model fields for a Exception hit and then sending it.
	 * <p>Exceptions can be used to collect data on the number and type of crashes and exceptions that occur in
	 * your app.</p>
	 * @see IExceptionBuilder
	 * @see https://developers.google.com/analytics/devguides/collection/ios/v2/exceptions
	 * @param fatal true if it was a blocking error, false otherwise.
	 * @return a builder to help setup the optional fields and send the hit.
	 * @example
	 * <listing version="3.0">
	 * var tracker:ITracker = Analytics.getInstance().getTracker("UA-0000-0");
	 * tracker.buildException(false).withDescription("Some error occurred, but it wasn't so bad.").track();
	 * </listing>
	 */
	function buildException(fatal:Boolean):IExceptionBuilder;
	/**
	 * Creates a builder, with the mandatory parameters, to setup all the model fields for a Timing hit and then sending it.
	 * <p>Timings can be used to track period of times, such as the time spent loading assets.</p>
	 * @see ITimingBuilder
	 * @see https://developers.google.com/analytics/devguides/collection/ios/v2/usertimings
	 * @param category the timing category.
	 * @param interval the timing measurement, in seconds.
	 * @return a builder to help setup the optional fields and send the hit.
	 * @example
	 * <listing version="3.0">
	 * var tracker:ITracker = Analytics.getInstance().getTracker("UA-0000-0");
	 * tracker.buildTiming("loading", 7).withLabel("resources").withName("level-1").track();
	 * </listing>
	 */
	function buildTiming(category:String, interval:uint):ITimingBuilder;
	/**
	 * Creates a builder, with the mandatory parameters, to setup all the model fields for a Social hit and then sending it.
	 * <p>Collecting data about social interaction tracking allows you to track a user's interactions with various
	 * social network sharing and recommendation widgets embedded in your content.</p>
	 * @see ISocialBuilder
	 * @see https://developers.google.com/analytics/devguides/collection/ios/v2/social
	 * @param network represents the social network with which the user is interacting (e.g. Google+, Facebook, Twitter, etc.).
	 * @param action represents the social action taken (e.g. Like, Share, +1, etc.).
	 * @return a builder to help setup the optional fields and send the hit.
	 * @example
	 * <listing version="3.0">
	 * var tracker:ITracker = Analytics.getInstance().getTracker("UA-0000-0");
	 * tracker.buildSocial("Facebook", "like").forContent("http://alessandrobianco.eu").track();
	 * </listing>
	 */
	function buildSocial(network:String, action:String):ISocialBuilder;
	/**
	 * Creates a builder, with the mandatory parameters, to setup all the model fields for a Transaction hit and then sending it.
	 * <p>Ecommerce tracking allows you to track in-app purchases and sales. Ecommerce data in Google Analytics is
	 * generally comprised of transactions and items, related by a shared transaction ID, that relationship is
	 * established by creating a transaction object and adding items to it.</p>
	 * @see ITransactionBuilder
	 * @see https://developers.google.com/analytics/devguides/collection/ios/v2/ecommerce
	 * @param id identifier for the Transaction. transactionId must not be null or the empty string.
	 * @param cost the total cost for the Transaction (in your currency, will be translated in micros later).
	 * @return a builder to help setup the optional fields and send the hit.
	 * @example
	 * <listing version="3.0">
	 * var tracker:ITracker = Analytics.getInstance().getTracker("UA-0000-0");
	 * tracker.buildTransaction("id-0000", 10)
	 *        .withTaxCost(0.5)
	 *        .createProduct("cr-300", "300 credits pack", 7, 1).inCategory("credits").add()
	 *        .createProduct("it-156", "extra life item", 1.5, 2).add()
	 *        .track();
	 * </listing>
	 */
	function buildTransaction(id:String, cost:Number):ITransactionBuilder;
}
}
