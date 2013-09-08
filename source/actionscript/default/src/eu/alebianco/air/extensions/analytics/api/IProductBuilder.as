/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 11.41
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

/**
 * Concrete builder to create a product and add it to a transaction.
 * <p>It exposes methods to setup the optional parameters for the product.</p>
 */
public interface IProductBuilder {
	/**
	 * Sets the product category.
	 * @param category  the new value for category.
	 * @return itself
	 */
	function inCategory(category:String):IProductBuilder
	/**
	 * Builds a Product with the parameters in this builder.
	 * @return a new product.
	 * @throws ArgumentError if product sku  or name are null or empty
	 */
	function create():IProduct;
	/**
	 * Adds the generated product to the transaction that created it.
	 * @return the transaction builder which generated the product.
	 */
	function add():ITransactionBuilder;
}
}
