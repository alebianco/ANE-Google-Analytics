/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 11.31
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

/**
 * Concrete builder to create and track social interactions.
 * <p>It exposes methods to setup the optional parameters for a social interaction.</p>
 */
public interface ISocialBuilder extends IHitBuilder {
	/**
	 * Sets the content for the Social interaction this Builder will build.
	 * @param content represents the content on which the social action is being taken (i.e. a specific article or video).
	 * @return itself
	 */
	function forContent(content:String):ISocialBuilder;
}
}
