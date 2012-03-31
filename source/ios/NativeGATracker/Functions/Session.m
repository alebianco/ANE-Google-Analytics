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

#import "Session.h"

@implementation Session

DEFINE_ANE_FUNCTION(startNewSession)
{
    if (argv == NULL || argc < 2) {
        logEvent(context, kFatal, @"Invalid arguments number for method '%s'", __func__);
        return NULL;
    }
    
    NSString *account = nil;
    NSInteger interval = 0;
    
    @try
    {
        account = [FREConversionUtil extractString:argv[0]];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to read the 'account' parameter.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        return NULL;
    }
    
    @try
    {
        interval = [FREConversionUtil extractInt:argv[1]];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kWarn, @"Unable to read the 'interval' parameter, using default value.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
    }
    
    [[GANTracker sharedTracker] startTrackerWithAccountID:account dispatchPeriod:interval delegate:nil];
    return NULL;
}

DEFINE_ANE_FUNCTION(stopSession)
{
    [[GANTracker sharedTracker] stopTracker];
    return NULL;
}

DEFINE_ANE_FUNCTION(dispatch)
{
    FREObject result = NULL;
    BOOL success = [[GANTracker sharedTracker] dispatch];
    
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
