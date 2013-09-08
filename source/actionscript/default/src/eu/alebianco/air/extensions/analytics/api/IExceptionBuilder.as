/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 11.28
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

/**
 * Concrete builder to create and track exceptions.
 * <p>It exposes methods to setup the optional parameters for an exception.</p>
 */
public interface IExceptionBuilder extends IHitBuilder {
	/**
	 * Sets the description for the Exception this Builder will build.
	 * @param description a description for the current exception (up to 100 characters).
	 * @return itself
	 */
	function withDescription(description:String):IExceptionBuilder;
}
}
