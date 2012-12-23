/**
 * Project: ${PROJECT_NAME}
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 12.10
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.Hit;
import eu.alebianco.air.extensions.analytics.api.IProductBuilder;
import eu.alebianco.air.extensions.analytics.api.ITransactionBuilder;
import eu.alebianco.air.extensions.analytics.enums.HitType;

internal class TransactionBuilder implements ITransactionBuilder {

	private var tracker:Tracker;

	internal var id:String;
	internal var cost:Number;
	internal var affiliation:String = null;
	internal var shipping:Object = null;
	internal var tax:Object = null;

	private var _products:Array;

	internal function get products():Array {
		return _products ||= [];
	}

	public function TransactionBuilder(tracker:Tracker, id:String, cost:Number) {
		this.tracker = tracker;
		this.id = id;
		this.cost = cost;
	}

	public function withAffiliation(affiliation:String):ITransactionBuilder {
		this.affiliation = affiliation;
		return this;
	}
	public function withShippingCost(cost:Number):ITransactionBuilder {
		this.shipping = cost;
		return this;
	}
	public function withTaxCost(cost:Number):ITransactionBuilder {
		this.tax = cost;
		return this;
	}

	public function createProduct(sku:String, name:String, price:Number, quantity:uint):IProductBuilder {
		return new ProductBuilder(this, sku, name, price, quantity);
	}

	public function create():Hit {
		return new Transaction(this);
	}

	public function track():void {
		tracker.send(HitType.TRANSACTION, create());
	}
}
}
