/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 00.22
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.Hit;

internal class Event implements Hit {

	private var _category:String;
	private var _action:String;
	private var _label:String;
	private var _value:Object;

	public function Event(builder:EventBuilder) {
		_category = builder.category;
		_action = builder.action;
		_label = builder.label;
		_value = builder.value;
	}

	public function get category():String {
		return _category;
	}
	public function get action():String {
		return _action;
	}
	public function get label():String {
		return _label;
	}
	public function get value():Number {
		return Number(_value);
	}
}
}
