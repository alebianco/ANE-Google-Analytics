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

internal class ExceptionHit extends Hit {

	private var _fatal:Boolean;
	private var _description:String;

	public function ExceptionHit(builder:ExceptionBuilder) {
		_fatal = builder.fatal;
		_description = builder.description;
	}

	override internal function get arguments():Array {
		return [_fatal, _description];
	}

	public function get fatal():Boolean {
		return _fatal;
	}
	public function get description():String {
		return _description;
	}
}
}
