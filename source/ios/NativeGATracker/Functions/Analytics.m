/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/12/12 10.54
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import "Analytics.h"

@implementation Analytics

DEFINE_ANE_FUNCTION(createTracker) {
    FREObject result = NULL;

    NSString *trackingId;
    @try {
        trackingId = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to read the 'trackingId' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'trackingId' parameter on method '%s'.", __FUNCTION__);
    }

    id tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];
    [tracker setSessionTimeout:-1];

    return result;
}
DEFINE_ANE_FUNCTION(closeTracker) {
    FREObject result = NULL;

    NSString *trackingId;
    @try {
        trackingId = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to read the 'trackingId' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'trackingId' parameter on method '%s'.", __FUNCTION__);
    }

    id tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];
    [tracker close];

    return result;
}
DEFINE_ANE_FUNCTION(setDebug) {
    FREObject result = NULL;

    BOOL value;
    @try {
        value = [FREConversionUtil toBoolean:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to read the 'value' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'value' parameter on method '%s'.", __FUNCTION__);
    }

    [[GAI sharedInstance] setDebug:value];

    return result;
}
DEFINE_ANE_FUNCTION(getDebug) {
    FREObject result = NULL;

    BOOL value = [[GAI sharedInstance] debug];

    @try {
        result = [FREConversionUtil fromBoolean:value];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }

    return result;
}
DEFINE_ANE_FUNCTION(setOptOut) {
    FREObject result = NULL;

    BOOL value;
    @try {
        value = [FREConversionUtil toBoolean:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to read the 'value' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'value' parameter on method '%s'.", __FUNCTION__);
    }

    [[GAI sharedInstance] setOptOut:value];

    return result;
}
DEFINE_ANE_FUNCTION(getOptOut) {
    FREObject result = NULL;

    BOOL value = [[GAI sharedInstance] optOut];

    @try {
        result = [FREConversionUtil fromBoolean:value];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }

    return result;
}
DEFINE_ANE_FUNCTION(setDispatchInterval) {
    FREObject result = NULL;

    NSInteger interval;
    @try {
        interval = [FREConversionUtil toInt:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to read the 'interval' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'interval' parameter on method '%s'.", __FUNCTION__);
    }

    [[GAI sharedInstance] setDispatchInterval:interval];

    return result;
}
DEFINE_ANE_FUNCTION(dispatch) {
    FREObject result = NULL;

    [[GAI sharedInstance] dispatch];

    return result;
}

@end