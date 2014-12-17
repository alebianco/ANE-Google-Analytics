//
//  GAExtension.m
//  NativeGATracker
//
//  Created by Alessandro Bianco on 06/06/2014.
//  Copyright (c) 2014 Alessandro Bianco. All rights reserved.
//

#import "GAExtension.h"

@implementation GAExtension

void GAExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    extDataToSet = NULL;
    *ctxInitializerToSet = &GAContextInitializer;
    *ctxFinalizerToSet = &GAContextFinalizer;
}

void GAExtensionFinalizer() {
    return;
}

@end
