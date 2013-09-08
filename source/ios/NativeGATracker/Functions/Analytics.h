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

#import <Foundation/Foundation.h>
#import "FREConversionUtil.h"
#import "FREUtils.h"
#import "GAI.h"

@interface Analytics : NSObject

DEFINE_ANE_FUNCTION(createTracker);
DEFINE_ANE_FUNCTION(closeTracker);
DEFINE_ANE_FUNCTION(setDebug);
DEFINE_ANE_FUNCTION(getDebug);
DEFINE_ANE_FUNCTION(setOptOut);
DEFINE_ANE_FUNCTION(getOptOut);
DEFINE_ANE_FUNCTION(setDispatchInterval);
DEFINE_ANE_FUNCTION(dispatch);

@end