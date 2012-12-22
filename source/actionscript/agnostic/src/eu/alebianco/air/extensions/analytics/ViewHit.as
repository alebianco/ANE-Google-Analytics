/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 0.22
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

internal class ViewHit extends Hit {

	private var _screen:String;

	public function ViewHit(builder:ViewBuilder) {
		_screen = builder.screen;
	}

	override internal function get arguments():Array {
		return [_screen];
	}

	public function get screen():String {
		return _screen;
	}
}
}
