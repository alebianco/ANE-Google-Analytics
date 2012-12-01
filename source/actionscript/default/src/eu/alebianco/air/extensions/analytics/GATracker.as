/*
 * Air Native Extension for Google Analytics on iOS and Android
 * 
 * Author: Alessandro Bianco
 * http://alessandrobianco.eu
 *
 * Copyright (c) 2012 Alessandro Bianco
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package eu.alebianco.air.extensions.analytics
{
	import eu.alebianco.air.extensions.analytics.enum.VariableScope;
	import eu.alebianco.air.extensions.analytics.enum.VariableSlot;
	import eu.alebianco.core.IDisposable;

import flash.external.ExtensionContext;

/**
	 * Provide means to build typesafe enumerations in <code>ActionScript</code>.
	 * 
	 * <p>
	 * This class works as a <i>Singleton</i> and shouldn't be instantiated 
	 * directly. The getInstance() static method should be used to get a 
	 * reference to the unique instance of the class.
	 * </p>
	 * <p>
	 * The Singleton approach is required by the underlying architecture of the
	 * Google Analytics mobile SDKs.
	 * </p>
	 * 
	 * @langversion 	ActionScript 3.0
     * @playerversion 	AIR 3.1
	 * @author 			Alessandro Bianco - cyberpunk
	 * @version 		0.1.0
	 * @date			22.03.2012
	 * @tiptext
	 */
	public final class GATracker implements IDisposable
	{
		
		private static const VERSION:String = "1.1";
		
		private static var instance:GATracker;
		private static var canBuild:Boolean;

        private var context:ExtensionContext;
		
		/**
		 * Get a reference to the current instance of the tracker, or creates
		 * a new one if none exists.
		 * 
		 * @returns the reference to the current tracker.
		 * 
		 * @langversion 	ActionScript 3.0
		 * @playerversion 	AIR 3.1
		 * @tiptext
		 */
		public static function getInstance():GATracker
		{
			if (!instance)
			{
				canBuild = true;
				instance = new GATracker();
				canBuild = false;
			}
			return instance;
		}
		
		/**
		 * Checks if the tracker is supported in the current platform.
		 * 
		 * @returns whether the current platform is supported or not.
		 * 
		 * @langversion 	ActionScript 3.0
		 * @playerversion 	AIR 3.1
		 * @tiptext
		 */
		public static function isSupported():Boolean
		{
			return false;
		}
		
		/**
		 * Tracker constructor.
		 * 
		 * <p>
		 * Can't be instantiated directly, should use the getInstance() method that
		 * will enforce the presence of a single instance throughout the application.
		 * </p>
		 * 
		 * @see #getInstance()
		 * 
		 * @throws Error The class has been instantiated directly instead of calling
		 * the getInstance() method.
		 * 
		 * @langversion 	ActionScript 3.0
		 * @playerversion 	AIR 3.1
		 * @tiptext
		 */
		public function GATracker()
		{
			if (!canBuild)
			{
				throw new Error("Can't instantiate a Singleton class, use getInstance() to get a reference.");
			}
		}
		
		/**
		 * Returns the extension version and the Google Analytics SDK versions if available.
		 * 
		 * @langversion 	ActionScript 3.0
		 * @playerversion 	AIR 3.1
		 * @tiptext
		 */
		public function get version():String {
			
			return "GATracker v" + VERSION + "";
		}
		
		/**
		 * Stops the current trakcer session and destroy the native extensions,
		 * freeing up the resources allocated for it.
		 * 
		 * <p>
		 * If another tracker is needed later, just call getInstance() again and both
		 * extension and tracker will be recreated.
		 * </p>
		 * 
		 * @see #getInstance()
		 * 
		 * @langversion 	ActionScript 3.0
		 * @playerversion 	AIR 3.1
		 * @tiptext
		 */
		public function dispose():void {
			
		}
		
		/**
		 * Starts a new tracking session.
		 * 
		 * @see #dispatch()
		 * 
		 * @param accountID The Google Analytics account ID where the tracked values will be logged.
		 * @param interval The amount of seconds between dispatches. Use 0 for manual dispatch.
		 * 
		 * @langversion 	ActionScript 3.0
		 * @playerversion 	AIR 3.1
		 * @tiptext
		 */
		public function startNewSession(accountID:String, interval:int = 20):void 
		{
			
		}
		
		/**
		 * Stops the current tracking session.
		 * <p>
		 * Calling a tracking method without an active session will result in the data
		 * not being logged on Google Analytics.
		 * </p>
		 * 
		 * @langversion 	ActionScript 3.0
		 * @playerversion 	AIR 3.1
		 * @tiptext
		 */
		public function stopSession():void
		{
			
		}
		
		/**
		 * Sends the stored tracked events to the Google Analytics website.
		 * 
		 * @return whether the operation was successful or not.
		 * 
		 * @langversion 	ActionScript 3.0
		 * @playerversion 	AIR 3.1
		 * @tiptext
		 */
		public function dispatch():Boolean
		{
			return false;
		}
		
		public function get sampleRate():Number
		{
			return  0;
		}

		public function set sampleRate(value:Number):void
		{
			
		}
		
		public function setCustomVar(slot:VariableSlot, name:String, value:String, scope:VariableScope = null):void
		{
			
		}
		
		public function getCustomVar(index:int):String
		{
			return "";
		}
		
		public function set debug(value:Boolean):void
		{
			
		}
		
		public function get debug():Boolean
		{
			return false;
		}
		
		public function set dryRun(value:Boolean):void
		{
			
		}
		
		public function get dryRun():Boolean
		{
			return false;
		}
		
		public function set anonymizeIp(value:Boolean):void
		{
			
		}
		
		public function trackPageView(uri:String):void
		{
			
		}
		
		public function trackEvent(category:String, action:String, label:String = "", value:int = -1):void
		{
			
		}
	}
}