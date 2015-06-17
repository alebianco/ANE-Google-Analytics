/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/12/12 14:37
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import "Tracker.h"
#import "GAIFields.h"
#import "GAIEcommerceFields.h"
#import "GAILogger.h"
#import "GAIEcommerceProduct.h"
#import "GAITracker.h"

FREObject trackView(FREContext context, id tracker, FREObject *data);
FREObject trackEvent(FREContext context, id tracker, FREObject *data);
FREObject trackException(FREContext context, id tracker, FREObject *data);
FREObject trackSocial(FREContext context, id tracker, FREObject *data);
FREObject trackTiming(FREContext context, id tracker, FREObject *data);
FREObject trackTransaction(FREContext context, id tracker, FREObject *data);
//GAITransactionItem *getProductAt(NSUInteger index, FREObject array);

kHitType hitTypeStringToEnum(NSString *name) {
    NSArray *hitTypeArray = [[[NSArray alloc] initWithObjects:kHitTypeArray, nil] autorelease];
    NSUInteger n = [hitTypeArray indexOfObject:name];
    if (n < 1) n = NONE;
    return (kHitType) n;
}

@implementation Tracker

DEFINE_ANE_FUNCTION(getAnonymous) {
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
    
    @try {
        result = [FREConversionUtil fromBoolean:[tracker get:kGAIAnonymizeIp]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}

DEFINE_ANE_FUNCTION(setAnonymous) {
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
    
    BOOL flag;
    @try {
        flag = [FREConversionUtil toBoolean:argv[1]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'flag' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'flag' parameter on method '%s'.", __FUNCTION__);
    }
    
    [tracker set:kGAIAnonymizeIp value:flag];
    
    return result;
}

DEFINE_ANE_FUNCTION(getSecure) {
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
    
    @try {
        result = [FREConversionUtil fromBoolean:[tracker get:kGAIUseSecure]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}

DEFINE_ANE_FUNCTION(setSecure) {
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
    
    BOOL flag;
    @try {
        flag = [FREConversionUtil toBoolean:argv[1]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'flag' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'flag' parameter on method '%s'.", __FUNCTION__);
    }
    
    [tracker set:kGAIUseSecure value:flag];
    
    return result;
}

DEFINE_ANE_FUNCTION(getSampleRate) {
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
    
    @try {
        result = [FREConversionUtil fromString:[tracker get:kGAISampleRate]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}

DEFINE_ANE_FUNCTION(setSampleRate) {
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
    
    NSString *rate;
    @try {
        rate = [FREConversionUtil toString:argv[1]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'rate' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'rate' parameter on method '%s'.", __FUNCTION__);
    }
    
    [tracker set:kGAISampleRate value:rate];
    
    return result;
}

DEFINE_ANE_FUNCTION(startNewSession) {
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

    //Starts a new session with sending event "UX: appstart"
    [tracker send:[[[GAIDictionaryBuilder createEventWithCategory:@"UX" action:@"appstart" label:nil value:nil] set:@"start" forKey:kGAISessionControl] build]];

    return result;
}

DEFINE_ANE_FUNCTION(trackData) {
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

    NSString *type;
    @try {
        type = [FREConversionUtil toString:argv[1]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'type' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'type' parameter on method '%s'.", __FUNCTION__);
    }

    switch (hitTypeStringToEnum(type)) {
        case VIEW:
            return trackView(context, tracker, argv[2]);
        case EVENT:
            return trackEvent(context, tracker, argv[2]);
        case EXCEPTION:
            return trackException(context, tracker, argv[2]);
        case TIMING:
            return trackTiming(context, tracker, argv[2]);
        case SOCIAL:
            return trackSocial(context, tracker, argv[2]);
        default:
            FRE_logEvent(context, kWarn, @"Hit type not recognised: %@", type);
            break;
    }

    return result;
}

DEFINE_ANE_FUNCTION(setCustomMetric) {
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
    
    NSInteger index;
    @try {
        index = [FREConversionUtil toInt:argv[1]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'index' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'index' parameter on method '%s'.", __FUNCTION__);
    }
    
    NSNumber *value;
    @try {
        value = [FREConversionUtil toNumber:argv[2]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'value' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'value' parameter on method '%s'.", __FUNCTION__);
    }

    [tracker set:[GAIFields customMetricForIndex:index] value:[value stringValue]];

    return result;
}

DEFINE_ANE_FUNCTION(setCustomDimension) {
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
    
    NSInteger index;
    @try {
        index = [FREConversionUtil toInt:argv[1]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'index' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'index' parameter on method '%s'.", __FUNCTION__);
    }
    
    NSString *value;
    @try {
        value = [FREConversionUtil toString:argv[2]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'value' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'value' parameter on method '%s'.", __FUNCTION__);
    }

    [tracker set:[GAIFields customDimensionForIndex:index] value:value];
    
    return result;
}

DEFINE_ANE_FUNCTION(clearCustomMetric) {
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
    
    NSInteger index;
    @try {
        index = [FREConversionUtil toInt:argv[1]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'index' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'index' parameter on method '%s'.", __FUNCTION__);
    }

    [tracker set:[GAIFields customMetricForIndex:index] value:nil];

    return result;
}

DEFINE_ANE_FUNCTION(clearCustomDimension) {
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
    
    NSInteger index;
    @try {
        index = [FREConversionUtil toInt:argv[1]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read the 'index' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'index' parameter on method '%s'.", __FUNCTION__);
    }
    
    [tracker set:[GAIFields customDimensionForIndex:index] value:nil];

    return result;
}

@end

FREObject trackView(FREContext context, id tracker, FREObject *data) {

    NSString *screen;
    @try {
        screen = [FREConversionUtil toString:[FREConversionUtil getProperty:@"screen" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read a property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read a property on method '%s'.", __FUNCTION__);
    }

    [tracker set:kGAIScreenName value:screen];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    return NULL;
}

FREObject trackEvent(FREContext context, id tracker, FREObject *data) {

    NSString *category;
    NSString *action;
    NSString *label;
    NSNumber *value;

    @try {
        category = [FREConversionUtil toString:[FREConversionUtil getProperty:@"category" fromObject:data]];
        action = [FREConversionUtil toString:[FREConversionUtil getProperty:@"action" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read a property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read a property on method '%s'.", __FUNCTION__);
    }

    @try {
        label = [FREConversionUtil toString:[FREConversionUtil getProperty:@"label" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kInfo, @"Unable to read a property, falling back to default value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        label = nil;
    }

    @try {
        value = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"value" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kInfo, @"Unable to read a property, falling back to default value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        value = nil;
    }

    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category action:action label:label value:value] build]];

    return NULL;
}

FREObject trackException(FREContext context, id tracker, FREObject *data) {

    BOOL fatal;
    NSString *description;

    @try {
        fatal = [FREConversionUtil toBoolean:[FREConversionUtil getProperty:@"fatal" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read a property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read a property on method '%s'.", __FUNCTION__);
    }

    @try {
        description = [FREConversionUtil toString:[FREConversionUtil getProperty:@"description" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kInfo, @"Unable to read a property, falling back to default description. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        description = @"";
    }

    [tracker send:[[GAIDictionaryBuilder createExceptionWithDescription:description withFatal:fatal] build]];
    return NULL;
}

FREObject trackTiming(FREContext context, id tracker, FREObject *data) {

    NSString *category;
    NSNumber *interval;
    NSString *name;
    NSString *label;

    @try {
        category = [FREConversionUtil toString:[FREConversionUtil getProperty:@"category" fromObject:data]];
        interval = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"interval" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read a property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read a property on method '%s'.", __FUNCTION__);
    }

    @try {
        name = [FREConversionUtil toString:[FREConversionUtil getProperty:@"name" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kInfo, @"Unable to read a property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        name = nil;
    }

    @try {
        label = [FREConversionUtil toString:[FREConversionUtil getProperty:@"label" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kInfo, @"Unable to read a property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        label = nil;
    }

    [tracker send:[[GAIDictionaryBuilder createTimingWithCategory:category interval:interval name:name label:label] build]];
    
    return NULL;
}

FREObject trackSocial(FREContext context, id tracker, FREObject *data) {

    NSString *network;
    NSString *action;
    NSString *content;

    @try {
        network = [FREConversionUtil toString:[FREConversionUtil getProperty:@"network" fromObject:data]];
        action = [FREConversionUtil toString:[FREConversionUtil getProperty:@"action" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read a property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read a property on method '%s'.", __FUNCTION__);
    }

    @try {
        content = [FREConversionUtil toString:[FREConversionUtil getProperty:@"content" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kInfo, @"Unable to read a property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        content = nil;
    }

    [tracker send:[[GAIDictionaryBuilder createSocialWithNetwork:network action:action target:content] build]];
     
    return NULL;
}

FREObject trackTransaction(FREContext context, id tracker, FREObject *data) {
    
    NSString *id;
    NSNumber *cost;
    NSString *affiliation;
    NSNumber *shipping;
    NSNumber *tax;
    NSString *currency;
    
    NSUInteger prodc;
    FREObject *products;
    
    @try {
        id = [FREConversionUtil toString:[FREConversionUtil getProperty:@"id" fromObject:data]];
        cost = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"cost" fromObject:data]];
        products = [FREConversionUtil getProperty:@"products" fromObject:data];
        prodc = [FREConversionUtil getArrayLength:products];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kFatal, @"Unable to read a property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read a property on method '%s'.", __FUNCTION__);
    }
    
    @try {
        affiliation = [FREConversionUtil toString:[FREConversionUtil getProperty:@"affiliation" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kInfo, @"Unable to read a property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        affiliation = nil;
    }
    
    @try {
        shipping = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"shipping" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kInfo, @"Unable to read a property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        shipping = nil;
    }
    
    @try {
        tax = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"tax" fromObject:data]];
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kInfo, @"Unable to read a property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        tax = nil;
    }
    
    @try {
        currency = [FREConversionUtil toString:[FREConversionUtil getProperty:@"currency" fromObject:data]];
        FRE_logEvent(context, kWarn, @"Currency codes are not supported by the current iOS implementation, this parameter will be ignored.");
    }
    @catch (NSException *exception) {
        FRE_logEvent(context, kInfo, @"Unable to read a property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        currency = nil;
    }
    
    //[tracker send:[[GAIDictionaryBuilder createTransactionWithId:(NSString *) affiliation:<#(NSString *)#> revenue:<#(NSNumber *)#> tax:<#(NSNumber *)#> shipping:<#(NSNumber *)#> currencyCode:<#(NSString *)#>]]]
    
    //GAITransaction *transaction = [GAITransaction transactionWithId:id withAffiliation:affiliation];
    //transaction.revenueMicros = (int64_t) [[NSNumber numberWithFloat:[cost floatValue] * 1000000] integerValue];
    //if (tax != nil)
    //    transaction.taxMicros = (int64_t) [[NSNumber numberWithFloat:[tax floatValue] * 1000000] integerValue];
    //if (shipping != nil)
    //    transaction.shippingMicros = (int64_t) [[NSNumber numberWithFloat:[shipping floatValue] * 1000000] integerValue];
    
    //@try {
    //    for (NSUInteger i = 0; i < prodc; i++) {
    //        GAITransactionItem *item = getProductAt(i, products);
    //        [transaction addItem:item];
    //    }
    //}
    //@catch (NSException *exception) {
    //    FRE_logEvent(context, kFatal, @"Unable to read a property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
    //    return createRuntimeException(@"ArgumentError", 0, @"Unable to read a property on method '%s'.", __FUNCTION__);
    //}
    
    //[tracker sendTransaction:transaction];
    
    return NULL;
}

//GAITransactionItem *getProductAt(NSUInteger index, FREObject array) {
//
//    FREObject *product = [FREConversionUtil getArrayItemAt:index on:array];
//
//    NSString *sku = [FREConversionUtil toString:[FREConversionUtil getProperty:@"sku" fromObject:product]];
//    NSString *name = [FREConversionUtil toString:[FREConversionUtil getProperty:@"name" fromObject:product]];
//    NSNumber *price = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"price" fromObject:product]];
//    NSInteger quantity = [FREConversionUtil toInt:[FREConversionUtil getProperty:@"quantity" fromObject:product]];
//
//    NSString *category;
//    @try {
//        category = [FREConversionUtil toString:[FREConversionUtil getProperty:@"sku" fromObject:product]];
//    }
//    @catch (NSException *exception) {
//        category = nil;
//    }
//
//    return [GAITransactionItem itemWithCode:sku name:name category:category priceMicros:(int64_t) [[NSNumber numberWithFloat:[price floatValue] * 1000000] integerValue] quantity:quantity];
//}


