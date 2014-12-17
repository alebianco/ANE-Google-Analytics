//
//  GAContext.h
//  NativeGATracker
//
//  Created by Alessandro Bianco on 15/12/2014.
//  Copyright (c) 2014 Alessandro Bianco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "GAMacros.h"
#import "Functions/GAIsSupported.h"
#import "Functions/GAInitialise.h"
#import "Functions/GAGetVersion.h"

@interface GAContext : NSObject

void GAContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet);
void GAContextFinalizer(FREContext ctx);

@end
