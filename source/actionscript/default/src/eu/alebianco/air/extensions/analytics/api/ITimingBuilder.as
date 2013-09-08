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

/**
 * Concrete builder to create and track timed events.
 * <p>It exposes methods to setup the optional parameters for a timed event.</p>
 */
public interface ITimingBuilder extends IHitBuilder {
	/**
	 * Sets the name for the Timing event this Builder will build.
	 * @param name the name of the timed event
	 * @return itself
	 */
	function withName(name:String):ITimingBuilder;
	/**
	 * Sets the label for the Timing event this Builder will build.
	 * @param label the label of the timed event
	 * @return itself
	 */
	function withLabel(label:String):ITimingBuilder;
}
}
