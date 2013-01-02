/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 17.14
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

internal function handleResultFromExtension(result:Object, expected:Class = null):* {
	if (result is Error)
		throw result as Error;

	if (result && expected && !(result is expected))
		throw new ArgumentError("Method call returned an unexpected value type.");

	return result && expected ? expected(result) : result;
}
}