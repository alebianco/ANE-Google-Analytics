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

internal class SocialHit extends Hit {

	private var _network:String;
	private var _action:String;
	private var _content:String;

	public function SocialHit(builder:SocialBuilder) {

		_network = builder.network;
		_action = builder.action;
		_content = builder.content;
	}

	override internal function get arguments():Array {
		return [_network, _action, _content];
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
