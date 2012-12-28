/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/12/12 10.45
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import "IsSupported.h"

@implementation IsSupported

DEFINE_ANE_FUNCTION(isSupported) {
    FREObject result = NULL;

    @try {
        result = [FREConversionUtil fromBoolean:YES];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }

    return result;
}

@end
