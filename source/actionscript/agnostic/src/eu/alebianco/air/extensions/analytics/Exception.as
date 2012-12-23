/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 11.54
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.Hit;

internal class Exception implements Hit {

	private var _fatal:Boolean;
	private var _description:String;

	public function Exception(builder:ExceptionBuilder) {
		_fatal = builder.fatal;
		_description = builder.description;
	}

	public function get fatal():Boolean {
		return _fatal;
	}
	public function get description():String {
		return _description;
	}
}
}
