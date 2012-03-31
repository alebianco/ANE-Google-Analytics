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

#import "Track.h"

@implementation Track

DEFINE_ANE_FUNCTION(trackPageView)
{
    if (argv == NULL || argc < 1) {
        logEvent(context, kFatal, @"Invalid arguments number for method '%s'", __func__);
        return NULL;
    }
    
    FREObject result = NULL;
    
    NSString *page = NULL;
    
    @try
    {
        page = [FREConversionUtil extractString:argv[0]];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to read the 'page' parameter.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        return NULL;
    }
    
    NSError *error;
    BOOL success = [[GANTracker sharedTracker] trackPageview:page withError:&error];
    if (error != nil) logEvent(context, kError, @"%@", [error localizedDescription]);
    
    @try
    {
        result = [FREConversionUtil convertBoolean:success];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to create the return value.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        return NULL;
    }
    
    return result;
}

DEFINE_ANE_FUNCTION(trackEvent)
{
    if (argv == NULL || argc < 2) {
        logEvent(context, kFatal, @"Invalid arguments number for method '%s'", __func__);
        return NULL;
    }
    
    FREObject result = NULL;
    
    NSString *category;
    NSString *action;
    NSString *label = nil;
    NSInteger value = -1;
    
    @try
    {
        category = [FREConversionUtil extractString:argv[0]];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to read the 'category' parameter.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        return NULL;
    }
    
    @try
    {
        action = [FREConversionUtil extractString:argv[1]];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to read the 'action' parameter.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        return NULL;
    }
    
    if (argc >= 3 && argv[2] != NULL) {
        
        @try
        {
            label = [FREConversionUtil extractString:argv[2]];
        }
        @catch (NSException *exception)
        {
            logEvent(context, kWarn, @"Unable to read the 'label' parameter, using default value.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        }
    }
    
    if (argc >= 4 && argv[3] != NULL) {
        
        @try
        {
            value = [FREConversionUtil extractInt:argv[3]];
        }
        @catch (NSException *exception)
        {
            logEvent(context, kWarn, @"Unable to read the 'value' parameter, using default value.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        }
    }
    
    NSError *error;
    BOOL success = [[GANTracker sharedTracker] trackEvent:category action:action label:label value:value withError:&error];
    if (error != nil) logEvent(context, kError, @"%@", [error localizedDescription]);
    
    @try
    {
        result = [FREConversionUtil convertBoolean:success];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to create the return value.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        return NULL;
    }
    
    return result;
}

@end
