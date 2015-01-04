//
//  GAIsSupported.m
//  ANELytics
//
//  Created by Alessandro Bianco on 15/12/2014.
//  Copyright (c) 2014 Alessandro Bianco. All rights reserved.
//

#import "GAIsSupported.h"

@implementation GAIsSupported

DEFINE_FUNCTION(isSupported) {
    FREObject result;
    
    @try {
        result = [GATypeConverter fromBoolean:YES];
    }
    @catch (NSException *exception) {
        // TODO handle exception
    }
    
    return result;
}

@end
