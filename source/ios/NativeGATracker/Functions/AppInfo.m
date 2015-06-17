/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/12/12 14:22
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import "AppInfo.h"
#import "GAIFields.h"

@implementation AppInfo

DEFINE_ANE_FUNCTION(setAppName) {
    FREObject result = NULL;

    NSString *trackingId;
    @try {
        trackingId = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'trackingId' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'trackingId' parameter on method '%s'.", __FUNCTION__);
    }

    id tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];

    NSString *name;
    @try {
        name = [FREConversionUtil toString:argv[1]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'name' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'name' parameter on method '%s'.", __FUNCTION__);
    }

    [tracker set:kGAIAppName value:name];

    return result;
}

DEFINE_ANE_FUNCTION(GA_setAppVersion) {
    FREObject result = NULL;
    
    NSString *trackingId;
    @try {
        trackingId = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'trackingId' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'trackingId' parameter on method '%s'.", __FUNCTION__);
    }
    
    id tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];
    
    NSString *version;
    @try {
        version = [FREConversionUtil toString:argv[1]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'version' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'version' parameter on method '%s'.", __FUNCTION__);
    }
    
    [tracker set:kGAIAppVersion value:version];
    
    return result;
}

DEFINE_ANE_FUNCTION(setAppID) {
    FREObject result = NULL;

    NSString *trackingId;
    @try {
        trackingId = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'trackingId' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'trackingId' parameter on method '%s'.", __FUNCTION__);
    }

    id tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];

    NSString *id;
    @try {
        id = [FREConversionUtil toString:argv[1]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'id' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'id' parameter on method '%s'.", __FUNCTION__);
    }

    [tracker set:kGAIAppId value:id];

    return result;
}

DEFINE_ANE_FUNCTION(getAppID) {
    FREObject result = NULL;

    NSString *trackingId;
    @try {
        trackingId = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'trackingId' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'trackingId' parameter on method '%s'.", __FUNCTION__);
    }

    id tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];
    
    if ([tracker get:kGAIAppId] != nil) {
        @try {
            result = [FREConversionUtil fromString:[tracker get:kGAIAppId]];
        }
        @catch (NSException *exception) {
            FRE_logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
            return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
        }
    }

    return result;
}

@end
