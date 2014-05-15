/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 01/04/14 11:16
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import <Foundation/Foundation.h>
#import "FREConversionUtil.h"
#import "FREUtils.h"
#import "GAI.h"

@interface Campaign : NSObject

DEFINE_ANE_FUNCTION(getCampaignData);
DEFINE_ANE_FUNCTION(setCampaignData);
DEFINE_ANE_FUNCTION(getReferrer);
DEFINE_ANE_FUNCTION(setReferrer);

@end