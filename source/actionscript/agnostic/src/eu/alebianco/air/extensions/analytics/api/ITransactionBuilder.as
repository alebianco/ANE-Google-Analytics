/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 11.36
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

public interface ITransactionBuilder extends IHitBuilder {
	function withAffiliation(affiliation:String):ITransactionBuilder;
	function withShippingCost(cost:Number):ITransactionBuilder;
	function withTaxCost(cost:Number):ITransactionBuilder;

	function addProduct(product:IProduct):ITransactionBuilder;
}
}
