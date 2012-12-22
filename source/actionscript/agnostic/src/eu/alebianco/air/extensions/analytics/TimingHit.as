/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 12.04
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

internal class TimingHit extends Hit {

	private var _category:String;
	private var _interval:uint;
	private var _name:String;
	private var _label:String;

	public function TimingHit(builder:TimingBuilder) {

		_category = builder.category;
		_interval = builder.interval;
		_name = builder.name;
		_label = builder.label;
	}

	override internal function get arguments():Array {
		return [_category, _interval, _name, _label];
	}

	public function get category():String {
		return _category;
	}
	public function get interval():uint {
		return _interval;
	}
	public function get name():String {
		return _name;
	}
	public function get label():String {
		return _label;
	}
}
}
