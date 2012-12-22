/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 11.29
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

public interface ITimingBuilder extends IHitBuilder {
	function withName(name:String):ITimingBuilder;
	function withLabel(label:String):ITimingBuilder;
}
}
