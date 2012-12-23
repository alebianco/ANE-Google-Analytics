/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 0.33
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

public interface IEventBuilder extends IHitBuilder {
	function withLabel(label:String):IEventBuilder;
	function withValue(value:int):IEventBuilder;
}
}
