/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 04/06/14 16.21
 */
package eu.alebianco.air.extensions.analytics {

import avmplus.getQualifiedClassName;

import eu.alebianco.air.extensions.analytics.api.IAnalytics;

import flash.events.StatusEvent;

import flash.external.ExtensionContext;

import mx.logging.ILogger;

import mx.logging.Log;

public final class Analytics implements IAnalytics {

    private static const EXTENSION_ID:String = EXTENSION::id;

	private static var instance:Analytics;
	private static var canBuild:Boolean;

    private var logger:ILogger;

    private var context:ExtensionContext;
	
	public static function getInstance():Analytics {
		if (!instance) {
			canBuild = true;
			instance = new Analytics();
			canBuild = false;
		}
		return instance;
	}

	public static function isSupported():Boolean {
        const context:ExtensionContext = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
        const result:Boolean = context.call("isSupported") as Boolean;
        context.dispose();
        return result;
	}

	public function Analytics() {
		if (!canBuild) {
            throw new Error("Can't instantiate a Singleton class, use getInstance() to get a reference.");
        }

        if (!context) {
            context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
            context.addEventListener(StatusEvent.STATUS, statusHandler);
        }

        logger = Log.getLogger(getQualifiedClassName(this).replace("::", "."));
	}

	public function dispose():void {
        context.removeEventListener(StatusEvent.STATUS, statusHandler);
        context.dispose();
        context = null;
        logger = null;
        instance = null;
	}

	public function get version():String {
		return context.call("getVersion") as String;
	}

    private function statusHandler(event:StatusEvent):void {
        trace(event);
    }
}
}