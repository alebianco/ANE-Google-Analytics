/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 04/06/14 16.21
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.IAnalytics;

public final class Analytics implements IAnalytics {
	private static var instance:Analytics;
	private static var canBuild:Boolean;

	public static function getInstance():Analytics {
		if (!instance) {
			canBuild = true;
			instance = new Analytics();
			canBuild = false;
		}
		return instance;
	}

	public static function isSupported():Boolean {
		return false;
	}

	public function Analytics() {
		if (!canBuild)
			throw new Error("Can't instantiate a Singleton class, use getInstance() to get a reference.");
	}

	public function dispose():void {

	}

	public function get version():String {
		return PRODUCT::name + " v" + PRODUCT::version;
	}
}
}