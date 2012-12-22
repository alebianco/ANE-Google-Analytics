package eu.alebianco.air.extensions.analytics {

internal function handleResultFromExtension(result:Object, expected:Class = null):* {
	if (result is Error)
		throw result as Error;

	if (result && expected && !(result is expected))
		throw new ArgumentError("Method call returned an unexpected value type.");

	return expected ? expected(result) : result;
}
}