/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 12.13
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

internal class TransactionHit extends Hit {

	private static const ID_VALIDATOR:RegExp = /.+/i;

	private var _id:String;
	private var _cost:Number;
	private var _affiliation:String;
	private var _shipping:Number;
	private var _tax:Number;
	private var _products:Array;

	public function TransactionHit(builder:TransactionBuilder) {

		if (!(builder.id && ID_VALIDATOR.text(builder.id)))
			throw new ArgumentError("Transaction ID is invalid: must be not null or a empty string.");

		_id = builder.id;
		_cost = builder.cost;
		_affiliation = builder.affiliation;
		_shipping = builder.shipping;
		_tax = builder.tax;
		_products = builder.products;
	}

	override internal function get arguments():Array {
		return [_id, _cost, _affiliation, _shipping, _tax, _products];
	}

	public function get id():String {
		return _id;
	}
	public function get cost():Number {
		return _cost;
	}
	public function get affiliation():String {
		return _affiliation;
	}
	public function get shipping():Number {
		return _shipping;
	}
	public function get tax():Number {
		return _tax;
	}
	public function get products():Array {
		return _products;
	}
}
}
