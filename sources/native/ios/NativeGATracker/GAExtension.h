//
//  GAExtension.h
//  NativeGATracker
//
//  Created by Alessandro Bianco on 06/06/2014.
//  Copyright (c) 2014 Alessandro Bianco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "GAContext.h"

@interface GAExtension : NSObject

void GAExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet,FREContextFinalizer *ctxFinalizerToSet);
void GAExtensionFinalizer();

@end
