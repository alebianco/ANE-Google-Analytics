/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 04/06/14 16.34
 */
package eu.alebianco.air.extensions.analytics.api {

import eu.alebianco.core.IDisposable;

public interface IAnalytics extends IDisposable {
	
	function get version():String;
}
}