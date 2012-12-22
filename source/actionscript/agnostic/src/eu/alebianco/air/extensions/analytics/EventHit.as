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

internal class EventHit extends Hit {

	private var _category:String;
	private var _action:String;
	private var _label:String;
	private var _value:Object;

	public function EventHit(builder:EventBuilder) {
		_category = builder.category;
		_action = builder.action;
		_label = builder.label;
		_value = builder.value;
	}

	override internal function get arguments():Array {
		return [_category, _action, _label, _value];
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
	public function get value():Object {
		return _value;
	}
}
}
