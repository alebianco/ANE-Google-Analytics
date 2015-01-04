//
//  GAContext.m
//  ANELytics
//
//  Created by Alessandro Bianco on 15/12/2014.
//  Copyright (c) 2014 Alessandro Bianco. All rights reserved.
//

#import "GAContext.h"

@implementation GAContext

void GAContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    static FRENamedFunction functionMap[] = {
        MAP_FUNCTION( isSupported, NULL ),
        MAP_FUNCTION( initialise, NULL ),
        MAP_FUNCTION( getVersion, NULL ),
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}

void GAContextFinalizer(FREContext ctx) {
    return;
}

@end
