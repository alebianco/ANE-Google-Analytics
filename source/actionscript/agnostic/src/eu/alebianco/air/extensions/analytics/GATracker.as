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
	import eu.alebianco.air.extensions.analytics.enum.StatusLevel;
	import eu.alebianco.air.extensions.analytics.enum.VariableScope;
	import eu.alebianco.air.extensions.analytics.enum.VariableSlot;
	import eu.alebianco.air.extensions.analytics.ns.logStatusLevel;
	import eu.alebianco.core.IDisposable;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public final class GATracker implements IDisposable
	{
		private static const VERSION:String = "1.1";

        private static const GA_ID_VALIDATOR:RegExp = /^UA-\d{4,10}-\d{1,4}$/i
		private static const EXTENSION_ID:String = "eu.alebianco.air.extensions.analytics.NativeGATracker";
		
		private static var instance:GATracker;
		private static var canBuild:Boolean;
		
		private var logger:ILogger;
		
		private var context:ExtensionContext;
		
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
		
		public static function isSupported():Boolean
		{
			var supported:Boolean;
			
			try
			{
				getInstance();
				supported = instance.context.call("isSupported") == true;
			}
			catch(error:Error)
			{
				supported = false;
			}
			
			return supported;
		}
		
		public function GATracker()
		{
			if (!canBuild)
			{
				throw new Error("Can't instantiate a Singleton class, use getInstance() to get a reference.");
			}
			
			if (!context) 
			{
				context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
				context.addEventListener(StatusEvent.STATUS, statusHandler);
			}
			
			var className:String = getQualifiedClassName(this).replace("::", ".");
			logger = Log.getLogger(className);
		}
		
		public function dispose():void {
			
			dispatch();
			stopSession();
			context.removeEventListener(StatusEvent.STATUS, statusHandler);
			context = null;
			instance = null;
		}
		
		private function statusHandler(event:StatusEvent):void {
			
			var level:StatusLevel = StatusLevel.parseConstant(event.level);
			if (level)
			{
				var ns:Namespace = level.ns;
				ns::processStatusEvent(level.name, event.code);
			}
		}
		
		logStatusLevel function processStatusEvent(level:String, code:String):void
		{
			switch(level.toUpperCase())
			{
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
					logger.debug("Level ("+level+") not found.");
					break;
			}
		}
		
		private function handleResult(result:Object, expected:Class = null):*
		{
			if (result is Error)
			{
				throw result as Error;
			}

			if (result && expected && !(result is expected))
			{
				throw new ArgumentError("Method call returned an unexpected value type.");
			}

			return expected ? expected(result) : result;
		}
		
		public function get version():String {
			
			var nativeVersion:String;
			
			try 
			{
				nativeVersion = handleResult(context.call("getVersion"), String) as String;
			}
			catch(error:Error)
			{
				nativeVersion = "<unknown>";
			}
			
			return "GATracker v" + VERSION + "\n using '" + nativeVersion + "'";
		}
		
		public function startNewSession(accountID:String, interval:int = 20):void 
		{
            if (GA_ID_VALIDATOR.test(accountID)) {
			    handleResult(context.call("startNewSession", accountID.toUpperCase(), interval));
            } else {
                throw new ArgumentError("The provided account ID is invalid, it should follow the format UA-00000-0.")
            }
		}
		
		public function stopSession():void
		{
			handleResult(context.call("stopSession"));
		}
		
		public function dispatch():Boolean
		{
			return handleResult(context.call("dispatch"), Boolean) as Boolean;
		}
		
		public function get sampleRate():Number
		{
			var value:int = handleResult(context.call("getSampleRate"), int) as int;
			return  value / 100;
		}

		public function set sampleRate(value:Number):void
		{
			var normalized:int = int(Math.max(1, Math.max(0, value)) * 100);
			handleResult(context.call("setSampleRate", normalized));
		}
		
		public function setCustomVar(slot:VariableSlot, name:String, value:String, scope:VariableScope = null):void
		{
			handleResult(context.call("setCustomVar", slot.value, name, value, (scope) ? scope.value : VariableScope.PAGE.value));
		}
		
		public function getCustomVar(index:int):String
		{
			return handleResult(context.call("getCustomVar", index), String) as String;
		}
		
		public function set debug(value:Boolean):void
		{
			handleResult(context.call("setDebug", value));
		}
		
		public function get debug():Boolean
		{
			return handleResult(context.call("getDebug"), Boolean) as Boolean;
		}
		
		public function set dryRun(value:Boolean):void
		{
			handleResult(context.call("setDryRun", value));
		}
		
		public function get dryRun():Boolean
		{
			return handleResult(context.call("getDryRun"), Boolean) as Boolean;
		}
		
		public function set anonymizeIp(value:Boolean):void
		{
			handleResult(context.call("setAnonymizeIp", value));
		}
		
		public function trackPageView(uri:String):void
		{
			handleResult(context.call("trackPageView", uri), Boolean);
		}
		
		public function trackEvent(category:String, action:String, label:String = "", value:int = -1):void
		{
			handleResult(context.call("trackEvent", category, action, label, value), Boolean);
		}
	}
}