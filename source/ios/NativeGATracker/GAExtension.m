/*
 * Air Native Extension for Google Analytics on iOS and Android
 * 
 * Author: Alessandro Bianco
 * http://alessandrobianco.eu
 *
 * Copyright (c) 2012 Alessandro Bianco
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "GAExtension.h"

void GAContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering %s", __func__);
    
    static FRENamedFunction functionMap[] = {
        MAP_FUNCTION( isSupported, NULL ),
        MAP_FUNCTION( startNewSession, NULL ),
        MAP_FUNCTION( stopSession, NULL ),
        MAP_FUNCTION( dispatch, NULL ),
        MAP_FUNCTION( setSampleRate, NULL ),
        MAP_FUNCTION( getSampleRate, NULL ),
        MAP_FUNCTION( setCustomVar, NULL ),
        MAP_FUNCTION( getCustomVar, NULL ),
        MAP_FUNCTION( setDebug, NULL ),
        MAP_FUNCTION( getDebug, NULL ),
        MAP_FUNCTION( setDryRun, NULL ),
        MAP_FUNCTION( getDryRun, NULL ),
        MAP_FUNCTION( setAnonymizeIp, NULL ),
        MAP_FUNCTION( trackPageView, NULL ),
        MAP_FUNCTION( trackEvent, NULL )
    };
    
	*numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
	*functionsToSet = functionMap;
    
    NSLog(@"Exiting %s", __func__);
}

void GAContextFinalizer(FREContext ctx)
{
    NSLog(@"Entering %s", __func__);
    
    [[GANTracker sharedTracker] stopTracker];
    
    NSLog(@"Exiting %s", __func__);
    
	return;
}

void GAExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) 
{ 
    NSLog(@"Entering %s", __func__);
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &GAContextInitializer;
    *ctxFinalizerToSet = &GAContextFinalizer;
    
    NSLog(@"Exiting %s", __func__);
}

void GAExtensionFinalizer()
{
    NSLog(@"Entering %s", __func__);
    
    // Nothing to clean up.
    
    NSLog(@"Exiting %s", __func__);
    return;
}
