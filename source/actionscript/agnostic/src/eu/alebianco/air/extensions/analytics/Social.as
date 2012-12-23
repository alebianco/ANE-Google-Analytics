/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 12.08
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.Hit;

internal class Social implements Hit {

	private var _network:String;
	private var _action:String;
	private var _content:String;

	public function Social(builder:SocialBuilder) {

		_network = builder.network;
		_action = builder.action;
		_content = builder.content;
	}

	public function get network():String {
		return _network;
	}
	public function get action():String {
		return _action;
	}
	public function get content():String {
		return _content;
	}
}
}
