/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 00.33
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

/**
 * Concrete builder to create and track events.
 * <p>It exposes methods to setup the optional parameters for an event.</p>
 */
public interface IEventBuilder extends IHitBuilder {
	/**
	 * Sets the label for the Event this Builder will build.
	 * @param label the event label.
	 * @return itself
	 */
	function withLabel(label:String):IEventBuilder;
	/**
	 * Sets the value for the Event this Builder will build.
	 * @param value the event value.
	 * @return itself
	 */
	function withValue(value:int):IEventBuilder;
}
}
