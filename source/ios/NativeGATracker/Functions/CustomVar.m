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

#import "CustomVar.h"

@implementation CustomVar

DEFINE_ANE_FUNCTION(setCustomVar)
{
    if (argv == NULL || argc < 3) {
        logEvent(context, kFatal, @"Invalid arguments number for method '%s'", __func__);
        return NULL;
    }
    
    FREObject result;
    
    NSUInteger index;
    NSString *name;
    NSString *value;
    GANCVScope scope = kGANPageScope;
    
    @try
    {
        index = [FREConversionUtil extractUInt:argv[0]];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to read the 'index' parameter.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        return NULL;
    }
    
    @try
    {
        name = [FREConversionUtil extractString:argv[1]];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to read the 'name' parameter.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        return NULL;
    }
    
    @try
    {
        value = [FREConversionUtil extractString:argv[2]];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to read the 'value' parameter.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        return NULL;
    }
    
    if (argc >= 4 && argv[3] != NULL) {
        
        @try
        {
            scope = [FREConversionUtil extractInt:argv[3]];
        }
        @catch (NSException *exception)
        {
            logEvent(context, kWarn, @"Unable to read the 'scope' parameter, using default value.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        }
    }
    
    NSError *error;
    BOOL success = [[GANTracker sharedTracker] setCustomVariableAtIndex:index name:name value:value scope:scope withError:&error];
    if (error != nil) logEvent(context, kError, @"%@", [error localizedDescription]);
    
    @try
    {
        result = [FREConversionUtil convertBoolean:success];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to create the return value.\n(Exception[name:%@, reason:%@, method:%@])", [exception name], [exception reason], __FUNCTION__);
        return NULL;
    }
    
    return result;
}

DEFINE_ANE_FUNCTION(getCustomVar)
{
    if (argv == NULL || argc < 1) {
        logEvent(context, kFatal, @"Invalid arguments number for method '%s'", __func__);
        return NULL;
    }
    
    FREObject result = NULL;
    
    NSUInteger index;
    NSString *name;
    
    @try
    {
        index = [FREConversionUtil extractInt:argv[0]];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to read the 'index' parameter.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
        return NULL;
    }
    
    name = [[GANTracker sharedTracker] getVisitorCustomVarAtIndex:index];
    
    @try
    {
        result = [FREConversionUtil convertString:name];
    }
    @catch (NSException *exception)
    {
        logEvent(context, kFatal, @"Unable to create the return value.\n(Exception[name:%@, reason:%@, method:%s])", [exception name], [exception reason], __func__);
    }
    
    return result;
}

@end
