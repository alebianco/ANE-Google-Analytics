/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 26/12/12 16.04
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import "GAExtension.h"

void GAContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    static FRENamedFunction functionMap[] = {
            MAP_FUNCTION( isSupported, NULL ),
            MAP_FUNCTION( GA_getVersion, NULL ),

            MAP_FUNCTION( createTracker, NULL ),
            MAP_FUNCTION( closeTracker, NULL ),
            MAP_FUNCTION( setDebug, NULL ),
            MAP_FUNCTION( getDebug, NULL ),
            MAP_FUNCTION( setOptOut, NULL ),
            MAP_FUNCTION( getOptOut, NULL ),
            MAP_FUNCTION( getDebug, NULL ),
            MAP_FUNCTION( setDispatchInterval, NULL ),
            MAP_FUNCTION( dispatch, NULL ),

            MAP_FUNCTION( setAppName, NULL),
            MAP_FUNCTION( GA_setAppVersion, NULL ),
            MAP_FUNCTION( getAppID, NULL ),
            MAP_FUNCTION( setAppID, NULL ),
            MAP_FUNCTION( startNewSession, NULL),

            MAP_FUNCTION( trackData, NULL ),
            MAP_FUNCTION( setCustomDimension, NULL ),
            MAP_FUNCTION( clearCustomDimension, NULL ),
            MAP_FUNCTION( setCustomMetric, NULL ),
            MAP_FUNCTION( clearCustomMetric, NULL ),

            MAP_FUNCTION( getCampaignData, NULL ),
            MAP_FUNCTION( setCampaignData, NULL ),
            MAP_FUNCTION( getReferrer, NULL ),
            MAP_FUNCTION( setReferrer, NULL ),
    };

    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}

void GAContextFinalizer(FREContext ctx) {
    return;
}

void GAExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    extDataToSet = NULL;
    *ctxInitializerToSet = &GAContextInitializer;
    *ctxFinalizerToSet = &GAContextFinalizer;
}

void GAExtensionFinalizer() {
    return;
}
