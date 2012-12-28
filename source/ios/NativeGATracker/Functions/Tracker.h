/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 12/27/12 14:37
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import <Foundation/Foundation.h>
#import "FREConversionUtil.h"
#import "FREUtils.h"
#import "GAI.h"

typedef enum {
    NONE,
    VIEW,
    EVENT,
    EXCEPTION,
    TIMING,
    SOCIAL,
    TRANSACTION
} kHitType;
#define kHitTypeArray @"NONE",@"VIEW",@"EVENT",@"EXCEPTION",@"TIMING",@"SOCIAL",@"TRANSACTION",nil

@interface Tracker : NSObject

DEFINE_ANE_FUNCTION(getAnonymous);
DEFINE_ANE_FUNCTION(setAnonymous);
DEFINE_ANE_FUNCTION(getSecure);
DEFINE_ANE_FUNCTION(setSecure);
DEFINE_ANE_FUNCTION(getSampleRate);
DEFINE_ANE_FUNCTION(setSampleRate);
DEFINE_ANE_FUNCTION(startNewSession);
DEFINE_ANE_FUNCTION(trackData);
DEFINE_ANE_FUNCTION(setCustomMetric);
DEFINE_ANE_FUNCTION(setCustomDimension);
DEFINE_ANE_FUNCTION(clearCustomMetric);
DEFINE_ANE_FUNCTION(clearCustomDimension);

@end