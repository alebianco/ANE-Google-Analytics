//
//  GAGetVersion.m
//  ANELytics
//
//  Created by Alessandro Bianco on 15/12/2014.
//  Copyright (c) 2014 Alessandro Bianco. All rights reserved.
//

#import "GAGetVersion.h"

@implementation GAGetVersion

DEFINE_FUNCTION(getVersion) {
    FREObject result;

    @try {
        NSString *name = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        result = [GATypeConverter fromString:[NSString stringWithFormat:@"%@ v%@", name, version]];
    }
    @catch (NSException *exception) {
        // TODO handle exception
    }
    
    return result;
}

@end
