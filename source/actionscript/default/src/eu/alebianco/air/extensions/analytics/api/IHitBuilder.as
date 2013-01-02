/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 01.04
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

/**
 * An abstract builder.
 * <p>Defines common methods shared by all the builders.</p>
 */
public interface IHitBuilder {
	/**
	 * Builds a Hit with the parameters in this builder.
	 * @return the data model.
	 * @throws ArgumentError if some of the data is invalid.
	 */
	function create():Hit;
	/**
	 * Sends the generated hit to to Google Analytics.
	 */
	function track():void;
}
}
