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

import eu.alebianco.air.extensions.analytics.api.IProduct;
import eu.alebianco.air.extensions.analytics.api.ITransactionBuilder;

internal class TransactionBuilder implements ITransactionBuilder {

	private var tracker:Tracker;

	internal var id:String;
	internal var cost:Number;
	internal var affiliation:String;
	internal var shipping:Number;
	internal var tax:Number;

	private var _products:Array;

	public function TransactionBuilder(tracker:Tracker, id:String, cost:Number) {
		this.tracker = tracker;
		this.id = id;
		this.cost = cost;
	}

	internal function get products():Array {
		return _products ||= [];
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
	public function addProduct(product:IProduct):ITransactionBuilder {
		this.products.push(product);
		return this;
	}

	public function create():Hit {
		return new TransactionHit(this);
	}

	public function track():void {
		tracker.send(HitType.TRANSACTION, create());
	}
}
}
