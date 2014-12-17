//
//  GAGetVersion.m
//  NativeGATracker
//
//  Created by Alessandro Bianco on 15/12/2014.
//  Copyright (c) 2014 Alessandro Bianco. All rights reserved.
//

#import "GAGetVersion.h"

@implementation GAGetVersion

DEFINE_FUNCTION(getVersion) {
    FREObject result;
    
    @try {
        result = [GAUtils fromString:"hello iOS extension"];
    }
    @catch (NSException *exception) {
        // TODO handle exception
    }
    
    return result;
}

@end
